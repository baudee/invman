import 'package:flutter/material.dart';
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
  final int _nextPageTrigger = 5;

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
    return BaseStateComponent(
      state: controller.state,
      successBuilder: (_) => RefreshIndicator(
        onRefresh: controller.refresh,
        child: Builder(
          builder: (context) {
            final items = controller.state.value.requireValue;
            if (items.isEmpty && controller.isLastPage.watch(context)) {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    child: Center(
                      child:
                          noItemsFoundWidget ??
                          Text(S.of(context).core_noItemsFound, style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                ],
              );
            }

            return ListView.separated(
              shrinkWrap: shrinkWrap,
              reverse: reverse,
              physics: physics ?? const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
              itemCount:
                  controller.state.watch(context).requireValue.length + (controller.isLastPage.watch(context) ? 0 : 1),
              itemBuilder: (context, index) {
                if (index == (items.length - _nextPageTrigger) && controller.eligibleForFetchingData.value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.fetchData();
                  });
                }

                if (index == items.length) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    if (index == 0 || (items.length == index + 1)) const SizedBox(height: UIConstants.spacingXs),
                    Material(color: Colors.transparent, child: itemBuilder(items[index])),
                  ],
                );
              },
            );
          },
        ),
      ),
      onReload: controller.refresh,
    );
  }
}
