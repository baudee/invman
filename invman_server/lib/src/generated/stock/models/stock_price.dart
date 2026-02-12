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
import '../../stock/models/stock.dart' as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class StockPrice
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StockPrice._({
    this.id,
    required this.value,
    required this.timestamp,
    required this.stockId,
    this.stock,
  });

  factory StockPrice({
    int? id,
    required double value,
    required DateTime timestamp,
    required _i1.UuidValue stockId,
    _i2.Stock? stock,
  }) = _StockPriceImpl;

  factory StockPrice.fromJson(Map<String, dynamic> jsonSerialization) {
    return StockPrice(
      id: jsonSerialization['id'] as int?,
      value: (jsonSerialization['value'] as num).toDouble(),
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      stockId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['stockId'],
      ),
      stock: jsonSerialization['stock'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Stock>(jsonSerialization['stock']),
    );
  }

  static final t = StockPriceTable();

  static const db = StockPriceRepository._();

  @override
  int? id;

  double value;

  DateTime timestamp;

  _i1.UuidValue stockId;

  _i2.Stock? stock;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StockPrice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StockPrice copyWith({
    int? id,
    double? value,
    DateTime? timestamp,
    _i1.UuidValue? stockId,
    _i2.Stock? stock,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StockPrice',
      if (id != null) 'id': id,
      'value': value,
      'timestamp': timestamp.toJson(),
      'stockId': stockId.toJson(),
      if (stock != null) 'stock': stock?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StockPrice',
      if (id != null) 'id': id,
      'value': value,
      'timestamp': timestamp.toJson(),
      'stockId': stockId.toJson(),
      if (stock != null) 'stock': stock?.toJsonForProtocol(),
    };
  }

  static StockPriceInclude include({_i2.StockInclude? stock}) {
    return StockPriceInclude._(stock: stock);
  }

  static StockPriceIncludeList includeList({
    _i1.WhereExpressionBuilder<StockPriceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockPriceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockPriceTable>? orderByList,
    StockPriceInclude? include,
  }) {
    return StockPriceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StockPrice.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StockPrice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StockPriceImpl extends StockPrice {
  _StockPriceImpl({
    int? id,
    required double value,
    required DateTime timestamp,
    required _i1.UuidValue stockId,
    _i2.Stock? stock,
  }) : super._(
         id: id,
         value: value,
         timestamp: timestamp,
         stockId: stockId,
         stock: stock,
       );

  /// Returns a shallow copy of this [StockPrice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StockPrice copyWith({
    Object? id = _Undefined,
    double? value,
    DateTime? timestamp,
    _i1.UuidValue? stockId,
    Object? stock = _Undefined,
  }) {
    return StockPrice(
      id: id is int? ? id : this.id,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      stockId: stockId ?? this.stockId,
      stock: stock is _i2.Stock? ? stock : this.stock?.copyWith(),
    );
  }
}

class StockPriceUpdateTable extends _i1.UpdateTable<StockPriceTable> {
  StockPriceUpdateTable(super.table);

  _i1.ColumnValue<double, double> value(double value) => _i1.ColumnValue(
    table.value,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> stockId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.stockId,
        value,
      );
}

class StockPriceTable extends _i1.Table<int?> {
  StockPriceTable({super.tableRelation}) : super(tableName: 'stock_price') {
    updateTable = StockPriceUpdateTable(this);
    value = _i1.ColumnDouble(
      'value',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    stockId = _i1.ColumnUuid(
      'stockId',
      this,
    );
  }

  late final StockPriceUpdateTable updateTable;

  late final _i1.ColumnDouble value;

  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnUuid stockId;

  _i2.StockTable? _stock;

  _i2.StockTable get stock {
    if (_stock != null) return _stock!;
    _stock = _i1.createRelationTable(
      relationFieldName: 'stock',
      field: StockPrice.t.stockId,
      foreignField: _i2.Stock.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.StockTable(tableRelation: foreignTableRelation),
    );
    return _stock!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    value,
    timestamp,
    stockId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'stock') {
      return stock;
    }
    return null;
  }
}

class StockPriceInclude extends _i1.IncludeObject {
  StockPriceInclude._({_i2.StockInclude? stock}) {
    _stock = stock;
  }

