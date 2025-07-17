import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/core/components/components.dart';

class InfiniteListComponent<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String? noItemsFoundMessage;
  final bool shrinkWrap;
  final bool reverse;

  const InfiniteListComponent({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.noItemsFoundMessage,
    this.shrinkWrap = false,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      pagingController: pagingController,
      builderDelegate: pagedChildBuilderDelegate<T>(
        itemBuilder: itemBuilder,
        pagingController: pagingController,
        noItemsFoundMessage: noItemsFoundMessage,
      ),
    );
  }
}
