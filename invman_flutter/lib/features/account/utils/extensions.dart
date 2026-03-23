import 'package:invman_client/invman_client.dart';

extension AccountExtension on Account {
  bool isOnboarded() {
    return currencyId != null;
  }
}
