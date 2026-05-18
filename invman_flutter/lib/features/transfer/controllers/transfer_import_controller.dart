import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/investment/repositories/repositories.dart';
import 'package:invman_flutter/features/transfer/repositories/repositories.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class TransferImportController {
  final TransferImportRepository _importRepository;
  final InvestmentRepository _investmentRepository;
  final WithdrawalRuleRepository _withdrawalRuleRepository;

  TransferImportController(
    this._importRepository,
    this._investmentRepository,
    this._withdrawalRuleRepository,
  );

  final _rows = signal<List<TransferImportRow>>([]);
  ReadonlySignal<List<TransferImportRow>> get rows => _rows;

  final _globalErrorKey = signal<TransferImportGlobalError?>(null);
  ReadonlySignal<TransferImportGlobalError?> get globalErrorKey => _globalErrorKey;

  final _globalErrorContext = signal<String?>(null);
  ReadonlySignal<String?> get globalErrorContext => _globalErrorContext;

  final _submitting = signal<bool>(false);
  ReadonlySignal<bool> get submitting => _submitting;

  final _withdrawalRules = signal<List<WithdrawalRule>>([]);
  ReadonlySignal<List<WithdrawalRule>> get withdrawalRules => _withdrawalRules;

  // Stable grouping: assigned at init from each row's initial natural key and
  // never recomputed afterwards, so user edits don't reorder groups.
  final Map<int, String> _groupKeyByLine = {};
  final List<String> _groupOrder = [];

  void init(TransferImportPreview preview) {
    _rows.value = List.of(preview.rows);
    _globalErrorKey.value = preview.globalErrorKey;
    _globalErrorContext.value = preview.globalErrorContext;
    _submitting.value = false;
    _groupKeyByLine.clear();
    _groupOrder.clear();
    for (final row in preview.rows) {
      _groupKeyByLine[row.lineNumber] = row.groupId;
      if (!_groupOrder.contains(row.groupId)) {
        _groupOrder.add(row.groupId);
      }
    }
    _loadWithdrawalRules();
  }

  void reset() {
    _rows.value = [];
    _globalErrorKey.value = null;
    _globalErrorContext.value = null;
    _submitting.value = false;
    _groupKeyByLine.clear();
    _groupOrder.clear();
  }

  Future<void> _loadWithdrawalRules() async {
    final result = await _withdrawalRuleRepository.list(page: 1, limit: 1000);
    result.fold((_) {}, (rules) => _withdrawalRules.value = rules);
  }

  WithdrawalRule? findWithdrawalRule(int? id) {
    if (id == null) return null;
    return _withdrawalRules.value.where((r) => r.id == id).firstOrNull;
  }

  late final unresolvedCount = computed(
    () => _rows.value.where((r) => r.status == TransferImportRowStatus.needsAttention).length,
  );

  late final canConfirm = computed(() => _rows.value.isNotEmpty && unresolvedCount.value == 0 && !_submitting.value);

  /// Groups current row indices by the stable group key assigned at init.
  List<List<int>> groupedIndices() {
    final byKey = <String, List<int>>{};
    for (int i = 0; i < _rows.value.length; i++) {
      final key = _groupKeyByLine[_rows.value[i].lineNumber];
      if (key == null) continue;
      byKey.putIfAbsent(key, () => []).add(i);
    }
    return _groupOrder.where(byKey.containsKey).map((k) => byKey[k]!).toList();
  }

  void _replaceRow(int index, TransferImportRow row) {
    if (index < 0 || index >= _rows.value.length) return;
    final next = List.of(_rows.value);
    next[index] = _revalidate(row);
    _rows.value = next;
  }

  void setResolution(int index, TransferImportRowResolution resolution) {
    final row = _rows.value[index];
    if (row.resolution == resolution) return;
    _replaceRow(
      index,
      row.copyWith(
        resolution: resolution,
        existingInvestmentId: resolution == TransferImportRowResolution.existingInvestment
            ? row.existingInvestmentId
            : null,
        existingInvestmentName: resolution == TransferImportRowResolution.existingInvestment
            ? row.existingInvestmentName
            : null,
      ),
    );
  }

  void setExistingInvestment(int index, Investment investment) {
    final row = _rows.value[index];
    _replaceRow(
      index,
      row.copyWith(
        resolution: TransferImportRowResolution.existingInvestment,
        existingInvestmentId: investment.id,
        existingInvestmentName: investment.name,
        asset: investment.asset,
      ),
    );
  }

  void setNewInvestmentName(int index, String name) {
    final row = _rows.value[index];
    _replaceRow(index, row.copyWith(newInvestmentName: name));
  }

  void setAsset(int index, Asset asset) {
    final row = _rows.value[index];
    _replaceRow(index, row.copyWith(asset: asset, assetCandidates: null));
  }

  void setWithdrawalRule(int index, int? withdrawalRuleId) {
    final row = _rows.value[index];
    _replaceRow(index, row.copyWith(newInvestmentWithdrawalRuleId: withdrawalRuleId));
  }

  void setQuantity(int index, double? quantity) {
    final row = _rows.value[index];
    _replaceRow(index, row.copyWith(quantity: quantity));
  }

  void setAmount(int index, double? amount) {
    final row = _rows.value[index];
    _replaceRow(index, row.copyWith(amount: amount));
  }

  void setDate(int index, DateTime date) {
    final row = _rows.value[index];
    _replaceRow(index, row.copyWith(date: DateTime(date.year, date.month, date.day)));
  }

  void deleteRow(int index) {
    if (index < 0 || index >= _rows.value.length) return;
    final lineNumber = _rows.value[index].lineNumber;
    final next = List.of(_rows.value)..removeAt(index);
    _rows.value = next;
    _groupKeyByLine.remove(lineNumber);
    final stillUsed = _groupKeyByLine.values.toSet();
    _groupOrder.removeWhere((k) => !stillUsed.contains(k));
  }

  /// Returns null on success, an error message on failure.
  Future<String?> confirm() async {
    if (!canConfirm.value) {
      return S.current.error_fixToContinue;
    }
    _submitting.value = true;
    final result = await _importRepository.confirm(_rows.value);
    _submitting.value = false;
    return result.fold(
      (error) => error,
      (_) {
        _investmentRepository.saveInvalidate();
        return null;
      },
    );
  }

  TransferImportRow _revalidate(TransferImportRow row) {
    TransferImportRowError? investmentErrorKey;
    String? investmentErrorContext;

    if (row.resolution == TransferImportRowResolution.existingInvestment) {
      if (row.existingInvestmentId == null) {
        final back = row.investmentErrorKey;
        if (back == TransferImportRowError.invalidExistingInvestmentId ||
            back == TransferImportRowError.existingInvestmentNotFound) {
          investmentErrorKey = back;
          investmentErrorContext = row.investmentErrorContext;
        } else {
          investmentErrorKey = TransferImportRowError.idAndNameMissing;
        }
      }
    } else {
      final name = row.newInvestmentName;
      if (name == null || name.trim().isEmpty) {
        investmentErrorKey = TransferImportRowError.newInvestmentNameRequired;
      } else if (row.asset == null) {
        final back = row.investmentErrorKey;
        if (back == TransferImportRowError.noAssetForSymbol ||
            back == TransferImportRowError.multipleAssetsForSymbol ||
            back == TransferImportRowError.symbolRequired) {
          investmentErrorKey = back;
          investmentErrorContext = row.investmentErrorContext;
        } else {
          investmentErrorKey = TransferImportRowError.assetRequired;
        }
      }
    }

    TransferImportRowError? rowErrorKey;
    String? rowErrorContext;
    if (row.quantity == null) {
      rowErrorKey = TransferImportRowError.invalidQuantity;
      rowErrorContext = row.rowErrorContext;
    } else if (row.amount == null) {
      rowErrorKey = TransferImportRowError.invalidAmount;
      rowErrorContext = row.rowErrorContext;
    } else if (row.date == null) {
      rowErrorKey = TransferImportRowError.invalidDate;
      rowErrorContext = row.rowErrorContext;
    }

    final hasError = investmentErrorKey != null || rowErrorKey != null;

    return row.copyWith(
      status: hasError ? TransferImportRowStatus.needsAttention : TransferImportRowStatus.ok,
      investmentErrorKey: investmentErrorKey,
      investmentErrorContext: investmentErrorContext,
      rowErrorKey: rowErrorKey,
      rowErrorContext: rowErrorContext,
    );
  }
}

