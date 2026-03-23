import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/auth/auth.dart';

extension AuthExtensions on AuthManager {
  String get currencyCode => account.value?.currency?.code ?? "-";
  Currency? get currency => account.value?.currency;
}
