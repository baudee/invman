import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/detail_controller.dart';
import 'package:invman_flutter/core/utils/ui_utils/toast_utils.dart';
import 'package:invman_flutter/features/stock/extensions/extensions.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockDetailController extends DetailController<UuidValue, Stock> {
  final StockRepository _service;

  StockDetailController(@factoryParam super.id, this._service);

  @override
  Future<Either<String, Stock>> retrieve(UuidValue id) {
    return _service.retrieve(id);
  }

  Future<void> toggleLike() async {
    if (value case AsyncData(value: final stock)) {
      final wasLiked = stock.isLiked;
      final previousLikes = stock.likes;

      final optimisticLikes = wasLiked ? <StockLike>[] : [StockLike(userId: UuidValue.nil, stockId: stock.id)];
      setValue(stock.copyWith(likes: optimisticLikes));

      final result = wasLiked ? await _service.unlike(stock.id) : await _service.like(stock.id);

      result.fold((error) {
        setValue(stock.copyWith(likes: previousLikes));
        ToastUtils.message(error, success: false);
      }, (_) {});
    }
  }
}
