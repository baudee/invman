import 'package:invman_client/invman_client.dart';

extension AssetExtension on Asset {
  bool get isLiked => likes?.isNotEmpty ?? false;
}
