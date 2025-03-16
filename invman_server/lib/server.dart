import 'package:serverpod/serverpod.dart';
import 'package:invman_server/src/web/routes/root.dart';
import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // AUTH
  auth.AuthConfig.set(
    auth.AuthConfig(
      sendValidationEmail: (session, email, validationCode) async {
        print("CODE: $validationCode");
        return true;
      },
      sendPasswordResetEmail: (session, user, validationCode) async {
        print("CODE: $validationCode");

        if (user.email == null) {
          return false;
        }

        //final message = "Here is your verification code: $validationCode";
        //emailService.sendEmail(
        //  toEmail: user.email!,
        //  subject: "Reset Your Password",
        //  text: message,
        //  html: "<p>$message</p>",
        //);
        return true;
      },
      importUserImagesFromGoogleSignIn: true,
    ),
  );

  // Start the server.
  await pod.start();
}
