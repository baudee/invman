import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BaseStateAppbar<T> extends StatelessWidget implements PreferredSizeWidget {
  final ReadonlySignal<AsyncState<T>> state;
  final PreferredSizeWidget Function(T data) successBuilder;
  final double height;

  const BaseStateAppbar({super.key, required this.state, required this.successBuilder, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return state
        .watch(context)
        .map(data: (data) => successBuilder(data), error: (error, _) => AppBar(), loading: () => AppBar());
  }
}
