import 'package:flutter/material.dart';

class OptionalRefreshIndicator extends StatelessWidget {
  final bool useRefreshIndicator;
  final Widget child;
  final Future<void> Function()? onRefresh;

  const OptionalRefreshIndicator({super.key, required this.useRefreshIndicator, required this.child, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return useRefreshIndicator
        ? RefreshIndicator(
            onRefresh: onRefresh ?? () async {},
            color: Theme.of(context).colorScheme.primary,
            child: child,
          )
        : child;
  }
}
