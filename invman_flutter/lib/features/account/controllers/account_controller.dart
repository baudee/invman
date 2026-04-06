import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/repositories/repositories.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class AccountController implements Disposable {
  final AccountRepository _accountRepository;
  final CurrencyRepository _currencyRepository;
  final InvestmentRepository _investmentRepository;
  final TransferRepository _transferRepository;
  final AuthManager _authManager;

  AccountController(
    this._accountRepository,
    this._currencyRepository,
    this._investmentRepository,
    this._transferRepository,
    this._authManager,
  ) {
    _load();
  }

  final _state = asyncSignal<List<Currency>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Currency>>> get state => _state;
  final _selectedCurrency = signal<Currency?>(null);
  ReadonlySignal<Currency?> get selectedCurrency => _selectedCurrency;

  Future<void> _load() async {
    _state.value = AsyncState.loading();
    final result = await _currencyRepository.list();
    result.fold(
      (error) => _state.value = AsyncState.error(error),
      (currencies) {
        _state.value = AsyncState.data(currencies);
        _selectedCurrency.value = currencies.where((c) => c.code == _authManager.currencyCode).firstOrNull;
      },
    );
  }

  Future<String?> changeCurrency(Currency currency) async {
    if (currency.id == _authManager.currency?.id) {
      return null;
    }
    final oldCurrency = _authManager.currency;
    _selectedCurrency.value = null;

    final account = _authManager.account.value;
    if (account == null) {
      return S.current.error_code(ErrorCode.badRequest);
    }
    final newAccount = account.copyWith(currencyId: currency.id, currency: currency);
    final result = await _accountRepository.save(newAccount);
    return result.fold(
      (error) {
        _selectedCurrency.value = oldCurrency;
        return error;
      },
      (_) {
        _selectedCurrency.value = currency;
        _authManager.replaceMe(newAccount);
        _investmentRepository.saveInvalidate();
        return null;
      },
    );
  }

  /// Returns null on success, an error message on failure.
  Future<String?> exportCsv() async {
    final result = await _transferRepository.exportCsv();
    return result.fold(
      (error) => error,
      (csv) async {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/transfers_export.csv');
        await file.writeAsString(csv);
        await Share.shareXFiles([XFile(file.path)]);
        return null;
      },
    );
  }

  /// Picks a CSV file and imports its content.
  /// Returns null on success, an error message on failure, or a non-empty
  /// list of validation errors if the file has invalid rows.
  Future<({String? error, List<String> validationErrors, bool cancelled})> importCsv() async {
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (pickerResult == null || pickerResult.files.single.path == null) {
      return (error: null, validationErrors: <String>[], cancelled: true);
    }

    final csvContent = await File(pickerResult.files.single.path!).readAsString();
    final result = await _transferRepository.importCsv(csvContent);

    return result.fold(
      (error) => (error: error, validationErrors: <String>[], cancelled: false),
      (errors) => (error: null, validationErrors: errors, cancelled: false),
    );
  }

  Future<void> shareTemplate() async {
    const template = 'investmentId,quantity,amount,date\n1,10.5,1050.00,2025-03-15\n2,5.0,500.00,03/15/2025\n';
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/transfers_template.csv');
    await file.writeAsString(template);
    await Share.shareXFiles([XFile(file.path)]);
  }

  @override
  FutureOr<dynamic> onDispose() {
    _state.dispose();
  }
}
