import 'package:invman_server/src/core/services/mail/mail.dart';
import 'package:invman_server/src/di.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());

  // DEPENDENCY INJECTION
  configureDependencies(pod.runMode);

  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
    authUsersConfig: AuthUsersConfig(
      onAfterAuthUserCreated: (session, authUser, {required transaction}) async {
        final account = Account(userId: authUser.id);
        await Account.db.insertRow(
          session,
          account,
          transaction: transaction,
        );
      },
    ),
  );

  // Start the server.
  await pod.start();
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log('Registration verification code $verificationCode to $email', level: LogLevel.debug);
  getIt<MailServiceInterface>().sendEmail(
    to: email,
    subject: 'Your registration verification code',
    body: 'Your verification code is: <b>$verificationCode</b>',
  );
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log('Password reset verification code $verificationCode to $email', level: LogLevel.debug);
  getIt<MailServiceInterface>().sendEmail(
    to: email,
    subject: 'Your password reset verification code',
    body: 'Your verification code is: <b>$verificationCode</b>',
  );
}
