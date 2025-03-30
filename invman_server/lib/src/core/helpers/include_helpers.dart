import 'package:invman_server/src/generated/protocol.dart';

class IncludeHelpers {
  // Transfer
  static TransferInclude transferInclude() {
    return Transfer.include(
      stock: Stock.include(),
    );
  }
}
