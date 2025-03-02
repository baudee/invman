import 'package:get_it/get_it.dart';
import 'package:invman_server/src/env.dart';

final GetIt getIt = GetIt.instance;

void initDependencyInjection() {
  getIt.registerSingleton<Env>(Env());
}
