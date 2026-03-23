import 'package:invman_client/invman_client.dart';

extension StockExtension on Stock {
  bool get isLiked => likes?.isNotEmpty ?? false;
}