  _i2.StockInclude? _stock;

  @override
  Map<String, _i1.Include?> get includes => {'stock': _stock};

  @override
  _i1.Table<int?> get table => StockPrice.t;
}

class StockPriceIncludeList extends _i1.IncludeList {
  StockPriceIncludeList._({
    _i1.WhereExpressionBuilder<StockPriceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StockPrice.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StockPrice.t;
}

class StockPriceRepository {
  const StockPriceRepository._();

  final attachRow = const StockPriceAttachRowRepository._();

  /// Returns a list of [StockPrice]s matching the given query parameters.
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
  Future<List<StockPrice>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockPriceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockPriceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockPriceTable>? orderByList,
    _i1.Transaction? transaction,
    StockPriceInclude? include,
  }) async {
    return session.db.find<StockPrice>(
      where: where?.call(StockPrice.t),
      orderBy: orderBy?.call(StockPrice.t),
      orderByList: orderByList?.call(StockPrice.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [StockPrice] matching the given query parameters.
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
  Future<StockPrice?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockPriceTable>? where,
    int? offset,
    _i1.OrderByBuilder<StockPriceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StockPriceTable>? orderByList,
    _i1.Transaction? transaction,
    StockPriceInclude? include,
  }) async {
    return session.db.findFirstRow<StockPrice>(
      where: where?.call(StockPrice.t),
      orderBy: orderBy?.call(StockPrice.t),
      orderByList: orderByList?.call(StockPrice.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [StockPrice] by its [id] or null if no such row exists.
  Future<StockPrice?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    StockPriceInclude? include,
  }) async {
    return session.db.findById<StockPrice>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [StockPrice]s in the list and returns the inserted rows.
  ///
  /// The returned [StockPrice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StockPrice>> insert(
    _i1.Session session,
    List<StockPrice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StockPrice>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StockPrice] and returns the inserted row.
  ///
  /// The returned [StockPrice] will have its `id` field set.
  Future<StockPrice> insertRow(
    _i1.Session session,
    StockPrice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StockPrice>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StockPrice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StockPrice>> update(
    _i1.Session session,
    List<StockPrice> rows, {
    _i1.ColumnSelections<StockPriceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StockPrice>(
      rows,
      columns: columns?.call(StockPrice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StockPrice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StockPrice> updateRow(
    _i1.Session session,
    StockPrice row, {
    _i1.ColumnSelections<StockPriceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StockPrice>(
      row,
      columns: columns?.call(StockPrice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StockPrice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StockPrice?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StockPriceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StockPrice>(
      id,
      columnValues: columnValues(StockPrice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StockPrice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StockPrice>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StockPriceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StockPriceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StockPriceTable>? orderBy,
    _i1.OrderByListBuilder<StockPriceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StockPrice>(
      columnValues: columnValues(StockPrice.t.updateTable),
      where: where(StockPrice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StockPrice.t),
      orderByList: orderByList?.call(StockPrice.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StockPrice]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StockPrice>> delete(
    _i1.Session session,
    List<StockPrice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StockPrice>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StockPrice].
  Future<StockPrice> deleteRow(
    _i1.Session session,
    StockPrice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StockPrice>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StockPrice>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StockPriceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StockPrice>(
      where: where(StockPrice.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StockPriceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StockPrice>(
      where: where?.call(StockPrice.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StockPriceAttachRowRepository {
  const StockPriceAttachRowRepository._();

  /// Creates a relation between the given [StockPrice] and [Stock]
  /// by setting the [StockPrice]'s foreign key `stockId` to refer to the [Stock].
  Future<void> stock(
    _i1.Session session,
    StockPrice stockPrice,
    _i2.Stock stock, {
    _i1.Transaction? transaction,
  }) async {
    if (stockPrice.id == null) {
      throw ArgumentError.notNull('stockPrice.id');
    }
    if (stock.id == null) {
      throw ArgumentError.notNull('stock.id');
    }

    var $stockPrice = stockPrice.copyWith(stockId: stock.id);
    await session.db.updateRow<StockPrice>(
      $stockPrice,
      columns: [StockPrice.t.stockId],
      transaction: transaction,
    );
  }
}
