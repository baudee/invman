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

  AssetSearchListController(this._repository, this._currencyRepository) {
    _currencyRepository.list().then((result) {
      result.fold((l) => null, (list) => _currencies.value = list);
    });
  }

  void setQuery(String query) {
    _query.value = query;
    if (query.isEmpty || query.trim().length >= 2) refresh();
  }

  void setType(AssetType? type) {
    _type.value = type;
    refresh();
  }

  void setExchange(String? exchange) {
    _exchange.value = exchange;
    refresh();
  }

  void setCurrency(Currency? currency) {
    _currency.value = currency;
    refresh();
  }

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
    _query.dispose();
    _type.dispose();
    _exchange.dispose();
    _currency.dispose();
    _currencies.dispose();
  }
}
