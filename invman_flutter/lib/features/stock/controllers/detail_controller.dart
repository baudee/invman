import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockDetailController extends FutureSignal<Stock> {
  final UuidValue uuid;
  final StockService _stockService;

  StockDetailController(@factoryParam this.uuid, this._stockService) : super(() => _stockService.retrieve(uuid));
}
