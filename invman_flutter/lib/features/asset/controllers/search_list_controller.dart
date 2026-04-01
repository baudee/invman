import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/asset/repositories/asset_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class AssetSearchListController extends PaginationController<Asset> {
  final _query = Signal<String>('');
  ReadonlySignal<String> get query => _query.readonly();
  final _type = Signal<AssetType?>(null);
  ReadonlySignal<AssetType?> get type => _type.readonly();
  final _exchange = Signal<String?>(null);
  ReadonlySignal<String?> get exchange => _exchange.readonly();

  final AssetRepository _repository;

  EffectCleanup? _cleanup;
  String _lastQuery = '';
  AssetType? _lastType;
  String? _lastExchange;

  AssetSearchListController(this._repository) {
    _lastQuery = _query.value;
    _lastType = _type.value;
    _lastExchange = _exchange.value;
    _cleanup = effect(() {
      final q = _query.value;
      final t = _type.value;
      final e = _exchange.value;
      if (q != _lastQuery || t != _lastType || e != _lastExchange) {
        _lastQuery = q;
        _lastType = t;
        _lastExchange = e;
        refresh();
      }
    });
  }

  void setQuery(String query) => _query.value = query;
  void setType(AssetType? type) => _type.value = type;
  void setExchange(String? exchange) => _exchange.value = exchange;

  @override
  Future<Either<String, List<Asset>>> fetchPage(int page, int limit) {
    return _repository.list(
      filter: AssetFilter(query: _query.value, type: _type.value, exchange: _exchange.value),
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
  }
}
