import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/transfer/services/transfer_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class TransferListController {
  final int investmentId;
  final TransferService _service;

  late final PagingController<int, Transfer> pagingController;
  late final Signal<PagingStatus> status;

  TransferListController(
    @factoryParam this.investmentId,
    this._service,
  ) {
    pagingController = PagingController(firstPageKey: 1);
    status = signal(PagingStatus.loadingFirstPage);

    pagingController.addPageRequestListener(_fetchPage);
    pagingController.addStatusListener((s) => status.value = s);
  }

  Future<void> _fetchPage(int page) async {
    final Either<String, TransferList> result = await _service.list(
      investmentId,
      page: page,
      limit: 10,
    );

    result.fold(
      (error) => pagingController.error = error,
      (data) {
        if (data.canLoadMore) {
          pagingController.appendPage(data.results, data.page + 1);
        } else {
          pagingController.appendLastPage(data.results);
        }
      },
    );
  }

  void refresh() => pagingController.refresh();

  void dispose() {
    pagingController.dispose();
    status.dispose();
  }
}
