import 'package:invman_flutter/features/auth/auth.dart';

extension AuthExtensions on AuthManager {
  String get currencyCode => account.value?.currency?.code ?? "-";
}
