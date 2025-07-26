import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/utils/extensions/extensions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<Either<String, T>> safeCall<T>(Future<Either<String, T>> Function() action) async {
  try {
    return await action();
  } on ServerException catch (e) {
    return left(e.errorCode.message);
  } catch (e, st) {
    await Sentry.captureException(e, stackTrace: st);
    return left(ErrorCode.unknown.message);
  }
}
