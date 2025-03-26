import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_client/invman_client.dart' as c;
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_provider.g.dart';

enum StockListType {
  all,
  search,
}

@Riverpod(keepAlive: true)
class StockList extends _$StockList {
  final PagingController<int, c.Stock> pagingController = PagingController(firstPageKey: 1);

  @override
  PagingStatus build(StockListType type) {
    if (type == StockListType.search) {
      fetchPage(1);
      ref.listen(stockSearchProvider, (previous, next) {
        fetchPage(1, query: next);
      });
      return PagingStatus.completed;
    } else {
      pagingController.addPageRequestListener((page) {
        fetchPage(page);
      });

      pagingController.addStatusListener((status) {
        state = status;
      });
      return PagingStatus.loadingFirstPage;
    }
  }

  Future<void> fetchPage(int page, {int limit = 10, String query = ''}) async {
    late final Either<String, c.StockList> result;

    switch (type) {
      case StockListType.search:
        if (query.isEmpty) {
          pagingController.itemList = [];
          return;
        }
        result = await ref.read(stockServiceProvider).search(query: query, limit: limit);
        result.fold((error) {}, (data) {
          pagingController
            ..itemList = data.results
            ..nextPageKey = null;
        });
        return;
      case StockListType.all:
        result = await ref.read(stockServiceProvider).list(page: page, limit: limit);
        break;
    }

    result.fold((error) {}, (data) {
      if (data.canLoadMore) {
        pagingController.appendPage(data.results, data.page + 1);
      } else {
        pagingController.appendLastPage(data.results);
      }
    });
  }

  void refresh() async {
    pagingController.refresh();
  }
}
