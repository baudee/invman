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
import '../../../features/investment/models/investment.dart' as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class Transfer
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Transfer._({
    this.id,
    required this.investmentId,
    this.investment,
    required this.quantity,
    required this.amount,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Transfer({
    int? id,
    required int investmentId,
    _i2.Investment? investment,
    required double quantity,
    required double amount,
    DateTime? createdAt,
  }) = _TransferImpl;

  factory Transfer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transfer(
      id: jsonSerialization['id'] as int?,
      investmentId: jsonSerialization['investmentId'] as int,
      investment: jsonSerialization['investment'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Investment>(
              jsonSerialization['investment'],
            ),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = TransferTable();

  static const db = TransferRepository._();

  @override
  int? id;

  int investmentId;

  _i2.Investment? investment;

  double quantity;

  double amount;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Transfer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transfer copyWith({
    int? id,
    int? investmentId,
    _i2.Investment? investment,
    double? quantity,
    double? amount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Transfer',
      if (id != null) 'id': id,
      'investmentId': investmentId,
      if (investment != null) 'investment': investment?.toJson(),
      'quantity': quantity,
      'amount': amount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Transfer',
      if (id != null) 'id': id,
      'investmentId': investmentId,
      if (investment != null) 'investment': investment?.toJsonForProtocol(),
      'quantity': quantity,
      'amount': amount,
      'createdAt': createdAt.toJson(),
    };
  }

  static TransferInclude include({_i2.InvestmentInclude? investment}) {
    return TransferInclude._(investment: investment);
  }

  static TransferIncludeList includeList({
    _i1.WhereExpressionBuilder<TransferTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransferTable>? orderByList,
    TransferInclude? include,
  }) {
    return TransferIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Transfer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Transfer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransferImpl extends Transfer {
  _TransferImpl({
    int? id,
    required int investmentId,
    _i2.Investment? investment,
    required double quantity,
    required double amount,
    DateTime? createdAt,
  }) : super._(
         id: id,
         investmentId: investmentId,
         investment: investment,
         quantity: quantity,
         amount: amount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Transfer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transfer copyWith({
    Object? id = _Undefined,
    int? investmentId,
    Object? investment = _Undefined,
    double? quantity,
    double? amount,
    DateTime? createdAt,
  }) {
    return Transfer(
      id: id is int? ? id : this.id,
      investmentId: investmentId ?? this.investmentId,
      investment: investment is _i2.Investment?
          ? investment
          : this.investment?.copyWith(),
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TransferUpdateTable extends _i1.UpdateTable<TransferTable> {
  TransferUpdateTable(super.table);

  _i1.ColumnValue<int, int> investmentId(int value) => _i1.ColumnValue(
    table.investmentId,
    value,
  );

  _i1.ColumnValue<double, double> quantity(double value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<double, double> amount(double value) => _i1.ColumnValue(
    table.amount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class TransferTable extends _i1.Table<int?> {
  TransferTable({super.tableRelation}) : super(tableName: 'transfer') {
    updateTable = TransferUpdateTable(this);
    investmentId = _i1.ColumnInt(
      'investmentId',
      this,
    );
    quantity = _i1.ColumnDouble(
      'quantity',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final TransferUpdateTable updateTable;

  late final _i1.ColumnInt investmentId;

  _i2.InvestmentTable? _investment;

  late final _i1.ColumnDouble quantity;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnDateTime createdAt;

  _i2.InvestmentTable get investment {
    if (_investment != null) return _investment!;
    _investment = _i1.createRelationTable(
      relationFieldName: 'investment',
      field: Transfer.t.investmentId,
      foreignField: _i2.Investment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.InvestmentTable(tableRelation: foreignTableRelation),
    );
    return _investment!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    investmentId,
    quantity,
    amount,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'investment') {
      return investment;
    }
    return null;
  }
}

class TransferInclude extends _i1.IncludeObject {
  TransferInclude._({_i2.InvestmentInclude? investment}) {
    _investment = investment;
  }

  _i2.InvestmentInclude? _investment;

  @override
  Map<String, _i1.Include?> get includes => {'investment': _investment};

  @override
  _i1.Table<int?> get table => Transfer.t;
}

class TransferIncludeList extends _i1.IncludeList {
  TransferIncludeList._({
    _i1.WhereExpressionBuilder<TransferTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Transfer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Transfer.t;
}

class TransferRepository {
  const TransferRepository._();

  final attachRow = const TransferAttachRowRepository._();

  /// Returns a list of [Transfer]s matching the given query parameters.
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
  Future<List<Transfer>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TransferTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransferTable>? orderByList,
    _i1.Transaction? transaction,
    TransferInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Transfer>(
      where: where?.call(Transfer.t),
      orderBy: orderBy?.call(Transfer.t),
      orderByList: orderByList?.call(Transfer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Transfer] matching the given query parameters.
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
  Future<Transfer?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TransferTable>? where,
    int? offset,
    _i1.OrderByBuilder<TransferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransferTable>? orderByList,
    _i1.Transaction? transaction,
    TransferInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Transfer>(
      where: where?.call(Transfer.t),
      orderBy: orderBy?.call(Transfer.t),
      orderByList: orderByList?.call(Transfer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Transfer] by its [id] or null if no such row exists.
  Future<Transfer?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TransferInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Transfer>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Transfer]s in the list and returns the inserted rows.
  ///
  /// The returned [Transfer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Transfer>> insert(
    _i1.DatabaseSession session,
    List<Transfer> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Transfer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Transfer] and returns the inserted row.
  ///
  /// The returned [Transfer] will have its `id` field set.
  Future<Transfer> insertRow(
    _i1.DatabaseSession session,
    Transfer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Transfer>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Transfer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Transfer>> update(
    _i1.DatabaseSession session,
    List<Transfer> rows, {
    _i1.ColumnSelections<TransferTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Transfer>(
      rows,
      columns: columns?.call(Transfer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Transfer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Transfer> updateRow(
    _i1.DatabaseSession session,
    Transfer row, {
    _i1.ColumnSelections<TransferTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Transfer>(
      row,
      columns: columns?.call(Transfer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Transfer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Transfer?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TransferUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Transfer>(
      id,
      columnValues: columnValues(Transfer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Transfer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Transfer>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TransferUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TransferTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransferTable>? orderBy,
    _i1.OrderByListBuilder<TransferTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Transfer>(
      columnValues: columnValues(Transfer.t.updateTable),
      where: where(Transfer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Transfer.t),
      orderByList: orderByList?.call(Transfer.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Transfer]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Transfer>> delete(
    _i1.DatabaseSession session,
    List<Transfer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Transfer>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Transfer].
  Future<Transfer> deleteRow(
    _i1.DatabaseSession session,
    Transfer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Transfer>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Transfer>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TransferTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Transfer>(
      where: where(Transfer.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TransferTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Transfer>(
      where: where?.call(Transfer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Transfer] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TransferTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Transfer>(
      where: where(Transfer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TransferAttachRowRepository {
  const TransferAttachRowRepository._();

  /// Creates a relation between the given [Transfer] and [Investment]
  /// by setting the [Transfer]'s foreign key `investmentId` to refer to the [Investment].
  Future<void> investment(
    _i1.DatabaseSession session,
    Transfer transfer,
    _i2.Investment investment, {
    _i1.Transaction? transaction,
  }) async {
    if (transfer.id == null) {
      throw ArgumentError.notNull('transfer.id');
    }
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }

    var $transfer = transfer.copyWith(investmentId: investment.id);
    await session.db.updateRow<Transfer>(
      $transfer,
      columns: [Transfer.t.investmentId],
      transaction: transaction,
    );
  }
}
