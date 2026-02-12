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
import '../../currency/models/currency_rate.dart' as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class Currency
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Currency._({
    this.id,
    required this.code,
    this.rates,
  });

  factory Currency({
    int? id,
    required String code,
    List<_i2.CurrencyRate>? rates,
  }) = _CurrencyImpl;

  factory Currency.fromJson(Map<String, dynamic> jsonSerialization) {
    return Currency(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      rates: jsonSerialization['rates'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.CurrencyRate>>(
              jsonSerialization['rates'],
            ),
    );
  }

  static final t = CurrencyTable();

  static const db = CurrencyRepository._();

  @override
  int? id;

  String code;

  List<_i2.CurrencyRate>? rates;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Currency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Currency copyWith({
    int? id,
    String? code,
    List<_i2.CurrencyRate>? rates,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Currency',
      if (id != null) 'id': id,
      'code': code,
      if (rates != null) 'rates': rates?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Currency',
      if (id != null) 'id': id,
      'code': code,
      if (rates != null)
        'rates': rates?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static CurrencyInclude include({_i2.CurrencyRateIncludeList? rates}) {
    return CurrencyInclude._(rates: rates);
  }

  static CurrencyIncludeList includeList({
    _i1.WhereExpressionBuilder<CurrencyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurrencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurrencyTable>? orderByList,
    CurrencyInclude? include,
  }) {
    return CurrencyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Currency.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Currency.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurrencyImpl extends Currency {
  _CurrencyImpl({
    int? id,
    required String code,
    List<_i2.CurrencyRate>? rates,
  }) : super._(
         id: id,
         code: code,
         rates: rates,
       );

  /// Returns a shallow copy of this [Currency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Currency copyWith({
    Object? id = _Undefined,
    String? code,
    Object? rates = _Undefined,
  }) {
    return Currency(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      rates: rates is List<_i2.CurrencyRate>?
          ? rates
          : this.rates?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CurrencyUpdateTable extends _i1.UpdateTable<CurrencyTable> {
  CurrencyUpdateTable(super.table);

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );
}

class CurrencyTable extends _i1.Table<int?> {
  CurrencyTable({super.tableRelation}) : super(tableName: 'currency') {
    updateTable = CurrencyUpdateTable(this);
    code = _i1.ColumnString(
      'code',
      this,
    );
  }

  late final CurrencyUpdateTable updateTable;

  late final _i1.ColumnString code;

  _i2.CurrencyRateTable? ___rates;

  _i1.ManyRelation<_i2.CurrencyRateTable>? _rates;

  _i2.CurrencyRateTable get __rates {
    if (___rates != null) return ___rates!;
    ___rates = _i1.createRelationTable(
      relationFieldName: '__rates',
      field: Currency.t.id,
      foreignField: _i2.CurrencyRate.t.currencyId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CurrencyRateTable(tableRelation: foreignTableRelation),
    );
    return ___rates!;
  }

  _i1.ManyRelation<_i2.CurrencyRateTable> get rates {
    if (_rates != null) return _rates!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'rates',
      field: Currency.t.id,
      foreignField: _i2.CurrencyRate.t.currencyId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CurrencyRateTable(tableRelation: foreignTableRelation),
    );
    _rates = _i1.ManyRelation<_i2.CurrencyRateTable>(
      tableWithRelations: relationTable,
      table: _i2.CurrencyRateTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _rates!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    code,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'rates') {
      return __rates;
    }
    return null;
  }
}

class CurrencyInclude extends _i1.IncludeObject {
  CurrencyInclude._({_i2.CurrencyRateIncludeList? rates}) {
    _rates = rates;
  }

  _i2.CurrencyRateIncludeList? _rates;

  @override
  Map<String, _i1.Include?> get includes => {'rates': _rates};

  @override
  _i1.Table<int?> get table => Currency.t;
}

class CurrencyIncludeList extends _i1.IncludeList {
  CurrencyIncludeList._({
    _i1.WhereExpressionBuilder<CurrencyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Currency.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Currency.t;
}

class CurrencyRepository {
  const CurrencyRepository._();

  final attach = const CurrencyAttachRepository._();

  final attachRow = const CurrencyAttachRowRepository._();

  final detach = const CurrencyDetachRepository._();

  final detachRow = const CurrencyDetachRowRepository._();

  /// Returns a list of [Currency]s matching the given query parameters.
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
  Future<List<Currency>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CurrencyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurrencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurrencyTable>? orderByList,
    _i1.Transaction? transaction,
    CurrencyInclude? include,
  }) async {
    return session.db.find<Currency>(
      where: where?.call(Currency.t),
      orderBy: orderBy?.call(Currency.t),
      orderByList: orderByList?.call(Currency.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Currency] matching the given query parameters.
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
  Future<Currency?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CurrencyTable>? where,
    int? offset,
    _i1.OrderByBuilder<CurrencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurrencyTable>? orderByList,
    _i1.Transaction? transaction,
    CurrencyInclude? include,
  }) async {
    return session.db.findFirstRow<Currency>(
      where: where?.call(Currency.t),
      orderBy: orderBy?.call(Currency.t),
      orderByList: orderByList?.call(Currency.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Currency] by its [id] or null if no such row exists.
  Future<Currency?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CurrencyInclude? include,
  }) async {
    return session.db.findById<Currency>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Currency]s in the list and returns the inserted rows.
  ///
  /// The returned [Currency]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Currency>> insert(
    _i1.Session session,
    List<Currency> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Currency>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Currency] and returns the inserted row.
  ///
  /// The returned [Currency] will have its `id` field set.
  Future<Currency> insertRow(
    _i1.Session session,
    Currency row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Currency>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Currency]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Currency>> update(
    _i1.Session session,
    List<Currency> rows, {
    _i1.ColumnSelections<CurrencyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Currency>(
      rows,
      columns: columns?.call(Currency.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Currency]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Currency> updateRow(
    _i1.Session session,
    Currency row, {
    _i1.ColumnSelections<CurrencyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Currency>(
      row,
      columns: columns?.call(Currency.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Currency] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Currency?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CurrencyUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Currency>(
      id,
      columnValues: columnValues(Currency.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Currency]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Currency>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CurrencyUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CurrencyTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurrencyTable>? orderBy,
    _i1.OrderByListBuilder<CurrencyTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Currency>(
      columnValues: columnValues(Currency.t.updateTable),
      where: where(Currency.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Currency.t),
      orderByList: orderByList?.call(Currency.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Currency]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Currency>> delete(
    _i1.Session session,
    List<Currency> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Currency>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Currency].
  Future<Currency> deleteRow(
    _i1.Session session,
    Currency row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Currency>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Currency>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CurrencyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Currency>(
      where: where(Currency.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CurrencyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Currency>(
      where: where?.call(Currency.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CurrencyAttachRepository {
  const CurrencyAttachRepository._();

  /// Creates a relation between this [Currency] and the given [CurrencyRate]s
  /// by setting each [CurrencyRate]'s foreign key `currencyId` to refer to this [Currency].
  Future<void> rates(
    _i1.Session session,
    Currency currency,
    List<_i2.CurrencyRate> currencyRate, {
    _i1.Transaction? transaction,
  }) async {
    if (currencyRate.any((e) => e.id == null)) {
      throw ArgumentError.notNull('currencyRate.id');
    }
    if (currency.id == null) {
      throw ArgumentError.notNull('currency.id');
    }

    var $currencyRate = currencyRate
        .map((e) => e.copyWith(currencyId: currency.id))
        .toList();
    await session.db.update<_i2.CurrencyRate>(
      $currencyRate,
      columns: [_i2.CurrencyRate.t.currencyId],
      transaction: transaction,
    );
  }
}

class CurrencyAttachRowRepository {
  const CurrencyAttachRowRepository._();

  /// Creates a relation between this [Currency] and the given [CurrencyRate]
  /// by setting the [CurrencyRate]'s foreign key `currencyId` to refer to this [Currency].
  Future<void> rates(
    _i1.Session session,
    Currency currency,
    _i2.CurrencyRate currencyRate, {
    _i1.Transaction? transaction,
  }) async {
    if (currencyRate.id == null) {
      throw ArgumentError.notNull('currencyRate.id');
    }
    if (currency.id == null) {
      throw ArgumentError.notNull('currency.id');
    }

    var $currencyRate = currencyRate.copyWith(currencyId: currency.id);
    await session.db.updateRow<_i2.CurrencyRate>(
      $currencyRate,
      columns: [_i2.CurrencyRate.t.currencyId],
      transaction: transaction,
    );
  }
}

class CurrencyDetachRepository {
  const CurrencyDetachRepository._();

  /// Detaches the relation between this [Currency] and the given [CurrencyRate]
  /// by setting the [CurrencyRate]'s foreign key `currencyId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> rates(
    _i1.Session session,
    List<_i2.CurrencyRate> currencyRate, {
    _i1.Transaction? transaction,
  }) async {
    if (currencyRate.any((e) => e.id == null)) {
      throw ArgumentError.notNull('currencyRate.id');
    }

    var $currencyRate = currencyRate
        .map((e) => e.copyWith(currencyId: null))
        .toList();
    await session.db.update<_i2.CurrencyRate>(
      $currencyRate,
      columns: [_i2.CurrencyRate.t.currencyId],
      transaction: transaction,
    );
  }
}

class CurrencyDetachRowRepository {
  const CurrencyDetachRowRepository._();

  /// Detaches the relation between this [Currency] and the given [CurrencyRate]
  /// by setting the [CurrencyRate]'s foreign key `currencyId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> rates(
    _i1.Session session,
    _i2.CurrencyRate currencyRate, {
    _i1.Transaction? transaction,
  }) async {
    if (currencyRate.id == null) {
      throw ArgumentError.notNull('currencyRate.id');
    }

    var $currencyRate = currencyRate.copyWith(currencyId: null);
    await session.db.updateRow<_i2.CurrencyRate>(
      $currencyRate,
      columns: [_i2.CurrencyRate.t.currencyId],
      transaction: transaction,
    );
  }
}