/// Translation helpers shared by the screen and components.
String? translateRowError(TransferImportRowError? key, String? context) {
  if (key == null) return null;
  final s = S.current;
  final ctx = context ?? '';
  switch (key) {
    case TransferImportRowError.idAndNameMissing:
      return s.transferImport_rowError_idAndNameMissing;
    case TransferImportRowError.invalidExistingInvestmentId:
      return s.transferImport_rowError_invalidExistingInvestmentId(ctx);
    case TransferImportRowError.existingInvestmentNotFound:
      return s.transferImport_rowError_existingInvestmentNotFound(ctx);
    case TransferImportRowError.newInvestmentNameRequired:
      return s.transferImport_rowError_newInvestmentNameRequired;
    case TransferImportRowError.assetRequired:
      return s.transferImport_rowError_assetRequired;
    case TransferImportRowError.symbolRequired:
      return s.transferImport_rowError_symbolRequired;
    case TransferImportRowError.noAssetForSymbol:
      return s.transferImport_rowError_noAssetForSymbol(ctx);
    case TransferImportRowError.multipleAssetsForSymbol:
      return s.transferImport_rowError_multipleAssetsForSymbol(ctx);
    case TransferImportRowError.invalidQuantity:
      return s.transferImport_rowError_invalidQuantity(ctx);
    case TransferImportRowError.invalidAmount:
      return s.transferImport_rowError_invalidAmount(ctx);
    case TransferImportRowError.invalidDate:
      return s.transferImport_rowError_invalidDate(ctx);
  }
}

String? translateGlobalError(TransferImportGlobalError? key, String? context) {
  if (key == null) return null;
  final s = S.current;
  switch (key) {
    case TransferImportGlobalError.fileEmpty:
      return s.transferImport_globalError_fileEmpty;
    case TransferImportGlobalError.noDataRows:
      return s.transferImport_globalError_noDataRows;
    case TransferImportGlobalError.missingColumns:
      return s.transferImport_globalError_missingColumns(context ?? '');
  }
}
