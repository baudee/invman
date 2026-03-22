import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InfiniteSliverListComponent<T> extends StatelessWidget {
  final PaginationController<T> controller;
  final Widget Function(T item) itemBuilder;
  final Widget? noItemsFoundWidget;
  final int _nextPageTrigger = 5;

  const InfiniteSliverListComponent({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.noItemsFoundWidget,
  });

  @override
  Widget build(BuildContext context) {
    final state = controller.state.watch(context);
    if (state.hasError) {
      return SliverToBoxAdapter(
        child: ErrorComponent(
          error: S.of(context).error_tryAgain,
          handleRefresh: controller.refresh,
        ),
      );
    } else if (state.hasValue) {
      return _buildList(context);
    } else {
      return const SliverToBoxAdapter(child: LoadingComponent());
    }
  }

  Widget _buildList(BuildContext context) {
    final items = controller.state.watch(context).requireValue;

    if (items.isEmpty && controller.isLastPage.watch(context)) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: noItemsFoundWidget ?? Text(S.of(context).core_noItemsFound, style: Theme.of(context).textTheme.titleMedium),
        ),
      );
    }

    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
      itemCount: items.length + (controller.isLastPage.watch(context) ? 0 : 1),
      itemBuilder: (context, index) {
        if (index == (items.length - _nextPageTrigger) && controller.eligibleForFetchingData.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.fetchData();
          });
        }

        if (index == items.length) {
          return const SizedBox.shrink();
        }

        return Material(color: Colors.transparent, child: itemBuilder(items[index]));
      },
    );
  }
}
