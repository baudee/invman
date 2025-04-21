import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

mixin EndpointMiddleware {
  Future<T> withMiddleware<T>(Session session, Future<T> Function() callback) async {
    try {
      return await callback();
    } on ServerException catch (e, st) {
      if (e.errorCode == ErrorCode.unknown) {
        String message = e.message ?? 'Server error';
        session.log(
          message,
          level: LogLevel.error,
          exception: e,
          stackTrace: st,
        );
      }
      rethrow;
    } catch (e, st) {
      session.log(
        'Unknown error',
        level: LogLevel.fatal,
        exception: e,
        stackTrace: st,
      );
      throw ServerException(errorCode: ErrorCode.unknown);
    }
  }
}
