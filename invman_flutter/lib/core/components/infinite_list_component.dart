import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class InfiniteListComponent<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Function() handleRefresh;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String? noItemsFoundMessage;
  final bool shrinkWrap;
  final bool reverse;
  final bool? useRefreshIndicator;

  const InfiniteListComponent({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.handleRefresh,
    this.noItemsFoundMessage,
    this.shrinkWrap = false,
    this.reverse = false,
    this.useRefreshIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    final pageListView = PagedListView(
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: itemBuilder,
        firstPageErrorIndicatorBuilder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).error_code(pagingController.error)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => handleRefresh(),
                child: Text(S.of(context).error_tryAgain),
              ),
            ],
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return Center(child: Text(noItemsFoundMessage ?? S.of(context).core_noItemsFound));
        },
      ),
    );
    if (useRefreshIndicator ?? true) {
      return RefreshIndicator(
        onRefresh: () => handleRefresh(),
        child: pageListView,
      );
    } else {
      return pageListView;
    }
  }
}
