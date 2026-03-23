import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

const development = Environment('development');
const staging = Environment('staging');
const production = Environment('production');
const test = Environment('test');

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies(String environment) => getIt.init(environment: environment); 
