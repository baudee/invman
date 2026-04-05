import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/asset/repositories/asset_repository.dart';
import 'package:invman_flutter/features/onboarding/repositories/currency_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class AssetSearchListController extends PaginationController<Asset> {
  final _query = Signal<String>('');
  ReadonlySignal<String> get query => _query.readonly();
  final _type = Signal<AssetType?>(null);
  ReadonlySignal<AssetType?> get type => _type.readonly();
  final _exchange = Signal<String?>(null);
  ReadonlySignal<String?> get exchange => _exchange.readonly();
  final _currency = Signal<Currency?>(null);
  ReadonlySignal<Currency?> get currency => _currency.readonly();
  final _currencies = Signal<List<Currency>>([]);
  ReadonlySignal<List<Currency>> get currencies => _currencies.readonly();

  final AssetRepository _repository;
  final CurrencyRepository _currencyRepository;

  EffectCleanup? _cleanup;
  String _lastQuery = '';
  AssetType? _lastType;
  String? _lastExchange;
  Currency? _lastCurrency;

  AssetSearchListController(this._repository, this._currencyRepository) {
    _lastQuery = _query.value;
    _lastType = _type.value;
    _lastExchange = _exchange.value;
    _lastCurrency = _currency.value;
    _currencyRepository.list().then((result) {
      result.fold((l) => null, (list) => _currencies.value = list);
    });
    _cleanup = effect(() {
      final q = _query.value;
      final t = _type.value;
      final e = _exchange.value;
      final c = _currency.value;
      if (q != _lastQuery || t != _lastType || e != _lastExchange || c != _lastCurrency) {
        _lastQuery = q;
        _lastType = t;
        _lastExchange = e;
        _lastCurrency = c;
        refresh();
      }
    });
  }

  void setQuery(String query) => _query.value = query;
  void setType(AssetType? type) => _type.value = type;
  void setExchange(String? exchange) => _exchange.value = exchange;
  void setCurrency(Currency? currency) => _currency.value = currency;

  @override
  Future<Either<String, List<Asset>>> fetchPage(int page, int limit) {
    return _repository.list(
      filter: AssetFilter(
        query: _query.value,
        type: _type.value,
        exchange: _exchange.value,
        currencyId: _currency.value?.id,
      ),
      page: page,
      limit: limit,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cleanup?.call();
    _query.dispose();
    _type.dispose();
    _exchange.dispose();
    _currency.dispose();
    _currencies.dispose();
  }
}
