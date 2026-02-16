import 'package:flutter/material.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BaseStateComponent<T> extends StatelessWidget {
  final Widget Function(T data) successBuilder;
  final AsyncSignal<T> state;

  const BaseStateComponent({
    super.key,
    required this.state,
    required this.successBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return state
        .watch(context)
        .map(
          data: (data) => successBuilder(data),
          error: (error, _) => ErrorComponent(
            error: error,
            handleRefresh: () => state.refresh(),
          ),
          loading: () => const LoadingComponent(),
        );
  }
}
