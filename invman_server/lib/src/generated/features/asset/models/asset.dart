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
import '../../../features/asset/models/asset_type.dart' as _i2;
import '../../../features/currency/models/currency.dart' as _i3;
import '../../../features/asset/models/asset_like.dart' as _i4;
import '../../../features/investment/models/investment.dart' as _i5;
import 'package:invman_server/src/generated/protocol.dart' as _i6;

abstract class Asset
    implements _i1.TableRow<_i1.UuidValue>, _i1.ProtocolSerialization {
  Asset._({
    _i1.UuidValue? id,
    required this.symbol,
    required this.name,
    this.exchange,
    required this.type,
    this.logoUrl,
    required this.currencyId,
    this.currency,
    this.likes,
    this.investments,
    this.price,
    this.timestamp,
  }) : id = id ?? const _i1.Uuid().v4obj();

  factory Asset({
    _i1.UuidValue? id,
    required String symbol,
    required String name,
    String? exchange,
    required _i2.AssetType type,
    String? logoUrl,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.AssetLike>? likes,
    List<_i5.Investment>? investments,
    double? price,
    DateTime? timestamp,
  }) = _AssetImpl;

  factory Asset.fromJson(Map<String, dynamic> jsonSerialization) {
    return Asset(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      symbol: jsonSerialization['symbol'] as String,
      name: jsonSerialization['name'] as String,
      exchange: jsonSerialization['exchange'] as String?,
      type: _i2.AssetType.fromJson((jsonSerialization['type'] as String)),
      logoUrl: jsonSerialization['logoUrl'] as String?,
      currencyId: jsonSerialization['currencyId'] as int,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Currency>(
              jsonSerialization['currency'],
            ),
      likes: jsonSerialization['likes'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i4.AssetLike>>(
              jsonSerialization['likes'],
            ),
      investments: jsonSerialization['investments'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.Investment>>(
              jsonSerialization['investments'],
            ),
      price: (jsonSerialization['price'] as num?)?.toDouble(),
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  static final t = AssetTable();

  static const db = AssetRepository._();

  @override
  _i1.UuidValue id;

  String symbol;

  String name;

  String? exchange;

  _i2.AssetType type;

  String? logoUrl;

  int currencyId;

  _i3.Currency? currency;

  List<_i4.AssetLike>? likes;

  List<_i5.Investment>? investments;

  double? price;

  DateTime? timestamp;

  @override
  _i1.Table<_i1.UuidValue> get table => t;

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Asset copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? name,
    String? exchange,
    _i2.AssetType? type,
    String? logoUrl,
    int? currencyId,
    _i3.Currency? currency,
    List<_i4.AssetLike>? likes,
    List<_i5.Investment>? investments,
    double? price,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Asset',
      'id': id.toJson(),
      'symbol': symbol,
      'name': name,
      if (exchange != null) 'exchange': exchange,
      'type': type.toJson(),
      if (logoUrl != null) 'logoUrl': logoUrl,
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
      if (likes != null) 'likes': likes?.toJson(valueToJson: (v) => v.toJson()),
      if (investments != null)
        'investments': investments?.toJson(valueToJson: (v) => v.toJson()),
      if (price != null) 'price': price,
      if (timestamp != null) 'timestamp': timestamp?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Asset',
      'id': id.toJson(),
      'symbol': symbol,
      'name': name,
      if (exchange != null) 'exchange': exchange,
      'type': type.toJson(),
      if (logoUrl != null) 'logoUrl': logoUrl,
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJsonForProtocol(),
      if (likes != null)
        'likes': likes?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (investments != null)
        'investments': investments?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (price != null) 'price': price,
      if (timestamp != null) 'timestamp': timestamp?.toJson(),
    };
  }

  static AssetInclude include({
    _i3.CurrencyInclude? currency,
    _i4.AssetLikeIncludeList? likes,
    _i5.InvestmentIncludeList? investments,
  }) {
    return AssetInclude._(
      currency: currency,
      likes: likes,
      investments: investments,
    );
  }

  static AssetIncludeList includeList({
    _i1.WhereExpressionBuilder<AssetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetTable>? orderByList,
    AssetInclude? include,
  }) {
    return AssetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Asset.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Asset.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssetImpl extends Asset {
  _AssetImpl({
    _i1.UuidValue? id,
    required String symbol,
    required String name,
    String? exchange,
    required _i2.AssetType type,
    String? logoUrl,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.AssetLike>? likes,
    List<_i5.Investment>? investments,
    double? price,
    DateTime? timestamp,
  }) : super._(
         id: id,
         symbol: symbol,
         name: name,
         exchange: exchange,
         type: type,
         logoUrl: logoUrl,
         currencyId: currencyId,
         currency: currency,
         likes: likes,
         investments: investments,
         price: price,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Asset copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? name,
    Object? exchange = _Undefined,
    _i2.AssetType? type,
    Object? logoUrl = _Undefined,
    int? currencyId,
    Object? currency = _Undefined,
    Object? likes = _Undefined,
    Object? investments = _Undefined,
    Object? price = _Undefined,
    Object? timestamp = _Undefined,
  }) {
    return Asset(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      exchange: exchange is String? ? exchange : this.exchange,
      type: type ?? this.type,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      currencyId: currencyId ?? this.currencyId,
      currency: currency is _i3.Currency?
          ? currency
          : this.currency?.copyWith(),
      likes: likes is List<_i4.AssetLike>?
          ? likes
          : this.likes?.map((e0) => e0.copyWith()).toList(),
      investments: investments is List<_i5.Investment>?
          ? investments
          : this.investments?.map((e0) => e0.copyWith()).toList(),
      price: price is double? ? price : this.price,
      timestamp: timestamp is DateTime? ? timestamp : this.timestamp,
    );
  }
}

class AssetUpdateTable extends _i1.UpdateTable<AssetTable> {
  AssetUpdateTable(super.table);

  _i1.ColumnValue<String, String> symbol(String value) => _i1.ColumnValue(
    table.symbol,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> exchange(String? value) => _i1.ColumnValue(
    table.exchange,
    value,
  );

  _i1.ColumnValue<_i2.AssetType, _i2.AssetType> type(_i2.AssetType value) =>
      _i1.ColumnValue(
        table.type,
        value,
      );

  _i1.ColumnValue<String, String> logoUrl(String? value) => _i1.ColumnValue(
    table.logoUrl,
    value,
  );

  _i1.ColumnValue<int, int> currencyId(int value) => _i1.ColumnValue(
    table.currencyId,
    value,
  );
}

class AssetTable extends _i1.Table<_i1.UuidValue> {
  AssetTable({super.tableRelation}) : super(tableName: 'asset') {
    updateTable = AssetUpdateTable(this);
    symbol = _i1.ColumnString(
      'symbol',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    exchange = _i1.ColumnString(
      'exchange',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    logoUrl = _i1.ColumnString(
      'logoUrl',
      this,
    );
    currencyId = _i1.ColumnInt(
      'currencyId',
      this,
    );
  }

  late final AssetUpdateTable updateTable;

  late final _i1.ColumnString symbol;

  late final _i1.ColumnString name;

  late final _i1.ColumnString exchange;

  late final _i1.ColumnEnum<_i2.AssetType> type;

  late final _i1.ColumnString logoUrl;

  late final _i1.ColumnInt currencyId;

  _i3.CurrencyTable? _currency;

  _i4.AssetLikeTable? ___likes;

  _i1.ManyRelation<_i4.AssetLikeTable>? _likes;

  _i5.InvestmentTable? ___investments;

  _i1.ManyRelation<_i5.InvestmentTable>? _investments;

  _i3.CurrencyTable get currency {
    if (_currency != null) return _currency!;
    _currency = _i1.createRelationTable(
      relationFieldName: 'currency',
      field: Asset.t.currencyId,
      foreignField: _i3.Currency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CurrencyTable(tableRelation: foreignTableRelation),
    );
    return _currency!;
  }

  _i4.AssetLikeTable get __likes {
    if (___likes != null) return ___likes!;
    ___likes = _i1.createRelationTable(
      relationFieldName: '__likes',
      field: Asset.t.id,
      foreignField: _i4.AssetLike.t.assetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.AssetLikeTable(tableRelation: foreignTableRelation),
    );
    return ___likes!;
  }

  _i5.InvestmentTable get __investments {
    if (___investments != null) return ___investments!;
    ___investments = _i1.createRelationTable(
      relationFieldName: '__investments',
      field: Asset.t.id,
      foreignField: _i5.Investment.t.assetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.InvestmentTable(tableRelation: foreignTableRelation),
    );
    return ___investments!;
  }

  _i1.ManyRelation<_i4.AssetLikeTable> get likes {
    if (_likes != null) return _likes!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'likes',
      field: Asset.t.id,
      foreignField: _i4.AssetLike.t.assetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.AssetLikeTable(tableRelation: foreignTableRelation),
    );
    _likes = _i1.ManyRelation<_i4.AssetLikeTable>(
      tableWithRelations: relationTable,
      table: _i4.AssetLikeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _likes!;
  }

  _i1.ManyRelation<_i5.InvestmentTable> get investments {
    if (_investments != null) return _investments!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'investments',
      field: Asset.t.id,
      foreignField: _i5.Investment.t.assetId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.InvestmentTable(tableRelation: foreignTableRelation),
    );
    _investments = _i1.ManyRelation<_i5.InvestmentTable>(
      tableWithRelations: relationTable,
      table: _i5.InvestmentTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _investments!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    symbol,
    name,
    exchange,
    type,
    logoUrl,
    currencyId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'currency') {
      return currency;
    }
    if (relationField == 'likes') {
      return __likes;
    }
    if (relationField == 'investments') {
      return __investments;
    }
    return null;
  }
}

class AssetInclude extends _i1.IncludeObject {
  AssetInclude._({
    _i3.CurrencyInclude? currency,
    _i4.AssetLikeIncludeList? likes,
    _i5.InvestmentIncludeList? investments,
  }) {
    _currency = currency;
    _likes = likes;
    _investments = investments;
  }

  _i3.CurrencyInclude? _currency;

  _i4.AssetLikeIncludeList? _likes;

  _i5.InvestmentIncludeList? _investments;

  @override
  Map<String, _i1.Include?> get includes => {
    'currency': _currency,
    'likes': _likes,
    'investments': _investments,
  };

  @override
  _i1.Table<_i1.UuidValue> get table => Asset.t;
}

class AssetIncludeList extends _i1.IncludeList {
  AssetIncludeList._({
    _i1.WhereExpressionBuilder<AssetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Asset.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue> get table => Asset.t;
}

class AssetRepository {
  const AssetRepository._();

  final attach = const AssetAttachRepository._();

  final attachRow = const AssetAttachRowRepository._();

  final detach = const AssetDetachRepository._();

  final detachRow = const AssetDetachRowRepository._();

  /// Returns a list of [Asset]s matching the given query parameters.
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
  Future<List<Asset>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetTable>? orderByList,
    _i1.Transaction? transaction,
    AssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Asset>(
      where: where?.call(Asset.t),
      orderBy: orderBy?.call(Asset.t),
      orderByList: orderByList?.call(Asset.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Asset] matching the given query parameters.
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
  Future<Asset?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetTable>? orderByList,
    _i1.Transaction? transaction,
    AssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Asset>(
      where: where?.call(Asset.t),
      orderBy: orderBy?.call(Asset.t),
      orderByList: orderByList?.call(Asset.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Asset] by its [id] or null if no such row exists.
  Future<Asset?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    AssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Asset>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Asset]s in the list and returns the inserted rows.
  ///
  /// The returned [Asset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Asset>> insert(
    _i1.DatabaseSession session,
    List<Asset> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Asset>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Asset] and returns the inserted row.
  ///
  /// The returned [Asset] will have its `id` field set.
  Future<Asset> insertRow(
    _i1.DatabaseSession session,
    Asset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Asset>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Asset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Asset>> update(
    _i1.DatabaseSession session,
    List<Asset> rows, {
    _i1.ColumnSelections<AssetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Asset>(
      rows,
      columns: columns?.call(Asset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Asset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Asset> updateRow(
    _i1.DatabaseSession session,
    Asset row, {
    _i1.ColumnSelections<AssetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Asset>(
      row,
      columns: columns?.call(Asset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Asset] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Asset?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<AssetUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Asset>(
      id,
      columnValues: columnValues(Asset.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Asset]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Asset>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssetUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AssetTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetTable>? orderBy,
    _i1.OrderByListBuilder<AssetTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Asset>(
      columnValues: columnValues(Asset.t.updateTable),
      where: where(Asset.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Asset.t),
      orderByList: orderByList?.call(Asset.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Asset]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Asset>> delete(
    _i1.DatabaseSession session,
    List<Asset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Asset>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Asset].
  Future<Asset> deleteRow(
    _i1.DatabaseSession session,
    Asset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Asset>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Asset>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssetTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Asset>(
      where: where(Asset.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Asset>(
      where: where?.call(Asset.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Asset] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssetTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Asset>(
      where: where(Asset.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssetAttachRepository {
  const AssetAttachRepository._();

  /// Creates a relation between this [Asset] and the given [AssetLike]s
  /// by setting each [AssetLike]'s foreign key `assetId` to refer to this [Asset].
  Future<void> likes(
    _i1.DatabaseSession session,
    Asset asset,
    List<_i4.AssetLike> assetLike, {
    _i1.Transaction? transaction,
  }) async {
    if (assetLike.any((e) => e.id == null)) {
      throw ArgumentError.notNull('assetLike.id');
    }
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }

    var $assetLike = assetLike
        .map((e) => e.copyWith(assetId: asset.id))
        .toList();
    await session.db.update<_i4.AssetLike>(
      $assetLike,
      columns: [_i4.AssetLike.t.assetId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Asset] and the given [Investment]s
  /// by setting each [Investment]'s foreign key `assetId` to refer to this [Asset].
  Future<void> investments(
    _i1.DatabaseSession session,
    Asset asset,
    List<_i5.Investment> investment, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('investment.id');
    }
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }

    var $investment = investment
        .map((e) => e.copyWith(assetId: asset.id))
        .toList();
    await session.db.update<_i5.Investment>(
      $investment,
      columns: [_i5.Investment.t.assetId],
      transaction: transaction,
    );
  }
}

class AssetAttachRowRepository {
  const AssetAttachRowRepository._();

  /// Creates a relation between the given [Asset] and [Currency]
  /// by setting the [Asset]'s foreign key `currencyId` to refer to the [Currency].
  Future<void> currency(
    _i1.DatabaseSession session,
    Asset asset,
    _i3.Currency currency, {
    _i1.Transaction? transaction,
  }) async {
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }
    if (currency.id == null) {
      throw ArgumentError.notNull('currency.id');
    }

    var $asset = asset.copyWith(currencyId: currency.id);
    await session.db.updateRow<Asset>(
      $asset,
      columns: [Asset.t.currencyId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Asset] and the given [AssetLike]
  /// by setting the [AssetLike]'s foreign key `assetId` to refer to this [Asset].
  Future<void> likes(
    _i1.DatabaseSession session,
    Asset asset,
    _i4.AssetLike assetLike, {
    _i1.Transaction? transaction,
  }) async {
    if (assetLike.id == null) {
      throw ArgumentError.notNull('assetLike.id');
    }
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }

    var $assetLike = assetLike.copyWith(assetId: asset.id);
    await session.db.updateRow<_i4.AssetLike>(
      $assetLike,
      columns: [_i4.AssetLike.t.assetId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Asset] and the given [Investment]
  /// by setting the [Investment]'s foreign key `assetId` to refer to this [Asset].
  Future<void> investments(
    _i1.DatabaseSession session,
    Asset asset,
    _i5.Investment investment, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }

    var $investment = investment.copyWith(assetId: asset.id);
    await session.db.updateRow<_i5.Investment>(
      $investment,
      columns: [_i5.Investment.t.assetId],
      transaction: transaction,
    );
  }
}

class AssetDetachRepository {
  const AssetDetachRepository._();

  /// Detaches the relation between this [Asset] and the given [AssetLike]
  /// by setting the [AssetLike]'s foreign key `assetId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> likes(
    _i1.DatabaseSession session,
    List<_i4.AssetLike> assetLike, {
    _i1.Transaction? transaction,
  }) async {
    if (assetLike.any((e) => e.id == null)) {
      throw ArgumentError.notNull('assetLike.id');
    }

    var $assetLike = assetLike.map((e) => e.copyWith(assetId: null)).toList();
    await session.db.update<_i4.AssetLike>(
      $assetLike,
      columns: [_i4.AssetLike.t.assetId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Asset] and the given [Investment]
  /// by setting the [Investment]'s foreign key `assetId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> investments(
    _i1.DatabaseSession session,
    List<_i5.Investment> investment, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('investment.id');
    }

    var $investment = investment.map((e) => e.copyWith(assetId: null)).toList();
    await session.db.update<_i5.Investment>(
      $investment,
      columns: [_i5.Investment.t.assetId],
      transaction: transaction,
    );
  }
}

class AssetDetachRowRepository {
  const AssetDetachRowRepository._();

  /// Detaches the relation between this [Asset] and the given [AssetLike]
  /// by setting the [AssetLike]'s foreign key `assetId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> likes(
    _i1.DatabaseSession session,
    _i4.AssetLike assetLike, {
    _i1.Transaction? transaction,
  }) async {
    if (assetLike.id == null) {
      throw ArgumentError.notNull('assetLike.id');
    }

    var $assetLike = assetLike.copyWith(assetId: null);
    await session.db.updateRow<_i4.AssetLike>(
      $assetLike,
      columns: [_i4.AssetLike.t.assetId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Asset] and the given [Investment]
  /// by setting the [Investment]'s foreign key `assetId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> investments(
    _i1.DatabaseSession session,
    _i5.Investment investment, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }

    var $investment = investment.copyWith(assetId: null);
    await session.db.updateRow<_i5.Investment>(
      $investment,
      columns: [_i5.Investment.t.assetId],
      transaction: transaction,
    );
  }
}
