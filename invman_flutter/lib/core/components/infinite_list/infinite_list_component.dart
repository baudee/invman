import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';

class InfiniteListComponent<T> extends StatelessWidget {
  final PaginationController<T> controller;
  final Widget Function(T item) itemBuilder;
  final bool shrinkWrap;
  final bool reverse;

  const InfiniteListComponent({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.shrinkWrap = false,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = controller.value.value ?? [];
    final more = controller.hasMore();
    return RefreshIndicator(
      onRefresh: controller.reload,
      child: ListView.separated(
        itemCount: () {
          if (more) return items.length + 1;
          return items.length;
        }(),
        itemBuilder: (context, index) {
          if (more && index == items.length) {
            controller.checkForMore();
            return LoadingComponent();
          }
          return itemBuilder(items[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
        shrinkWrap: shrinkWrap,
        reverse: reverse,
      ),
    );
  }
}
