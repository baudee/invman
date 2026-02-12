import 'package:invman_client/invman_client.dart';

extension DoubleExtension on double {
  String toStringPrice(Currency? currency) {
    return "${toStringAsFixed(1)} ${currency?.code ?? ''}";
  }
}
