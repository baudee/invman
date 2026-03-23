import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

T useController<T extends Disposable>(
  T Function() factory, [
  List<Object?> keys = const [],
]) {
  // Store it
  final controller = useMemoized(factory, keys);

  // Clean it
  useEffect(() => controller.onDispose, [controller]);

  return controller;
}
