import 'package:go_router/go_router.dart';

extension GoRouterExtensions on GoRouter {
  Future<T?> pushRelative<T>(String path) {
    String currentPath = state.uri.path;
    return push<T>(currentPath + path);
  }
}
