import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/controllers/detail_controller.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockDetailController extends DetailController<UuidValue, Stock> {
  final StockRepository _repository;

  StockDetailController(@factoryParam super.id, this._repository);

  @override
  Future<Either<String, Stock>> retrieve(UuidValue id) {
    return _repository.retrieve(id);
  }

  Future<String?> toggleLike() async {
    if (super.state.value case AsyncData(value: final stock)) {
      final wasLiked = stock.isLiked;
      final previousLikes = stock.likes;

      final optimisticLikes = wasLiked
          ? <StockLike>[]
          : [StockLike(userId: UuidValue.fromString(Namespace.nil.value), stockId: stock.id)];
      updateState(stock.copyWith(likes: optimisticLikes));

      final result = wasLiked ? await _repository.unlike(stock.id) : await _repository.like(stock.id);

      return result.fold((error) {
        updateState(stock.copyWith(likes: previousLikes));
        return error;
      }, (_) => null);
    }
    return S.current.error_invalidState;
  }
}
