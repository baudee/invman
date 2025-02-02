import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'package:invman_server/src/web/routes/root.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // DEPENDENCY INJECTION
  //initDependencyInjection();

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

        final message = "Here is your verification code: $validationCode";
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
