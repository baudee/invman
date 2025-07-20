import 'package:go_router/go_router.dart';

extension GoRouterExtensions on GoRouter {
  void pushRelative(String path) {
    String currentPath = state.uri.path;
    push(currentPath + path);
  }
}
