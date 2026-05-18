import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/repositories/repositories.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class AccountController implements Disposable {
  final AccountRepository _accountRepository;
  final CurrencyRepository _currencyRepository;
  final InvestmentRepository _investmentRepository;
  final TransferRepository _transferRepository;
  final TransferImportRepository _transferImportRepository;
  final AuthManager _authManager;

  AccountController(
    this._accountRepository,
    this._currencyRepository,
    this._investmentRepository,
    this._transferRepository,
    this._transferImportRepository,
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
        await _saveCsvToUserLocation(csv, 'transfers_export.csv');
        return null;
      },
    );
  }

  /// Picks a CSV file and parses it into a preview.
  /// Returns Right(preview) on success, Left(error) on failure, or Right(null) if cancelled.
  Future<Either<String, TransferImportPreview?>> pickAndParseImport() async {
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (pickerResult == null || pickerResult.files.single.path == null) {
      return right(null);
    }

    final csvContent = await File(pickerResult.files.single.path!).readAsString();
    final result = await _transferImportRepository.parsePreview(csvContent);
    return result.map((preview) => preview);
  }

  Future<String?> shareTemplate() async {
    final result = await _transferImportRepository.downloadTemplate();
    return result.fold((error) => error, (csv) async {
      await _saveCsvToUserLocation(csv, 'transfers_template.csv');
      return null;
    });
  }

  Future<void> _saveCsvToUserLocation(String csv, String fileName) async {
    final bytes = utf8.encode(csv);
    final savedPath = await FilePicker.platform.saveFile(
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: ['csv'],
      bytes: bytes,
    );
    // On desktop, file_picker returns the chosen path without writing; on mobile it already wrote the bytes.
    if (savedPath != null && !Platform.isAndroid && !Platform.isIOS) {
      await File(savedPath).writeAsBytes(bytes);
    }
  }

  @override
  FutureOr<dynamic> onDispose() {
    _state.dispose();
  }
}
