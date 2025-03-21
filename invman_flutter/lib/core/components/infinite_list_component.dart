import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
        noItemsFoundIndicatorBuilder: (context) {
          return Center(child: Text(noItemsFoundMessage ?? "No results found."));
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
