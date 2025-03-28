import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

extension ErrorCodeExtension on ErrorCode {
  String get message => S.current.error_code(name);
}
