import 'package:invman_client/invman_client.dart';

class InitialUtils {
  static Stock getStock() {
    return Stock(
      id: 0,
      name: '',
      symbol: '',
      currency: '',
      stockExchange: '',
      exchangeShortName: '',
    );
  }

  static Transfer getTransfer() {
    return Transfer(
      id: 0,
      quantity: 0,
      userId: 0,
      stockId: 0,
      amount: 0,
    );
  }
}
