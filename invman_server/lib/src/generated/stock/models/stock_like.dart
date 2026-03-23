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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i2;
import '../../stock/models/stock.dart' as _i3;
import 'package:invman_server/src/generated/protocol.dart' as _i4;

abstract class StockLike
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StockLike._({
    this.id,
    required this.userId,
    this.user,
    required this.stockId,
    this.stock,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory StockLike({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required _i1.UuidValue stockId,
    _i3.Stock? stock,
    DateTime? createdAt,
  }) = _StockLikeImpl;

  factory StockLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return StockLike(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      stockId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['stockId'],
      ),
      stock: jsonSerialization['stock'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Stock>(jsonSerialization['stock']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = StockLikeTable();

  static const db = StockLikeRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  _i2.AuthUser? user;

  _i1.UuidValue stockId;

  _i3.Stock? stock;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StockLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StockLike copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    _i1.UuidValue? stockId,
    _i3.Stock? stock,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StockLike',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'stockId': stockId.toJson(),
      if (stock != null) 'stock': stock?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StockLike',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'stockId': stockId.toJson(),
      if (stock != null) 'stock': stock?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static StockLikeInclude include({
    _i2.AuthUserInclude? user,
    _i3.StockInclude? stock,
  }) {
    return StockLikeInclude._(
      user: user,
      stock: stock,
    );
  }

  static StockLikeIncludeList includeList({
    _i1.WhereExpressionBuilder<StockLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockLikeTable>? orderByList,
    StockLikeInclude? include,
  }) {
    return StockLikeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StockLike.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StockLike.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StockLikeImpl extends StockLike {
  _StockLikeImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required _i1.UuidValue stockId,
    _i3.Stock? stock,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         stockId: stockId,
         stock: stock,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StockLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StockLike copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? stockId,
    Object? stock = _Undefined,
    DateTime? createdAt,
  }) {
    return StockLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      stockId: stockId ?? this.stockId,
      stock: stock is _i3.Stock? ? stock : this.stock?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StockLikeUpdateTable extends _i1.UpdateTable<StockLikeTable> {
  StockLikeUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> stockId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.stockId,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class StockLikeTable extends _i1.Table<int?> {
  StockLikeTable({super.tableRelation}) : super(tableName: 'stock_like') {
    updateTable = StockLikeUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    stockId = _i1.ColumnUuid(
      'stockId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final StockLikeUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.AuthUserTable? _user;

  late final _i1.ColumnUuid stockId;

  _i3.StockTable? _stock;

  late final _i1.ColumnDateTime createdAt;

  _i2.AuthUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: StockLike.t.userId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.StockTable get stock {
    if (_stock != null) return _stock!;
    _stock = _i1.createRelationTable(
      relationFieldName: 'stock',
      field: StockLike.t.stockId,
      foreignField: _i3.Stock.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.StockTable(tableRelation: foreignTableRelation),
    );
    return _stock!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    stockId,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'stock') {
      return stock;
    }
    return null;
  }
}

class StockLikeInclude extends _i1.IncludeObject {
  StockLikeInclude._({
    _i2.AuthUserInclude? user,
    _i3.StockInclude? stock,
  }) {
    _user = user;
    _stock = stock;
  }

  _i2.AuthUserInclude? _user;

  _i3.StockInclude? _stock;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'stock': _stock,
  };

  @override
  _i1.Table<int?> get table => StockLike.t;
}

class StockLikeIncludeList extends _i1.IncludeList {
  StockLikeIncludeList._({
    _i1.WhereExpressionBuilder<StockLikeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StockLike.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StockLike.t;
}

class StockLikeRepository {
  const StockLikeRepository._();

  final attachRow = const StockLikeAttachRowRepository._();

  /// Returns a list of [StockLike]s matching the given query parameters.
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
  Future<List<StockLike>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockLikeTable>? orderByList,
    _i1.Transaction? transaction,
    StockLikeInclude? include,
  }) async {
    return session.db.find<StockLike>(
      where: where?.call(StockLike.t),
      orderBy: orderBy?.call(StockLike.t),
      orderByList: orderByList?.call(StockLike.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [StockLike] matching the given query parameters.
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
  Future<StockLike?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockLikeTable>? where,
    int? offset,
    _i1.OrderByBuilder<StockLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockLikeTable>? orderByList,
    _i1.Transaction? transaction,
    StockLikeInclude? include,
  }) async {
    return session.db.findFirstRow<StockLike>(
      where: where?.call(StockLike.t),
      orderBy: orderBy?.call(StockLike.t),
      orderByList: orderByList?.call(StockLike.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [StockLike] by its [id] or null if no such row exists.
  Future<StockLike?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    StockLikeInclude? include,
  }) async {
    return session.db.findById<StockLike>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [StockLike]s in the list and returns the inserted rows.
  ///
  /// The returned [StockLike]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StockLike>> insert(
    _i1.Session session,
    List<StockLike> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StockLike>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StockLike] and returns the inserted row.
  ///
  /// The returned [StockLike] will have its `id` field set.
  Future<StockLike> insertRow(
    _i1.Session session,
    StockLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StockLike>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StockLike]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StockLike>> update(
    _i1.Session session,
    List<StockLike> rows, {
    _i1.ColumnSelections<StockLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StockLike>(
      rows,
      columns: columns?.call(StockLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StockLike]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StockLike> updateRow(
    _i1.Session session,
    StockLike row, {
    _i1.ColumnSelections<StockLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StockLike>(
      row,
      columns: columns?.call(StockLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StockLike] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StockLike?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StockLikeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StockLike>(
      id,
      columnValues: columnValues(StockLike.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StockLike]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StockLike>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StockLikeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StockLikeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockLikeTable>? orderBy,
    _i1.OrderByListBuilder<StockLikeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StockLike>(
      columnValues: columnValues(StockLike.t.updateTable),
      where: where(StockLike.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StockLike.t),
      orderByList: orderByList?.call(StockLike.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StockLike]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StockLike>> delete(
    _i1.Session session,
    List<StockLike> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StockLike>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StockLike].
  Future<StockLike> deleteRow(
    _i1.Session session,
    StockLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StockLike>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StockLike>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StockLikeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StockLike>(
      where: where(StockLike.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockLikeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StockLike>(
      where: where?.call(StockLike.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StockLikeAttachRowRepository {
  const StockLikeAttachRowRepository._();

  /// Creates a relation between the given [StockLike] and [AuthUser]
  /// by setting the [StockLike]'s foreign key `userId` to refer to the [AuthUser].
  Future<void> user(
    _i1.Session session,
    StockLike stockLike,
    _i2.AuthUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (stockLike.id == null) {
      throw ArgumentError.notNull('stockLike.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $stockLike = stockLike.copyWith(userId: user.id);
    await session.db.updateRow<StockLike>(
      $stockLike,
      columns: [StockLike.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StockLike] and [Stock]
  /// by setting the [StockLike]'s foreign key `stockId` to refer to the [Stock].
  Future<void> stock(
    _i1.Session session,
    StockLike stockLike,
    _i3.Stock stock, {
    _i1.Transaction? transaction,
  }) async {
    if (stockLike.id == null) {
      throw ArgumentError.notNull('stockLike.id');
    }
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }

    var $stockLike = stockLike.copyWith(stockId: stock.id);
    await session.db.updateRow<StockLike>(
      $stockLike,
      columns: [StockLike.t.stockId],
      transaction: transaction,
    );
  }
}
