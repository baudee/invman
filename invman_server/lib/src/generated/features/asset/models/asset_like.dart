/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' as _i2;
import '../../../features/asset/models/asset.dart' as _i3;
import 'package:invman_server/src/generated/protocol.dart' as _i4;

abstract class AssetLike implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AssetLike._({
    this.id,
    required this.userId,
    this.user,
    required this.assetId,
    this.asset,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AssetLike({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required _i1.UuidValue assetId,
    _i3.Asset? asset,
    DateTime? createdAt,
  }) = _AssetLikeImpl;

  factory AssetLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssetLike(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      assetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['assetId'],
      ),
      asset: jsonSerialization['asset'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Asset>(jsonSerialization['asset']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AssetLikeTable();

  static const db = AssetLikeRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  _i2.AuthUser? user;

  _i1.UuidValue assetId;

  _i3.Asset? asset;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AssetLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssetLike copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    _i1.UuidValue? assetId,
    _i3.Asset? asset,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssetLike',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'assetId': assetId.toJson(),
      if (asset != null) 'asset': asset?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AssetLike',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'assetId': assetId.toJson(),
      if (asset != null) 'asset': asset?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static AssetLikeInclude include({
    _i2.AuthUserInclude? user,
    _i3.AssetInclude? asset,
  }) {
    return AssetLikeInclude._(
      user: user,
      asset: asset,
    );
  }

  static AssetLikeIncludeList includeList({
    _i1.WhereExpressionBuilder<AssetLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetLikeTable>? orderByList,
    AssetLikeInclude? include,
  }) {
    return AssetLikeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssetLike.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AssetLike.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssetLikeImpl extends AssetLike {
  _AssetLikeImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required _i1.UuidValue assetId,
    _i3.Asset? asset,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         assetId: assetId,
         asset: asset,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AssetLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssetLike copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? assetId,
    Object? asset = _Undefined,
    DateTime? createdAt,
  }) {
    return AssetLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      assetId: assetId ?? this.assetId,
      asset: asset is _i3.Asset? ? asset : this.asset?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AssetLikeUpdateTable extends _i1.UpdateTable<AssetLikeTable> {
  AssetLikeUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> assetId(_i1.UuidValue value) => _i1.ColumnValue(
    table.assetId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) => _i1.ColumnValue(
    table.createdAt,
    value,
  );
}

class AssetLikeTable extends _i1.Table<int?> {
  AssetLikeTable({super.tableRelation}) : super(tableName: 'asset_like') {
    updateTable = AssetLikeUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    assetId = _i1.ColumnUuid(
      'assetId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AssetLikeUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.AuthUserTable? _user;

  late final _i1.ColumnUuid assetId;

  _i3.AssetTable? _asset;

  late final _i1.ColumnDateTime createdAt;

  _i2.AuthUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: AssetLike.t.userId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.AssetTable get asset {
    if (_asset != null) return _asset!;
    _asset = _i1.createRelationTable(
      relationFieldName: 'asset',
      field: AssetLike.t.assetId,
      foreignField: _i3.Asset.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i3.AssetTable(tableRelation: foreignTableRelation),
    );
    return _asset!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    assetId,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'asset') {
      return asset;
    }
    return null;
  }
}

class AssetLikeInclude extends _i1.IncludeObject {
  AssetLikeInclude._({
    _i2.AuthUserInclude? user,
    _i3.AssetInclude? asset,
  }) {
    _user = user;
    _asset = asset;
  }

  _i2.AuthUserInclude? _user;

  _i3.AssetInclude? _asset;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'asset': _asset,
  };

  @override
  _i1.Table<int?> get table => AssetLike.t;
}

class AssetLikeIncludeList extends _i1.IncludeList {
  AssetLikeIncludeList._({
    _i1.WhereExpressionBuilder<AssetLikeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AssetLike.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AssetLike.t;
}

class AssetLikeRepository {
  const AssetLikeRepository._();

  final attachRow = const AssetLikeAttachRowRepository._();

  /// Returns a list of [AssetLike]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<AssetLike>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetLikeTable>? orderByList,
    _i1.Transaction? transaction,
    AssetLikeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AssetLike>(
      where: where?.call(AssetLike.t),
      orderBy: orderBy?.call(AssetLike.t),
      orderByList: orderByList?.call(AssetLike.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AssetLike] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<AssetLike?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetLikeTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssetLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetLikeTable>? orderByList,
    _i1.Transaction? transaction,
    AssetLikeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AssetLike>(
      where: where?.call(AssetLike.t),
      orderBy: orderBy?.call(AssetLike.t),
      orderByList: orderByList?.call(AssetLike.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AssetLike] by its [id] or null if no such row exists.
  Future<AssetLike?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssetLikeInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AssetLike>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AssetLike]s in the list and returns the inserted rows.
  ///
  /// The returned [AssetLike]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AssetLike>> insert(
    _i1.DatabaseSession session,
    List<AssetLike> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AssetLike>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AssetLike] and returns the inserted row.
  ///
  /// The returned [AssetLike] will have its `id` field set.
  Future<AssetLike> insertRow(
    _i1.DatabaseSession session,
    AssetLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AssetLike>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AssetLike]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AssetLike>> update(
    _i1.DatabaseSession session,
    List<AssetLike> rows, {
    _i1.ColumnSelections<AssetLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AssetLike>(
      rows,
      columns: columns?.call(AssetLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssetLike]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AssetLike> updateRow(
    _i1.DatabaseSession session,
    AssetLike row, {
    _i1.ColumnSelections<AssetLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AssetLike>(
      row,
      columns: columns?.call(AssetLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssetLike] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AssetLike?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AssetLikeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AssetLike>(
      id,
      columnValues: columnValues(AssetLike.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AssetLike]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AssetLike>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssetLikeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AssetLikeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetLikeTable>? orderBy,
    _i1.OrderByListBuilder<AssetLikeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AssetLike>(
      columnValues: columnValues(AssetLike.t.updateTable),
      where: where(AssetLike.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssetLike.t),
      orderByList: orderByList?.call(AssetLike.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AssetLike]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AssetLike>> delete(
    _i1.DatabaseSession session,
    List<AssetLike> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AssetLike>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AssetLike].
  Future<AssetLike> deleteRow(
    _i1.DatabaseSession session,
    AssetLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AssetLike>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AssetLike>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssetLikeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AssetLike>(
      where: where(AssetLike.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetLikeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AssetLike>(
      where: where?.call(AssetLike.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AssetLike] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssetLikeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AssetLike>(
      where: where(AssetLike.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssetLikeAttachRowRepository {
  const AssetLikeAttachRowRepository._();

  /// Creates a relation between the given [AssetLike] and [AuthUser]
  /// by setting the [AssetLike]'s foreign key `userId` to refer to the [AuthUser].
  Future<void> user(
    _i1.DatabaseSession session,
    AssetLike assetLike,
    _i2.AuthUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (assetLike.id == null) {
      throw ArgumentError.notNull('assetLike.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $assetLike = assetLike.copyWith(userId: user.id);
    await session.db.updateRow<AssetLike>(
      $assetLike,
      columns: [AssetLike.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AssetLike] and [Asset]
  /// by setting the [AssetLike]'s foreign key `assetId` to refer to the [Asset].
  Future<void> asset(
    _i1.DatabaseSession session,
    AssetLike assetLike,
    _i3.Asset asset, {
    _i1.Transaction? transaction,
  }) async {
    if (assetLike.id == null) {
      throw ArgumentError.notNull('assetLike.id');
    }
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }

    var $assetLike = assetLike.copyWith(assetId: asset.id);
    await session.db.updateRow<AssetLike>(
      $assetLike,
      columns: [AssetLike.t.assetId],
      transaction: transaction,
    );
  }
}
