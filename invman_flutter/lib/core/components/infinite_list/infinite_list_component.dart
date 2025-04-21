import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/components/infinite_list/infinite_list.dart';

class InfiniteListComponent<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String? noItemsFoundMessage;
  final bool shrinkWrap;
  final bool reverse;
  final bool useRefreshIndicator;

  const InfiniteListComponent({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.noItemsFoundMessage,
    this.shrinkWrap = false,
    this.reverse = false,
    this.useRefreshIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    return OptionalRefreshIndicator(
      useRefreshIndicator: useRefreshIndicator,
      onRefresh: () => Future.sync(() => pagingController.refresh()),
      child: PagedListView(
        reverse: reverse,
        shrinkWrap: shrinkWrap,
        pagingController: pagingController,
        builderDelegate: pagedChildBuilderDelegate<T>(
          itemBuilder: itemBuilder,
          pagingController: pagingController,
          noItemsFoundMessage: noItemsFoundMessage,
        ),
      ),
    );
  }
}
