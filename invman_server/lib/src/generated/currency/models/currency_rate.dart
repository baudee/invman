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
import '../../currency/models/currency.dart' as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class CurrencyRate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CurrencyRate._({
    this.id,
    required this.dollarValue,
    required this.timestamp,
    required this.currencyId,
    this.currency,
  });

  factory CurrencyRate({
    int? id,
    required double dollarValue,
    required DateTime timestamp,
    required int currencyId,
    _i2.Currency? currency,
  }) = _CurrencyRateImpl;

  factory CurrencyRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurrencyRate(
      id: jsonSerialization['id'] as int?,
      dollarValue: (jsonSerialization['dollarValue'] as num).toDouble(),
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      currencyId: jsonSerialization['currencyId'] as int,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Currency>(
              jsonSerialization['currency'],
            ),
    );
  }

  static final t = CurrencyRateTable();

  static const db = CurrencyRateRepository._();

  @override
  int? id;

  double dollarValue;

  DateTime timestamp;

  int currencyId;

  _i2.Currency? currency;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CurrencyRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CurrencyRate copyWith({
    int? id,
    double? dollarValue,
    DateTime? timestamp,
    int? currencyId,
    _i2.Currency? currency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurrencyRate',
      if (id != null) 'id': id,
      'dollarValue': dollarValue,
      'timestamp': timestamp.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CurrencyRate',
      if (id != null) 'id': id,
      'dollarValue': dollarValue,
      'timestamp': timestamp.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJsonForProtocol(),
    };
  }

  static CurrencyRateInclude include({_i2.CurrencyInclude? currency}) {
    return CurrencyRateInclude._(currency: currency);
  }

  static CurrencyRateIncludeList includeList({
    _i1.WhereExpressionBuilder<CurrencyRateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurrencyRateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurrencyRateTable>? orderByList,
    CurrencyRateInclude? include,
  }) {
    return CurrencyRateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CurrencyRate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CurrencyRate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurrencyRateImpl extends CurrencyRate {
  _CurrencyRateImpl({
    int? id,
    required double dollarValue,
    required DateTime timestamp,
    required int currencyId,
    _i2.Currency? currency,
  }) : super._(
         id: id,
         dollarValue: dollarValue,
         timestamp: timestamp,
         currencyId: currencyId,
         currency: currency,
       );

  /// Returns a shallow copy of this [CurrencyRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CurrencyRate copyWith({
    Object? id = _Undefined,
    double? dollarValue,
    DateTime? timestamp,
    int? currencyId,
    Object? currency = _Undefined,
  }) {
    return CurrencyRate(
      id: id is int? ? id : this.id,
      dollarValue: dollarValue ?? this.dollarValue,
      timestamp: timestamp ?? this.timestamp,
      currencyId: currencyId ?? this.currencyId,
      currency: currency is _i2.Currency?
          ? currency
          : this.currency?.copyWith(),
    );
  }
}

class CurrencyRateUpdateTable extends _i1.UpdateTable<CurrencyRateTable> {
  CurrencyRateUpdateTable(super.table);

  _i1.ColumnValue<double, double> dollarValue(double value) => _i1.ColumnValue(
    table.dollarValue,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<int, int> currencyId(int value) => _i1.ColumnValue(
    table.currencyId,
    value,
  );
}

class CurrencyRateTable extends _i1.Table<int?> {
  CurrencyRateTable({super.tableRelation}) : super(tableName: 'currency_rate') {
    updateTable = CurrencyRateUpdateTable(this);
    dollarValue = _i1.ColumnDouble(
      'dollarValue',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    currencyId = _i1.ColumnInt(
      'currencyId',
      this,
    );
  }

  late final CurrencyRateUpdateTable updateTable;

  late final _i1.ColumnDouble dollarValue;

  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnInt currencyId;

  _i2.CurrencyTable? _currency;

  _i2.CurrencyTable get currency {
    if (_currency != null) return _currency!;
    _currency = _i1.createRelationTable(
      relationFieldName: 'currency',
      field: CurrencyRate.t.currencyId,
      foreignField: _i2.Currency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CurrencyTable(tableRelation: foreignTableRelation),
    );
    return _currency!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    dollarValue,
    timestamp,
    currencyId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'currency') {
      return currency;
    }
    return null;
  }
}

class CurrencyRateInclude extends _i1.IncludeObject {
  CurrencyRateInclude._({_i2.CurrencyInclude? currency}) {
    _currency = currency;
  }

  _i2.CurrencyInclude? _currency;

