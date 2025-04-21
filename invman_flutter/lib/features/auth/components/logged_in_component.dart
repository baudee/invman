import 'package:flutter/widgets.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class LoggedInComponent extends StatelessWidget {
  const LoggedInComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.of(context).auth_loggedIn),
    );
  }
}
