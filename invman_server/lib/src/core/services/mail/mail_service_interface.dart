import 'package:injectable/injectable.dart' hide test;
import 'package:invman_server/src/di.dart';

abstract interface class MailServiceInterface {
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  });
}

@development
@test
@Injectable(as: MailServiceInterface)
class DevMailService implements MailServiceInterface {
  @override
  Future<void> sendEmail({required String to, required String subject, required String body}) {
    // Mail not sent in development
    return Future.value();
  }
}
