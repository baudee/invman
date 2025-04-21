import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/models/models.dart';

class BaseStateComponent<T> extends ConsumerWidget {
  final Widget Function(T data) successBuilder;
  final ModelState<T> state;
  final Function()? onRefresh;

  const BaseStateComponent({
    super.key,
    required this.state,
    required this.successBuilder,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (state) {
      Initial() || Loading() => const Center(child: CircularProgressIndicator()),
      Success(:final data) => successBuilder(data),
      Failure(:final error) => ErrorComponent(
          error: error,
          handleRefresh: () {
            onRefresh?.call();
          }),
    };
  }
}
