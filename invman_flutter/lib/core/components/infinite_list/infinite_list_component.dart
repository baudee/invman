import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/core/core.dart';

class InfiniteListComponent<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String? noItemsFoundMessage;
  final bool shrinkWrap;
  final bool reverse;
  final Function onRefresh;

  const InfiniteListComponent({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.onRefresh,
    this.noItemsFoundMessage,
    this.shrinkWrap = false,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => onRefresh()),
      child: PagedListView.separated(
        reverse: reverse,
        shrinkWrap: shrinkWrap,
        pagingController: pagingController,
        separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
        builderDelegate: pagedChildBuilderDelegate<T>(
          itemBuilder: itemBuilder,
          pagingController: pagingController,
          noItemsFoundMessage: noItemsFoundMessage,
        ),
      ),
    );
  }
}
