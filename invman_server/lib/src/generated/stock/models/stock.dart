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
import '../../stock/models/stock_price.dart' as _i4;
import 'package:invman_server/src/generated/protocol.dart' as _i5;

abstract class Stock
    implements _i1.TableRow<_i1.UuidValue>, _i1.ProtocolSerialization {
  Stock._({
    _i1.UuidValue? id,
    required this.symbol,
    required this.shortName,
    required this.longName,
    required this.quoteType,
    required this.currencyId,
    this.currency,
    this.prices,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Stock({
    _i1.UuidValue? id,
    required String symbol,
    required String shortName,
    required String longName,
    required _i2.StockType quoteType,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.StockPrice>? prices,
  }) = _StockImpl;

  factory Stock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stock(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      symbol: jsonSerialization['symbol'] as String,
      shortName: jsonSerialization['shortName'] as String,
      longName: jsonSerialization['longName'] as String,
      quoteType: _i2.StockType.fromJson(
        (jsonSerialization['quoteType'] as String),
      ),
      currencyId: jsonSerialization['currencyId'] as int,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Currency>(
              jsonSerialization['currency'],
            ),
      prices: jsonSerialization['prices'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.StockPrice>>(
              jsonSerialization['prices'],
            ),
    );
  }

  static final t = StockTable();

  static const db = StockRepository._();

  @override
  _i1.UuidValue id;

  String symbol;

  String shortName;

  String longName;

  _i2.StockType quoteType;

  int currencyId;

  _i3.Currency? currency;

  List<_i4.StockPrice>? prices;

  @override
  _i1.Table<_i1.UuidValue> get table => t;

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Stock copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? shortName,
    String? longName,
    _i2.StockType? quoteType,
    int? currencyId,
    _i3.Currency? currency,
    List<_i4.StockPrice>? prices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Stock',
      'id': id.toJson(),
      'symbol': symbol,
      'shortName': shortName,
      'longName': longName,
      'quoteType': quoteType.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
      if (prices != null)
        'prices': prices?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Stock',
      'id': id.toJson(),
      'symbol': symbol,
      'shortName': shortName,
      'longName': longName,
      'quoteType': quoteType.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJsonForProtocol(),
      if (prices != null)
        'prices': prices?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static StockInclude include({
    _i3.CurrencyInclude? currency,
    _i4.StockPriceIncludeList? prices,
  }) {
    return StockInclude._(
      currency: currency,
      prices: prices,
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
    required String shortName,
    required String longName,
    required _i2.StockType quoteType,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.StockPrice>? prices,
  }) : super._(
         id: id,
         symbol: symbol,
         shortName: shortName,
         longName: longName,
         quoteType: quoteType,
         currencyId: currencyId,
         currency: currency,
         prices: prices,
       );

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Stock copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? shortName,
    String? longName,
    _i2.StockType? quoteType,
    int? currencyId,
    Object? currency = _Undefined,
    Object? prices = _Undefined,
  }) {
    return Stock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      shortName: shortName ?? this.shortName,
      longName: longName ?? this.longName,
      quoteType: quoteType ?? this.quoteType,
      currencyId: currencyId ?? this.currencyId,
      currency: currency is _i3.Currency?
          ? currency
          : this.currency?.copyWith(),
      prices: prices is List<_i4.StockPrice>?
          ? prices
          : this.prices?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class StockUpdateTable extends _i1.UpdateTable<StockTable> {
  StockUpdateTable(super.table);

  _i1.ColumnValue<String, String> symbol(String value) => _i1.ColumnValue(
    table.symbol,
    value,
  );

  _i1.ColumnValue<String, String> shortName(String value) => _i1.ColumnValue(
    table.shortName,
    value,
  );

  _i1.ColumnValue<String, String> longName(String value) => _i1.ColumnValue(
    table.longName,
    value,
  );

  _i1.ColumnValue<_i2.StockType, _i2.StockType> quoteType(
    _i2.StockType value,
  ) => _i1.ColumnValue(
    table.quoteType,
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
    shortName = _i1.ColumnString(
      'shortName',
      this,
    );
    longName = _i1.ColumnString(
      'longName',
      this,
    );
    quoteType = _i1.ColumnEnum(
      'quoteType',
      this,
      _i1.EnumSerialization.byName,
    );
    currencyId = _i1.ColumnInt(
      'currencyId',
      this,
    );
  }

  late final StockUpdateTable updateTable;

  late final _i1.ColumnString symbol;

  late final _i1.ColumnString shortName;

  late final _i1.ColumnString longName;

  late final _i1.ColumnEnum<_i2.StockType> quoteType;

  late final _i1.ColumnInt currencyId;

  _i3.CurrencyTable? _currency;

  _i4.StockPriceTable? ___prices;

  _i1.ManyRelation<_i4.StockPriceTable>? _prices;

  _i3.CurrencyTable get currency {
    if (_currency != null) return _currency!;
    _currency = _i1.createRelationTable(
      relationFieldName: 'currency',
      field: Stock.t.currencyId,
      foreignField: _i3.Currency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CurrencyTable(tableRelation: foreignTableRelation),
    );
    return _currency!;
  }

  _i4.StockPriceTable get __prices {
    if (___prices != null) return ___prices!;
    ___prices = _i1.createRelationTable(
      relationFieldName: '__prices',
      field: Stock.t.id,
      foreignField: _i4.StockPrice.t.stockId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.StockPriceTable(tableRelation: foreignTableRelation),
    );
    return ___prices!;
  }

  _i1.ManyRelation<_i4.StockPriceTable> get prices {
    if (_prices != null) return _prices!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'prices',
      field: Stock.t.id,
      foreignField: _i4.StockPrice.t.stockId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.StockPriceTable(tableRelation: foreignTableRelation),
    );
    _prices = _i1.ManyRelation<_i4.StockPriceTable>(
      tableWithRelations: relationTable,
      table: _i4.StockPriceTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _prices!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    symbol,
    shortName,
    longName,
    quoteType,
    currencyId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'currency') {
      return currency;
    }
    if (relationField == 'prices') {
      return __prices;
    }
    return null;
  }
}

class StockInclude extends _i1.IncludeObject {
  StockInclude._({
    _i3.CurrencyInclude? currency,
    _i4.StockPriceIncludeList? prices,
  }) {
    _currency = currency;
    _prices = prices;
  }

  _i3.CurrencyInclude? _currency;

  _i4.StockPriceIncludeList? _prices;

  @override
  Map<String, _i1.Include?> get includes => {
    'currency': _currency,
    'prices': _prices,
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

  /// Creates a relation between this [Stock] and the given [StockPrice]s
  /// by setting each [StockPrice]'s foreign key `stockId` to refer to this [Stock].
  Future<void> prices(
    _i1.Session session,
    Stock stock,
    List<_i4.StockPrice> stockPrice, {
    _i1.Transaction? transaction,
  }) async {
    if (stockPrice.any((e) => e.id == null)) {
      throw ArgumentError.notNull('stockPrice.id');
    }
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }

    var $stockPrice = stockPrice
        .map((e) => e.copyWith(stockId: stock.id))
        .toList();
    await session.db.update<_i4.StockPrice>(
      $stockPrice,
      columns: [_i4.StockPrice.t.stockId],
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

  /// Creates a relation between this [Stock] and the given [StockPrice]
  /// by setting the [StockPrice]'s foreign key `stockId` to refer to this [Stock].
  Future<void> prices(
    _i1.Session session,
    Stock stock,
    _i4.StockPrice stockPrice, {
    _i1.Transaction? transaction,
  }) async {
    if (stockPrice.id == null) {
      throw ArgumentError.notNull('stockPrice.id');
    }
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }

    var $stockPrice = stockPrice.copyWith(stockId: stock.id);
    await session.db.updateRow<_i4.StockPrice>(
      $stockPrice,
      columns: [_i4.StockPrice.t.stockId],
      transaction: transaction,
    );
  }
}

class StockDetachRepository {
  const StockDetachRepository._();

  /// Detaches the relation between this [Stock] and the given [StockPrice]
  /// by setting the [StockPrice]'s foreign key `stockId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> prices(
    _i1.Session session,
    List<_i4.StockPrice> stockPrice, {
    _i1.Transaction? transaction,
  }) async {
    if (stockPrice.any((e) => e.id == null)) {
      throw ArgumentError.notNull('stockPrice.id');
    }

    var $stockPrice = stockPrice.map((e) => e.copyWith(stockId: null)).toList();
    await session.db.update<_i4.StockPrice>(
      $stockPrice,
      columns: [_i4.StockPrice.t.stockId],
      transaction: transaction,
    );
  }
}

class StockDetachRowRepository {
  const StockDetachRowRepository._();

  /// Detaches the relation between this [Stock] and the given [StockPrice]
  /// by setting the [StockPrice]'s foreign key `stockId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> prices(
    _i1.Session session,
    _i4.StockPrice stockPrice, {
    _i1.Transaction? transaction,
  }) async {
    if (stockPrice.id == null) {
      throw ArgumentError.notNull('stockPrice.id');
    }

    var $stockPrice = stockPrice.copyWith(stockId: null);
    await session.db.updateRow<_i4.StockPrice>(
      $stockPrice,
      columns: [_i4.StockPrice.t.stockId],
      transaction: transaction,
    );
  }
}
