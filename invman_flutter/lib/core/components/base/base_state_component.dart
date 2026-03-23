import 'package:flutter/material.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BaseStateComponent<T> extends StatelessWidget {
  final Widget Function(T data) successBuilder;
  final ReadonlySignal<AsyncState<T>> state;
  final Function onReload;

  const BaseStateComponent({super.key, required this.state, required this.successBuilder, required this.onReload});

  @override
  Widget build(BuildContext context) {
    return state
        .watch(context)
        .map(
          data: (data) => successBuilder(data),
          error: (error, _) => ErrorComponent(error: error, handleRefresh: onReload),
          loading: () => const LoadingComponent(),
        );
  }
}
