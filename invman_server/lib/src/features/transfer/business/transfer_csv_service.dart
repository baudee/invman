import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/features/investment/investment.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class TransferCsvService {
  final InvestmentService _investmentService;

  TransferCsvService(this._investmentService);

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

    final buffer = StringBuffer();
    buffer.writeln('investmentId,investmentName,assetSymbol,assetName,assetType,quantity,amount,date');

    for (final transfer in transfers) {
      final investment = investmentMap[transfer.investmentId];
      final asset = investment?.asset;
      final date = _formatDate(transfer.createdAt);
      buffer.writeln(
        '${transfer.investmentId},'
        '${_escapeCsv(investment?.name ?? '')},'
        '${_escapeCsv(asset?.symbol ?? '')},'
        '${_escapeCsv(asset?.name ?? '')},'
        '${asset?.type.name ?? ''},'
        '${transfer.quantity},'
        '${transfer.amount},'
        '$date',
      );
    }

    return buffer.toString();
  }

  Future<List<String>> importCsv(Session session, String csvContent) async {
    final sessionUserId = session.authenticated!.authUserId;

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
    );
    final validInvestmentIds = investments.map((e) => e.id).whereType<int>().toSet();

    final lines = csvContent.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();

    if (lines.isEmpty) {
      return ['The file is empty.'];
    }

    final dataLines = lines.skip(1).toList(); // skip header row

    if (dataLines.isEmpty) {
      return ['No data to import.'];
    }

    final errors = <String>[];
    final toInsert = <Transfer>[];

    for (int i = 0; i < dataLines.length; i++) {
      final lineNumber = i + 2; // +2 because we skip header (line 1)
      final parts = dataLines[i].split(',');

      // We only need the 4 required columns; extra columns (export metadata) are ignored
      if (parts.length < 4) {
        errors.add('Line $lineNumber: invalid format (missing columns).');
        continue;
      }

      final investmentIdRaw = parts[0].trim();
      final quantityRaw = parts[1].trim();
      final amountRaw = parts[2].trim();
      final dateRaw = parts[3].trim();

      final investmentId = int.tryParse(investmentIdRaw);
      if (investmentId == null) {
        errors.add('Line $lineNumber: invalid investmentId "$investmentIdRaw".');
        continue;
      }

      if (!validInvestmentIds.contains(investmentId)) {
        errors.add('Line $lineNumber: investmentId $investmentId not found.');
        continue;
      }

      final quantity = double.tryParse(quantityRaw);
      if (quantity == null) {
        errors.add('Line $lineNumber: invalid quantity "$quantityRaw".');
        continue;
      }

      final amount = double.tryParse(amountRaw);
      if (amount == null) {
        errors.add('Line $lineNumber: invalid amount "$amountRaw".');
        continue;
      }

      final date = _parseDate(dateRaw);
      if (date == null) {
        errors.add('Line $lineNumber: invalid date "$dateRaw" (expected format: YYYY-MM-DD or MM/DD/YYYY).');
        continue;
      }

      toInsert.add(
        Transfer(
          investmentId: investmentId,
          quantity: quantity,
          amount: amount,
          createdAt: date,
        ),
      );
    }

    if (errors.isNotEmpty) {
      return errors;
    }

    await session.db.transaction(
      (transaction) async {
        await Transfer.db.insert(session, toInsert, transaction: transaction);

        final affectedInvestmentIds = toInsert.map((t) => t.investmentId).toSet();
        for (final investmentId in affectedInvestmentIds) {
          await _investmentService.refresh(session, investmentId, transaction: transaction);
        }
      },
      settings: TransactionSettings(isolationLevel: IsolationLevel.serializable),
    );

    for (final investmentId in toInsert.map((t) => t.investmentId).toSet()) {
      await session.caches.local.invalidateKey(CacheKeys.transfersAll(investmentId));
    }

    return [];
  }

  DateTime? _parseDate(String raw) {
    final iso = DateTime.tryParse(raw);
    if (iso != null) return iso;

    // Try MM/DD/YYYY
    final parts = raw.split('/');
    if (parts.length == 3) {
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

  String _escapeCsv(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }
}
