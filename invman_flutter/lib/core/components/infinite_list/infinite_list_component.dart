import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InfiniteListComponent<T> extends StatelessWidget {
  final PaginationController<T> controller;
  final Widget Function(T item) itemBuilder;
  final bool shrinkWrap;
  final bool reverse;
  final bool refreshIndicator;
  final ScrollPhysics? physics;
  final Widget? noItemsFoundWidget;

  const InfiniteListComponent({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.shrinkWrap = false,
    this.reverse = false,
    this.refreshIndicator = true,
    this.physics,
    this.noItemsFoundWidget,
  });

  @override
  Widget build(BuildContext context) {
    final state = controller.state.watch(context);

    final listView = PagedListView<int, T>.separated(
      state: state,
      fetchNextPage: controller.fetchNextPage,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: (context, item, index) => Material(color: Colors.transparent, child: itemBuilder(item)),
        firstPageProgressIndicatorBuilder: (_) => const LoadingComponent(),
        newPageProgressIndicatorBuilder: (_) => const LoadingComponent(),
        noItemsFoundIndicatorBuilder: (_) => Center(
          child:
              noItemsFoundWidget ??
              Text(S.of(context).core_noItemsFound, style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );

    if (refreshIndicator) {
      return RefreshIndicator(onRefresh: controller.refresh, child: listView);
    } else {
      return listView;
    }
  }
}