  @override
  Map<String, _i1.Include?> get includes => {'currency': _currency};

  @override
  _i1.Table<int?> get table => CurrencyRate.t;
}

class CurrencyRateIncludeList extends _i1.IncludeList {
  CurrencyRateIncludeList._({
    _i1.WhereExpressionBuilder<CurrencyRateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CurrencyRate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CurrencyRate.t;
}

class CurrencyRateRepository {
  const CurrencyRateRepository._();

  final attachRow = const CurrencyRateAttachRowRepository._();

  /// Returns a list of [CurrencyRate]s matching the given query parameters.
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
  Future<List<CurrencyRate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CurrencyRateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurrencyRateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurrencyRateTable>? orderByList,
    _i1.Transaction? transaction,
    CurrencyRateInclude? include,
  }) async {
    return session.db.find<CurrencyRate>(
      where: where?.call(CurrencyRate.t),
      orderBy: orderBy?.call(CurrencyRate.t),
      orderByList: orderByList?.call(CurrencyRate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CurrencyRate] matching the given query parameters.
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
  Future<CurrencyRate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CurrencyRateTable>? where,
    int? offset,
    _i1.OrderByBuilder<CurrencyRateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurrencyRateTable>? orderByList,
    _i1.Transaction? transaction,
    CurrencyRateInclude? include,
  }) async {
    return session.db.findFirstRow<CurrencyRate>(
      where: where?.call(CurrencyRate.t),
      orderBy: orderBy?.call(CurrencyRate.t),
      orderByList: orderByList?.call(CurrencyRate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CurrencyRate] by its [id] or null if no such row exists.
  Future<CurrencyRate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CurrencyRateInclude? include,
  }) async {
    return session.db.findById<CurrencyRate>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CurrencyRate]s in the list and returns the inserted rows.
  ///
  /// The returned [CurrencyRate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CurrencyRate>> insert(
    _i1.Session session,
    List<CurrencyRate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CurrencyRate>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CurrencyRate] and returns the inserted row.
  ///
  /// The returned [CurrencyRate] will have its `id` field set.
  Future<CurrencyRate> insertRow(
    _i1.Session session,
    CurrencyRate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CurrencyRate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CurrencyRate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CurrencyRate>> update(
    _i1.Session session,
    List<CurrencyRate> rows, {
    _i1.ColumnSelections<CurrencyRateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CurrencyRate>(
      rows,
      columns: columns?.call(CurrencyRate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CurrencyRate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CurrencyRate> updateRow(
    _i1.Session session,
    CurrencyRate row, {
    _i1.ColumnSelections<CurrencyRateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CurrencyRate>(
      row,
      columns: columns?.call(CurrencyRate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CurrencyRate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CurrencyRate?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CurrencyRateUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CurrencyRate>(
      id,
      columnValues: columnValues(CurrencyRate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CurrencyRate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CurrencyRate>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CurrencyRateUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CurrencyRateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurrencyRateTable>? orderBy,
    _i1.OrderByListBuilder<CurrencyRateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CurrencyRate>(
      columnValues: columnValues(CurrencyRate.t.updateTable),
      where: where(CurrencyRate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CurrencyRate.t),
      orderByList: orderByList?.call(CurrencyRate.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CurrencyRate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CurrencyRate>> delete(
    _i1.Session session,
    List<CurrencyRate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CurrencyRate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CurrencyRate].
  Future<CurrencyRate> deleteRow(
    _i1.Session session,
    CurrencyRate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CurrencyRate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CurrencyRate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CurrencyRateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CurrencyRate>(
      where: where(CurrencyRate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CurrencyRateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CurrencyRate>(
      where: where?.call(CurrencyRate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CurrencyRateAttachRowRepository {
  const CurrencyRateAttachRowRepository._();

  /// Creates a relation between the given [CurrencyRate] and [Currency]
  /// by setting the [CurrencyRate]'s foreign key `currencyId` to refer to the [Currency].
  Future<void> currency(
    _i1.Session session,
    CurrencyRate currencyRate,
    _i2.Currency currency, {
    _i1.Transaction? transaction,
  }) async {
    if (currencyRate.id == null) {
      throw ArgumentError.notNull('currencyRate.id');
    }
    if (currency.id == null) {
      throw ArgumentError.notNull('currency.id');
    }

    var $currencyRate = currencyRate.copyWith(currencyId: currency.id);
    await session.db.updateRow<CurrencyRate>(
      $currencyRate,
      columns: [CurrencyRate.t.currencyId],
      transaction: transaction,
    );
  }
}
