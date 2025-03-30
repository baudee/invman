import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';

class SliverInfiniteListComponent<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Function() handleRefresh;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String? noItemsFoundMessage;
  final Widget header;
  final bool? useRefreshIndicator;

  const SliverInfiniteListComponent({
    super.key,
    required this.header,
    required this.pagingController,
    required this.itemBuilder,
    required this.handleRefresh,
    this.noItemsFoundMessage,
    this.useRefreshIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    final customScrollView = CustomScrollView(
      slivers: [
        header,
        PagedSliverList(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: itemBuilder,
            firstPageErrorIndicatorBuilder: (context) {
              return ErrorComponent(
                error: S.of(context).error_code(pagingController.error),
                handleRefresh: handleRefresh,
              );
            },
            noItemsFoundIndicatorBuilder: (context) {
              return Center(child: Text(noItemsFoundMessage ?? S.of(context).core_noItemsFound));
            },
          ),
        )
      ],
    );
    if (useRefreshIndicator ?? true) {
      return RefreshIndicator(
        onRefresh: () => handleRefresh(),
        child: customScrollView,
      );
    } else {
      return customScrollView;
    }
  }
}
