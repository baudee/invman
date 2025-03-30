import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_client/invman_client.dart' as c;
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_provider.g.dart';

@Riverpod(keepAlive: true)
class TransferList extends _$TransferList {
  final PagingController<int, c.Transfer> pagingController = PagingController(firstPageKey: 1);

  @override
  PagingStatus build() {
    pagingController.addPageRequestListener((page) {
      fetchPage(page);
    });

    pagingController.addStatusListener((status) {
      state = status;
    });
    return PagingStatus.loadingFirstPage;
  }

  Future<void> fetchPage(int page, {int limit = 10}) async {
    final Either<String, c.TransferList> result =
        await ref.read(transferServiceProvider).list(page: page, limit: limit);

    result.fold((error) {
      pagingController.error = error;
    }, (data) {
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
