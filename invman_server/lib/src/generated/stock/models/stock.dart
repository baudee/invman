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
import '../../stock/models/stock_type.dart' as _i2;
import '../../currency/models/currency.dart' as _i3;
import '../../stock/models/stock_like.dart' as _i4;
import '../../investment/models/investment.dart' as _i5;
import 'package:invman_server/src/generated/protocol.dart' as _i6;

abstract class Stock implements _i1.TableRow<_i1.UuidValue>, _i1.ProtocolSerialization {
  Stock._({
    _i1.UuidValue? id,
    required this.symbol,
    required this.name,
    required this.quoteType,
    this.logoUrl,
    double? price,
    DateTime? timestamp,
    DateTime? updatedAt,
    required this.currencyId,
    this.currency,
    this.likes,
    this.investments,
  }) : id = id ?? _i1.Uuid().v4obj(),
       price = price ?? 0.0,
       timestamp = timestamp ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Stock({
    _i1.UuidValue? id,
    required String symbol,
    required String name,
    required _i2.StockType quoteType,
    String? logoUrl,
    double? price,
    DateTime? timestamp,
    DateTime? updatedAt,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.StockLike>? likes,
    List<_i5.Investment>? investments,
  }) = _StockImpl;

  factory Stock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stock(
      id: jsonSerialization['id'] == null ? null : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      symbol: jsonSerialization['symbol'] as String,
      name: jsonSerialization['name'] as String,
      quoteType: _i2.StockType.fromJson(
        (jsonSerialization['quoteType'] as String),
      ),
      logoUrl: jsonSerialization['logoUrl'] as String?,
      price: (jsonSerialization['price'] as num?)?.toDouble(),
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      currencyId: jsonSerialization['currencyId'] as int,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Currency>(
              jsonSerialization['currency'],
            ),
      likes: jsonSerialization['likes'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i4.StockLike>>(
              jsonSerialization['likes'],
            ),
      investments: jsonSerialization['investments'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.Investment>>(
              jsonSerialization['investments'],
            ),
    );
  }

  static final t = StockTable();

  static const db = StockRepository._();

  @override
  _i1.UuidValue id;

  String symbol;

  String name;

  _i2.StockType quoteType;

  String? logoUrl;

  double price;

  DateTime timestamp;

  DateTime updatedAt;

  int currencyId;

  _i3.Currency? currency;

  List<_i4.StockLike>? likes;

  List<_i5.Investment>? investments;

  @override
  _i1.Table<_i1.UuidValue> get table => t;

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Stock copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? name,
    _i2.StockType? quoteType,
    String? logoUrl,
    double? price,
    DateTime? timestamp,
    DateTime? updatedAt,
    int? currencyId,
    _i3.Currency? currency,
    List<_i4.StockLike>? likes,
    List<_i5.Investment>? investments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Stock',
      'id': id.toJson(),
      'symbol': symbol,
      'name': name,
      'quoteType': quoteType.toJson(),
      if (logoUrl != null) 'logoUrl': logoUrl,
      'price': price,
      'timestamp': timestamp.toJson(),
      'updatedAt': updatedAt.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
      if (likes != null) 'likes': likes?.toJson(valueToJson: (v) => v.toJson()),
      if (investments != null) 'investments': investments?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Stock',
      'id': id.toJson(),
      'symbol': symbol,
      'name': name,
      'quoteType': quoteType.toJson(),
      if (logoUrl != null) 'logoUrl': logoUrl,
      'price': price,
      'timestamp': timestamp.toJson(),
      'updatedAt': updatedAt.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJsonForProtocol(),
      if (likes != null) 'likes': likes?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (investments != null)
        'investments': investments?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static StockInclude include({
    _i3.CurrencyInclude? currency,
    _i4.StockLikeIncludeList? likes,
    _i5.InvestmentIncludeList? investments,
  }) {
    return StockInclude._(
      currency: currency,
      likes: likes,
      investments: investments,
    );
  }

  static StockIncludeList includeList({
    _i1.WhereExpressionBuilder<StockTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockTable>? orderByList,
    StockInclude? include,
  }) {
    return StockIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Stock.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Stock.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StockImpl extends Stock {
  _StockImpl({
    _i1.UuidValue? id,
    required String symbol,
    required String name,
    required _i2.StockType quoteType,
    String? logoUrl,
    double? price,
    DateTime? timestamp,
    DateTime? updatedAt,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.StockLike>? likes,
    List<_i5.Investment>? investments,
  }) : super._(
         id: id,
         symbol: symbol,
         name: name,
         quoteType: quoteType,
         logoUrl: logoUrl,
         price: price,
         timestamp: timestamp,
         updatedAt: updatedAt,
         currencyId: currencyId,
         currency: currency,
         likes: likes,
         investments: investments,
       );

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Stock copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? name,
    _i2.StockType? quoteType,
    Object? logoUrl = _Undefined,
    double? price,
    DateTime? timestamp,
    DateTime? updatedAt,
    int? currencyId,
    Object? currency = _Undefined,
    Object? likes = _Undefined,
    Object? investments = _Undefined,
  }) {
    return Stock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      quoteType: quoteType ?? this.quoteType,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      price: price ?? this.price,
      timestamp: timestamp ?? this.timestamp,
      updatedAt: updatedAt ?? this.updatedAt,
      currencyId: currencyId ?? this.currencyId,
      currency: currency is _i3.Currency? ? currency : this.currency?.copyWith(),
      likes: likes is List<_i4.StockLike>? ? likes : this.likes?.map((e0) => e0.copyWith()).toList(),
      investments: investments is List<_i5.Investment>?
          ? investments
          : this.investments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class StockUpdateTable extends _i1.UpdateTable<StockTable> {
  StockUpdateTable(super.table);

  _i1.ColumnValue<String, String> symbol(String value) => _i1.ColumnValue(
    table.symbol,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<_i2.StockType, _i2.StockType> quoteType(
    _i2.StockType value,
  ) => _i1.ColumnValue(
    table.quoteType,
    value,
  );

  _i1.ColumnValue<String, String> logoUrl(String? value) => _i1.ColumnValue(
    table.logoUrl,
    value,
  );

  _i1.ColumnValue<double, double> price(double value) => _i1.ColumnValue(
    table.price,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) => _i1.ColumnValue(
    table.timestamp,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) => _i1.ColumnValue(
    table.updatedAt,
    value,
  );

  _i1.ColumnValue<int, int> currencyId(int value) => _i1.ColumnValue(
    table.currencyId,
    value,
  );
}

class StockTable extends _i1.Table<_i1.UuidValue> {
  StockTable({super.tableRelation}) : super(tableName: 'stock') {
    updateTable = StockUpdateTable(this);
    symbol = _i1.ColumnString(
      'symbol',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    quoteType = _i1.ColumnEnum(
      'quoteType',
      this,
      _i1.EnumSerialization.byName,
    );
    logoUrl = _i1.ColumnString(
      'logoUrl',
      this,
    );
    price = _i1.ColumnDouble(
      'price',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    currencyId = _i1.ColumnInt(
      'currencyId',
      this,
    );
  }

  late final StockUpdateTable updateTable;

  late final _i1.ColumnString symbol;

  late final _i1.ColumnString name;

  late final _i1.ColumnEnum<_i2.StockType> quoteType;

  late final _i1.ColumnString logoUrl;

  late final _i1.ColumnDouble price;

  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt currencyId;

  _i3.CurrencyTable? _currency;

  _i4.StockLikeTable? ___likes;

  _i1.ManyRelation<_i4.StockLikeTable>? _likes;

  _i5.InvestmentTable? ___investments;

  _i1.ManyRelation<_i5.InvestmentTable>? _investments;

  _i3.CurrencyTable get currency {
    if (_currency != null) return _currency!;
    _currency = _i1.createRelationTable(
      relationFieldName: 'currency',
      field: Stock.t.currencyId,
      foreignField: _i3.Currency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i3.CurrencyTable(tableRelation: foreignTableRelation),
    );
    return _currency!;
  }

  _i4.StockLikeTable get __likes {
    if (___likes != null) return ___likes!;
    ___likes = _i1.createRelationTable(
      relationFieldName: '__likes',
      field: Stock.t.id,
      foreignField: _i4.StockLike.t.stockId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i4.StockLikeTable(tableRelation: foreignTableRelation),
    );
    return ___likes!;
  }

  _i5.InvestmentTable get __investments {
    if (___investments != null) return ___investments!;
    ___investments = _i1.createRelationTable(
      relationFieldName: '__investments',
      field: Stock.t.id,
      foreignField: _i5.Investment.t.stockId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i5.InvestmentTable(tableRelation: foreignTableRelation),
    );
    return ___investments!;
  }

  _i1.ManyRelation<_i4.StockLikeTable> get likes {
    if (_likes != null) return _likes!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'likes',
      field: Stock.t.id,
      foreignField: _i4.StockLike.t.stockId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i4.StockLikeTable(tableRelation: foreignTableRelation),
    );
    _likes = _i1.ManyRelation<_i4.StockLikeTable>(
      tableWithRelations: relationTable,
      table: _i4.StockLikeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _likes!;
  }

  _i1.ManyRelation<_i5.InvestmentTable> get investments {
    if (_investments != null) return _investments!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'investments',
      field: Stock.t.id,
      foreignField: _i5.Investment.t.stockId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i5.InvestmentTable(tableRelation: foreignTableRelation),
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
    quoteType,
    logoUrl,
    price,
    timestamp,
    updatedAt,
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

class StockInclude extends _i1.IncludeObject {
  StockInclude._({
    _i3.CurrencyInclude? currency,
    _i4.StockLikeIncludeList? likes,
    _i5.InvestmentIncludeList? investments,
  }) {
    _currency = currency;
    _likes = likes;
    _investments = investments;
  }

  _i3.CurrencyInclude? _currency;

  _i4.StockLikeIncludeList? _likes;

  _i5.InvestmentIncludeList? _investments;

  @override
  Map<String, _i1.Include?> get includes => {
    'currency': _currency,
    'likes': _likes,
    'investments': _investments,
  };

  @override
  _i1.Table<_i1.UuidValue> get table => Stock.t;
}

class StockIncludeList extends _i1.IncludeList {
  StockIncludeList._({
    _i1.WhereExpressionBuilder<StockTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Stock.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue> get table => Stock.t;
}

class StockRepository {
  const StockRepository._();

  final attach = const StockAttachRepository._();

  final attachRow = const StockAttachRowRepository._();

  final detach = const StockDetachRepository._();

  final detachRow = const StockDetachRowRepository._();

  /// Returns a list of [Stock]s matching the given query parameters.
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
  Future<List<Stock>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockTable>? orderByList,
    _i1.Transaction? transaction,
    StockInclude? include,
  }) async {
    return session.db.find<Stock>(
      where: where?.call(Stock.t),
      orderBy: orderBy?.call(Stock.t),
      orderByList: orderByList?.call(Stock.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Stock] matching the given query parameters.
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
  Future<Stock?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockTable>? where,
    int? offset,
    _i1.OrderByBuilder<StockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockTable>? orderByList,
    _i1.Transaction? transaction,
    StockInclude? include,
  }) async {
    return session.db.findFirstRow<Stock>(
      where: where?.call(Stock.t),
      orderBy: orderBy?.call(Stock.t),
      orderByList: orderByList?.call(Stock.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Stock] by its [id] or null if no such row exists.
  Future<Stock?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    StockInclude? include,
  }) async {
    return session.db.findById<Stock>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Stock]s in the list and returns the inserted rows.
  ///
  /// The returned [Stock]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Stock>> insert(
    _i1.Session session,
    List<Stock> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Stock>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Stock] and returns the inserted row.
  ///
  /// The returned [Stock] will have its `id` field set.
  Future<Stock> insertRow(
    _i1.Session session,
    Stock row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Stock>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Stock]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Stock>> update(
    _i1.Session session,
    List<Stock> rows, {
    _i1.ColumnSelections<StockTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Stock>(
      rows,
      columns: columns?.call(Stock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Stock]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Stock> updateRow(
    _i1.Session session,
    Stock row, {
    _i1.ColumnSelections<StockTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Stock>(
      row,
      columns: columns?.call(Stock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Stock] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Stock?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<StockUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Stock>(
      id,
      columnValues: columnValues(Stock.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Stock]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Stock>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StockUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StockTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockTable>? orderBy,
    _i1.OrderByListBuilder<StockTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Stock>(
      columnValues: columnValues(Stock.t.updateTable),
      where: where(Stock.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Stock.t),
      orderByList: orderByList?.call(Stock.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Stock]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Stock>> delete(
    _i1.Session session,
    List<Stock> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Stock>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Stock].
  Future<Stock> deleteRow(
    _i1.Session session,
    Stock row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Stock>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Stock>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StockTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Stock>(
      where: where(Stock.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Stock>(
      where: where?.call(Stock.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StockAttachRepository {
  const StockAttachRepository._();

  /// Creates a relation between this [Stock] and the given [StockLike]s
  /// by setting each [StockLike]'s foreign key `stockId` to refer to this [Stock].
  Future<void> likes(
    _i1.Session session,
    Stock stock,
    List<_i4.StockLike> stockLike, {
    _i1.Transaction? transaction,
  }) async {
    if (stockLike.any((e) => e.id == null)) {
      throw ArgumentError.notNull('stockLike.id');
    }
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }

    var $stockLike = stockLike.map((e) => e.copyWith(stockId: stock.id)).toList();
    await session.db.update<_i4.StockLike>(
      $stockLike,
      columns: [_i4.StockLike.t.stockId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Stock] and the given [Investment]s
  /// by setting each [Investment]'s foreign key `stockId` to refer to this [Stock].
  Future<void> investments(
    _i1.Session session,
    Stock stock,
    List<_i5.Investment> investment, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('investment.id');
    }
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }

    var $investment = investment.map((e) => e.copyWith(stockId: stock.id)).toList();
    await session.db.update<_i5.Investment>(
      $investment,
      columns: [_i5.Investment.t.stockId],
      transaction: transaction,
    );
  }
}

class StockAttachRowRepository {
  const StockAttachRowRepository._();

  /// Creates a relation between the given [Stock] and [Currency]
  /// by setting the [Stock]'s foreign key `currencyId` to refer to the [Currency].
  Future<void> currency(
    _i1.Session session,
    Stock stock,
    _i3.Currency currency, {
    _i1.Transaction? transaction,
  }) async {
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }
    if (currency.id == null) {
      throw ArgumentError.notNull('currency.id');
    }

    var $stock = stock.copyWith(currencyId: currency.id);
    await session.db.updateRow<Stock>(
      $stock,
      columns: [Stock.t.currencyId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Stock] and the given [StockLike]
  /// by setting the [StockLike]'s foreign key `stockId` to refer to this [Stock].
  Future<void> likes(
    _i1.Session session,
    Stock stock,
    _i4.StockLike stockLike, {
    _i1.Transaction? transaction,
  }) async {
    if (stockLike.id == null) {
      throw ArgumentError.notNull('stockLike.id');
    }
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }

    var $stockLike = stockLike.copyWith(stockId: stock.id);
    await session.db.updateRow<_i4.StockLike>(
      $stockLike,
      columns: [_i4.StockLike.t.stockId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Stock] and the given [Investment]
  /// by setting the [Investment]'s foreign key `stockId` to refer to this [Stock].
  Future<void> investments(
    _i1.Session session,
    Stock stock,
    _i5.Investment investment, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }

    var $investment = investment.copyWith(stockId: stock.id);
    await session.db.updateRow<_i5.Investment>(
      $investment,
      columns: [_i5.Investment.t.stockId],
      transaction: transaction,
    );
  }
}

class StockDetachRepository {
  const StockDetachRepository._();

  /// Detaches the relation between this [Stock] and the given [StockLike]
  /// by setting the [StockLike]'s foreign key `stockId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> likes(
    _i1.Session session,
    List<_i4.StockLike> stockLike, {
    _i1.Transaction? transaction,
  }) async {
    if (stockLike.any((e) => e.id == null)) {
      throw ArgumentError.notNull('stockLike.id');
    }

    var $stockLike = stockLike.map((e) => e.copyWith(stockId: null)).toList();
    await session.db.update<_i4.StockLike>(
      $stockLike,
      columns: [_i4.StockLike.t.stockId],
      transaction: transaction,
    );
  }
}

class StockDetachRowRepository {
  const StockDetachRowRepository._();

  /// Detaches the relation between this [Stock] and the given [StockLike]
  /// by setting the [StockLike]'s foreign key `stockId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> likes(
    _i1.Session session,
    _i4.StockLike stockLike, {
    _i1.Transaction? transaction,
  }) async {
    if (stockLike.id == null) {
      throw ArgumentError.notNull('stockLike.id');
    }

    var $stockLike = stockLike.copyWith(stockId: null);
    await session.db.updateRow<_i4.StockLike>(
      $stockLike,
      columns: [_i4.StockLike.t.stockId],
      transaction: transaction,
    );
  }
}
