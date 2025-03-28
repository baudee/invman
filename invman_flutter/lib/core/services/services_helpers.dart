import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/extensions/extensions.dart';

Future<Either<String, T>> safeCall<T>(Future<Either<String, T>> Function() action) async {
  try {
    return await action();
  } on ServerException catch (e) {
    return left(e.errorCode.message);
  } catch (e, st) {
    // TODO: Log error to Sentry or another logging service
    return left(ErrorCode.unknown.message);
  }
}
