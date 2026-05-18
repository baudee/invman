import 'package:csv/csv.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/features/investment/investment.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class TransferCsvService {
  final InvestmentService _investmentService;

  TransferCsvService(this._investmentService);

  static const csvHeader = [
    'existingInvestmentId',
    'newInvestmentName',
    'symbol',
    'quantity',
    'amount',
    'date',
  ];

  Future<String> exportCsv(Session session) async {
    final sessionUserId = session.authenticated!.authUserId;

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
    );

    final investmentIds = investments.map((e) => e.id).whereType<int>().toSet();

    List<Transfer> transfers = [];
    if (investmentIds.isNotEmpty) {
      transfers = await Transfer.db.find(
        session,
        where: (e) => e.investmentId.inSet(investmentIds),
        orderBy: (t) => t.createdAt,
      );
    }

    final investmentMap = {for (final inv in investments) inv.id: inv};

    final rows = <List<dynamic>>[csvHeader];
    for (final transfer in transfers) {
      final investment = investmentMap[transfer.investmentId];
      final asset = investment?.asset;
      rows.add([
        transfer.investmentId,
        '', // newInvestmentName — empty on export (round-trip uses existing id)
        asset?.symbol ?? '',
        transfer.quantity,
        transfer.amount,
        _formatDate(transfer.createdAt),
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }

  Future<TransferImportPreview> parseImportPreview(Session session, String csvContent) async {
    final sessionUserId = session.authenticated!.authUserId;

    final parsed = const CsvToListConverter(
      shouldParseNumbers: false,
      eol: '\n',
    ).convert(csvContent.replaceAll('\r\n', '\n'));

    final nonEmptyRows = parsed
        .map((r) => r.map((c) => c.toString().trim()).toList())
        .where((r) => r.any((c) => c.isNotEmpty))
        .toList();

    if (nonEmptyRows.isEmpty) {
      return TransferImportPreview(rows: [], globalErrorKey: TransferImportGlobalError.fileEmpty);
    }

    final header = nonEmptyRows.first;
    final colIndex = <String, int>{};
    for (int i = 0; i < header.length; i++) {
      colIndex[header[i]] = i;
    }

    final missing = csvHeader.where((c) => !colIndex.containsKey(c)).toList();
    if (missing.isNotEmpty) {
      return TransferImportPreview(
        rows: [],
        globalErrorKey: TransferImportGlobalError.missingColumns,
        globalErrorContext: missing.join(', '),
      );
    }

    final dataRows = nonEmptyRows.skip(1).toList();
    if (dataRows.isEmpty) {
      return TransferImportPreview(rows: [], globalErrorKey: TransferImportGlobalError.noDataRows);
    }

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
    );
    final investmentById = {for (final inv in investments) inv.id!: inv};

    final rows = <TransferImportRow>[];
    for (int i = 0; i < dataRows.length; i++) {
      final lineNumber = i + 2;
      final raw = dataRows[i];

      String cell(String name) {
        final idx = colIndex[name]!;
        return idx < raw.length ? raw[idx] : '';
      }

      rows.add(
        await _buildRow(
          session: session,
          lineNumber: lineNumber,
          existingInvestmentIdRaw: cell('existingInvestmentId'),
          newInvestmentNameRaw: cell('newInvestmentName'),
          symbolRaw: cell('symbol'),
          quantityRaw: cell('quantity'),
          amountRaw: cell('amount'),
          dateRaw: cell('date'),
          investmentById: investmentById,
        ),
      );
    }

    return TransferImportPreview(rows: rows);
  }

  Future<TransferImportRow> _buildRow({
    required Session session,
    required int lineNumber,
    required String existingInvestmentIdRaw,
    required String newInvestmentNameRaw,
    required String symbolRaw,
    required String quantityRaw,
    required String amountRaw,
    required String dateRaw,
    required Map<int, Investment> investmentById,
  }) async {
    TransferImportRowError? investmentErrorKey;
    String? investmentErrorContext;
    TransferImportRowResolution resolution;
    int? existingInvestmentId;
    String? existingInvestmentName;
    String? newInvestmentName;
    Asset? asset;
    List<Asset>? assetCandidates;

    final hasExistingId = existingInvestmentIdRaw.isNotEmpty;
    final hasNewName = newInvestmentNameRaw.isNotEmpty;

    if (hasExistingId) {
      // When an id is provided, only the id is considered. Any newInvestmentName
      // in the CSV is ignored; on invalid/unknown id the user can pivot via the picker.
      resolution = TransferImportRowResolution.existingInvestment;
      final id = int.tryParse(existingInvestmentIdRaw);
      if (id == null) {
        investmentErrorKey = TransferImportRowError.invalidExistingInvestmentId;
        investmentErrorContext = existingInvestmentIdRaw;
      } else {
        final investment = investmentById[id];
        if (investment == null) {
          investmentErrorKey = TransferImportRowError.existingInvestmentNotFound;
          investmentErrorContext = id.toString();
        } else {
          existingInvestmentId = id;
          existingInvestmentName = investment.name;
          asset = investment.asset;
        }
      }
    } else if (hasNewName) {
      resolution = TransferImportRowResolution.newInvestment;
      newInvestmentName = newInvestmentNameRaw;
      if (symbolRaw.isEmpty) {
        investmentErrorKey = TransferImportRowError.symbolRequired;
      } else {
        final matches = await _findAssetsBySymbol(session, symbolRaw);
        if (matches.length == 1) {
          asset = matches.first;
        } else if (matches.length > 1) {
          assetCandidates = matches;
          investmentErrorKey = TransferImportRowError.multipleAssetsForSymbol;
          investmentErrorContext = symbolRaw;
        } else {
          investmentErrorKey = TransferImportRowError.noAssetForSymbol;
          investmentErrorContext = symbolRaw;
        }
      }
    } else {
      resolution = TransferImportRowResolution.newInvestment;
      investmentErrorKey = TransferImportRowError.idAndNameMissing;
    }

    final quantity = double.tryParse(quantityRaw);
    final amount = double.tryParse(amountRaw);
    final date = _parseDate(dateRaw);

    TransferImportRowError? rowErrorKey;
    String? rowErrorContext;
    if (quantity == null) {
      rowErrorKey = TransferImportRowError.invalidQuantity;
      rowErrorContext = quantityRaw;
    } else if (amount == null) {
      rowErrorKey = TransferImportRowError.invalidAmount;
      rowErrorContext = amountRaw;
    } else if (date == null) {
      rowErrorKey = TransferImportRowError.invalidDate;
      rowErrorContext = dateRaw;
    }

    final hasError = investmentErrorKey != null || rowErrorKey != null;

    final String groupId;
    if (hasExistingId) {
      groupId = 'existing-$existingInvestmentIdRaw';
    } else if (hasNewName) {
      groupId = 'new-$newInvestmentNameRaw-$symbolRaw';
    } else {
      groupId = 'singleton-$lineNumber';
    }

    return TransferImportRow(
      lineNumber: lineNumber,
      groupId: groupId,
      status: hasError ? TransferImportRowStatus.needsAttention : TransferImportRowStatus.ok,
      resolution: resolution,
      existingInvestmentId: existingInvestmentId,
      existingInvestmentName: existingInvestmentName,
      newInvestmentName: newInvestmentName,
      asset: asset,
      assetCandidates: assetCandidates,
      quantity: quantity,
      amount: amount,
      date: date,
      investmentErrorKey: investmentErrorKey,
      investmentErrorContext: investmentErrorContext,
      rowErrorKey: rowErrorKey,
      rowErrorContext: rowErrorContext,
    );
  }

  Future<List<Asset>> _findAssetsBySymbol(Session session, String symbol) async {
    return Asset.db.find(
      session,
      where: (a) => a.symbol.equals(symbol),
      include: IncludeHelpers.assetInclude(),
    );
  }

  DateTime? _parseDate(String raw) {
    final iso = DateTime.tryParse(raw);
    if (iso != null) return iso;

    final parts = raw.split('/');
    if (parts.length == 3 && parts[2].length == 4) {
      final month = int.tryParse(parts[0]);
      final day = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (month != null && day != null && year != null) {
        return DateTime(year, month, day);
      }
    }

    return null;
  }

  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> confirmImport(Session session, List<TransferImportRow> rows) async {
    final sessionUserId = session.authenticated!.authUserId;

    if (rows.isEmpty) {
      throw ServerException(errorCode: ErrorCode.badRequest, message: 'No rows to import.');
    }

    final userInvestments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
    );
    final userInvestmentIds = userInvestments.map((e) => e.id!).toSet();

    for (final row in rows) {
      _validateRowForConfirm(row, userInvestmentIds);
    }

    // Group new-investment rows by (name, asset, withdrawalRule). Each unique
    // group becomes one investment; all rows in the group share its transfers.
    final newGroups = <String, _NewInvestmentGroup>{};
    for (final row in rows) {
      if (row.resolution != TransferImportRowResolution.newInvestment) continue;
      final key = '${row.newInvestmentName}|${row.asset!.id}|${row.newInvestmentWithdrawalRuleId ?? ''}';
      newGroups
          .putIfAbsent(
            key,
            () => _NewInvestmentGroup(
              name: row.newInvestmentName!,
              assetId: row.asset!.id,
              withdrawalRuleId: row.newInvestmentWithdrawalRuleId,
              rows: [],
            ),
          )
          .rows
          .add(row);
    }

    final affectedInvestmentIds = await session.db.transaction(
      (transaction) async {
        final newInvestmentIdByKey = <String, int>{};
        for (final entry in newGroups.entries) {
          final group = entry.value;
          final created = await Investment.db.insertRow(
            session,
            Investment(
              userId: sessionUserId,
              name: group.name,
              assetId: group.assetId,
              withdrawalRuleId: group.withdrawalRuleId,
            ),
            transaction: transaction,
          );
          newInvestmentIdByKey[entry.key] = created.id!;
        }

        final transfers = <Transfer>[];
        for (final row in rows) {
          final int investmentId;
          if (row.resolution == TransferImportRowResolution.existingInvestment) {
            investmentId = row.existingInvestmentId!;
          } else {
            final key = '${row.newInvestmentName}|${row.asset!.id}|${row.newInvestmentWithdrawalRuleId ?? ''}';
            investmentId = newInvestmentIdByKey[key]!;
          }
          transfers.add(
            Transfer(
              investmentId: investmentId,
              quantity: row.quantity!,
              amount: row.amount!,
              createdAt: row.date!,
            ),
          );
        }

        await Transfer.db.insert(session, transfers, transaction: transaction);

        final affected = transfers.map((t) => t.investmentId).toSet();
        for (final investmentId in affected) {
          await _investmentService.refresh(session, investmentId, transaction: transaction);
        }
        return affected;
      },
      settings: TransactionSettings(isolationLevel: IsolationLevel.serializable),
    );

    for (final investmentId in affectedInvestmentIds) {
      await session.caches.local.invalidateKey(CacheKeys.transfersAll(investmentId));
    }
  }

  void _validateRowForConfirm(TransferImportRow row, Set<int> userInvestmentIds) {
    void fail(String message) {
      throw ServerException(
        errorCode: ErrorCode.badRequest,
        message: 'Line ${row.lineNumber}: $message',
      );
    }

    if (row.quantity == null) fail('quantity is required.');
    if (row.amount == null) fail('amount is required.');
    if (row.date == null) fail('date is required.');

    if (row.resolution == TransferImportRowResolution.existingInvestment) {
      final id = row.existingInvestmentId;
      if (id == null) fail('existingInvestmentId is required.');
      if (!userInvestmentIds.contains(id)) fail('Investment $id not found.');
    } else {
      if (row.newInvestmentName == null || row.newInvestmentName!.isEmpty) {
        fail('newInvestmentName is required.');
      }
      if (row.asset == null) fail('asset is required for a new investment.');
    }
  }

  String template() {
    final rows = <List<dynamic>>[
      csvHeader,
      [1, '', '', 10, 1500, '2024-03-01'],
      ['', 'Apple long term', 'AAPL', 5, 750, '2024-04-15'],
    ];
    return const ListToCsvConverter().convert(rows);
  }
}

class _NewInvestmentGroup {
  final String name;
  final UuidValue assetId;
  final int? withdrawalRuleId;
  final List<TransferImportRow> rows;

  _NewInvestmentGroup({
    required this.name,
    required this.assetId,
    required this.withdrawalRuleId,
    required this.rows,
  });
}
