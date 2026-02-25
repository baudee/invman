import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InfiniteSliverListComponent<T> extends StatelessWidget {
  final PaginationController<T> controller;
  final Widget Function(T item) itemBuilder;
  final Widget? noItemsFoundWidget;

  const InfiniteSliverListComponent({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.noItemsFoundWidget,
  });

  @override
  Widget build(BuildContext context) {
    final state = controller.state.watch(context);

    return PagedSliverList<int, T>.separated(
      state: state,
      fetchNextPage: controller.fetchNextPage,
      separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: (context, item, index) => Material(color: Colors.transparent, child: itemBuilder(item)),
        firstPageProgressIndicatorBuilder: (_) => const LoadingComponent(),
        newPageProgressIndicatorBuilder: (_) => const LoadingComponent(),
        firstPageErrorIndicatorBuilder: (context) {
          final exceptionString = state.error;
          final String error;
          if (exceptionString is Exception) {
            error = exceptionString.toString().replaceFirst('Exception: ', '');
          } else {
            error = S.of(context).error_tryAgain;
          }
          return ErrorComponent(error: error, handleRefresh: controller.refresh);
        },
        noItemsFoundIndicatorBuilder: (_) => Center(
          child:
              noItemsFoundWidget ??
              Text(S.of(context).core_noItemsFound, style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}
