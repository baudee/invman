import 'package:injectable/injectable.dart' hide Order;
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class LikeService {
  LikeService();

  Future<void> like(Session session, UuidValue assetId) async {
    final userId = (session.authenticated)!.authUserId;

    final existingLike = await AssetLike.db.findFirstRow(
      session,
      where: (e) => e.userId.equals(userId) & e.assetId.equals(assetId),
    );

    if (existingLike != null) {
      return;
    }

    await AssetLike.db.insertRow(
      session,
      AssetLike(userId: userId, assetId: assetId),
    );
  }

  Future<void> unlike(Session session, UuidValue assetId) async {
    final userId = (session.authenticated)!.authUserId;

    final existingLike = await AssetLike.db.findFirstRow(
      session,
      where: (e) => e.userId.equals(userId) & e.assetId.equals(assetId),
    );

    if (existingLike == null) {
      return;
    }

    await AssetLike.db.deleteRow(session, existingLike);
  }
}
