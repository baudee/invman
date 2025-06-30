import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension RelativePath on BuildContext {
  void pushRelative(String path) {
    String currentPath = GoRouterState.of(this).uri.path;
    push(currentPath + path);
  }
}
