import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/core/components/components.dart';

class SliverInfiniteListComponent<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String? noItemsFoundMessage;
  final Widget header;
  final bool useRefreshIndicator;

  const SliverInfiniteListComponent({
    super.key,
    required this.header,
    required this.pagingController,
    required this.itemBuilder,
    this.noItemsFoundMessage,
    this.useRefreshIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    return OptionalRefreshIndicator(
      useRefreshIndicator: useRefreshIndicator,
      onRefresh: () => Future.sync(() => pagingController.refresh()),
      child: CustomScrollView(
        slivers: [
          header,
          PagedSliverList(
            pagingController: pagingController,
            builderDelegate: pagedChildBuilderDelegate<T>(
              itemBuilder: itemBuilder,
              pagingController: pagingController,
              noItemsFoundMessage: noItemsFoundMessage,
            ),
          ),
        ],
      ),
    );
  }
}
