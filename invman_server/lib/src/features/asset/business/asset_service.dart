import 'package:injectable/injectable.dart' hide Order;
import 'package:invman_server/src/core/core.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/features/asset/asset.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class AssetService {
  final AssetValuesSource assetsValuesSource;
  AssetService(this.assetsValuesSource);

  Future<Asset> retrieve(
    Session session,
    UuidValue uuid, {
    Transaction? transaction,
  }) async {
    final userId = session.authenticated!.authUserId;
    Asset? asset = await Asset.db.findById(
      session,
      uuid,
      include: IncludeHelpers.assetInclude(userId: userId),
      transaction: transaction,
    );
    if (asset == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    AssetValue currentValue = await assetsValuesSource.getCurrentValue(session, asset: asset);
    return asset.copyWith(price: currentValue.value, timestamp: currentValue.timestamp);
  }

  Future<List<Asset>> list(
    Session session, {
    required AssetFilter filter,
    required int limit,
    required int page,
  }) async {
    return Asset.db.find(
      session,
      where: _getWhereFromFilter(filter, session.authenticated!.authUserId),
      orderByList: _getOrderListFromFilter(filter),
      limit: limit,
      offset: (page * limit) - limit,
      include: Asset.include(
        currency: Currency.include(),
      ),
    );
  }

  Expression Function(AssetTable)? _getWhereFromFilter(AssetFilter filter, UuidValue userId) {
    final List<Expression> expressions = [];

    return (AssetTable t) {
      if (filter.favorite) {
        expressions.add(t.likes.any((like) => like.userId.equals(userId)));
      }

      if (filter.query.trim().isNotEmpty) {
        final q = "%${filter.query.trim()}%";
        expressions.add(t.symbol.ilike(q) | t.name.ilike(q));
      }

      if (filter.type != null) {
        expressions.add(t.type.equals(filter.type!));
      }

      if (filter.exchange != null) {
        expressions.add(t.exchange.equals(filter.exchange!));
      }

      if (filter.currencyId != null) {
        expressions.add(t.currencyId.equals(filter.currencyId!));
      }

      return expressions.and ?? Constant.bool(true);
    };
  }

  List<Order> Function(AssetTable)? _getOrderListFromFilter(AssetFilter filter) {
    return (AssetTable t) {
      return [
        Order(column: t.investments.count(), orderDescending: true),
        Order(column: t.likes.count(), orderDescending: true),
      ];
    };
  }
}
