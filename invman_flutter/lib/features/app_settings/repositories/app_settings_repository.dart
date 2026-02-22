import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class AppSettingsRepository {
  final Client client;

  const AppSettingsRepository(this.client);

  Future<Either<String, AppSettings>> get() async {
    return safeCall(() async {
      return right(await client.appSettings.get());
    });
  }
}
