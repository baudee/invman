import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/core/core.dart';

class SliverInfiniteListComponent<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String? noItemsFoundMessage;
  final Widget header;

  const SliverInfiniteListComponent({
    super.key,
    required this.header,
    required this.pagingController,
    required this.itemBuilder,
    this.noItemsFoundMessage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        header,
        PagedSliverList.separated(
          pagingController: pagingController,
          separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
          builderDelegate: pagedChildBuilderDelegate<T>(
            itemBuilder: itemBuilder,
            pagingController: pagingController,
            noItemsFoundMessage: noItemsFoundMessage,
          ),
        ),
      ],
    );
  }
}
