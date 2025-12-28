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
import '../../withdrawal/models/withdrawal_rule.dart' as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class WithdrawalFee
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WithdrawalFee._({
    this.id,
    double? fixed,
    double? percent,
    double? minimum,
    required this.ruleId,
    this.rule,
  }) : fixed = fixed ?? 0.0,
       percent = percent ?? 0.0,
       minimum = minimum ?? 0.0;

  factory WithdrawalFee({
    int? id,
    double? fixed,
    double? percent,
    double? minimum,
    required int ruleId,
    _i2.WithdrawalRule? rule,
  }) = _WithdrawalFeeImpl;

  factory WithdrawalFee.fromJson(Map<String, dynamic> jsonSerialization) {
    return WithdrawalFee(
      id: jsonSerialization['id'] as int?,
      fixed: (jsonSerialization['fixed'] as num).toDouble(),
      percent: (jsonSerialization['percent'] as num).toDouble(),
      minimum: (jsonSerialization['minimum'] as num).toDouble(),
      ruleId: jsonSerialization['ruleId'] as int,
      rule: jsonSerialization['rule'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.WithdrawalRule>(
              jsonSerialization['rule'],
            ),
    );
  }

  static final t = WithdrawalFeeTable();

  static const db = WithdrawalFeeRepository._();

  @override
  int? id;

  double fixed;

  double percent;

  double minimum;

  int ruleId;

  _i2.WithdrawalRule? rule;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WithdrawalFee]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WithdrawalFee copyWith({
    int? id,
    double? fixed,
    double? percent,
    double? minimum,
    int? ruleId,
    _i2.WithdrawalRule? rule,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WithdrawalFee',
      if (id != null) 'id': id,
      'fixed': fixed,
      'percent': percent,
      'minimum': minimum,
      'ruleId': ruleId,
      if (rule != null) 'rule': rule?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WithdrawalFee',
      if (id != null) 'id': id,
      'fixed': fixed,
      'percent': percent,
      'minimum': minimum,
      'ruleId': ruleId,
      if (rule != null) 'rule': rule?.toJsonForProtocol(),
    };
  }

  static WithdrawalFeeInclude include({_i2.WithdrawalRuleInclude? rule}) {
    return WithdrawalFeeInclude._(rule: rule);
  }

  static WithdrawalFeeIncludeList includeList({
    _i1.WhereExpressionBuilder<WithdrawalFeeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WithdrawalFeeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WithdrawalFeeTable>? orderByList,
    WithdrawalFeeInclude? include,
  }) {
    return WithdrawalFeeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WithdrawalFee.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WithdrawalFee.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WithdrawalFeeImpl extends WithdrawalFee {
  _WithdrawalFeeImpl({
    int? id,
    double? fixed,
    double? percent,
    double? minimum,
    required int ruleId,
    _i2.WithdrawalRule? rule,
  }) : super._(
         id: id,
         fixed: fixed,
         percent: percent,
         minimum: minimum,
         ruleId: ruleId,
         rule: rule,
       );

  /// Returns a shallow copy of this [WithdrawalFee]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WithdrawalFee copyWith({
    Object? id = _Undefined,
    double? fixed,
    double? percent,
    double? minimum,
    int? ruleId,
    Object? rule = _Undefined,
  }) {
    return WithdrawalFee(
      id: id is int? ? id : this.id,
      fixed: fixed ?? this.fixed,
      percent: percent ?? this.percent,
      minimum: minimum ?? this.minimum,
      ruleId: ruleId ?? this.ruleId,
      rule: rule is _i2.WithdrawalRule? ? rule : this.rule?.copyWith(),
    );
  }
}

class WithdrawalFeeUpdateTable extends _i1.UpdateTable<WithdrawalFeeTable> {
  WithdrawalFeeUpdateTable(super.table);

  _i1.ColumnValue<double, double> fixed(double value) => _i1.ColumnValue(
    table.fixed,
    value,
  );

  _i1.ColumnValue<double, double> percent(double value) => _i1.ColumnValue(
    table.percent,
    value,
  );

  _i1.ColumnValue<double, double> minimum(double value) => _i1.ColumnValue(
    table.minimum,
    value,
  );

  _i1.ColumnValue<int, int> ruleId(int value) => _i1.ColumnValue(
    table.ruleId,
    value,
  );
}

class WithdrawalFeeTable extends _i1.Table<int?> {
  WithdrawalFeeTable({super.tableRelation})
    : super(tableName: 'withdrawal_fee') {
    updateTable = WithdrawalFeeUpdateTable(this);
    fixed = _i1.ColumnDouble(
      'fixed',
      this,
      hasDefault: true,
    );
    percent = _i1.ColumnDouble(
      'percent',
      this,
      hasDefault: true,
    );
    minimum = _i1.ColumnDouble(
      'minimum',
      this,
      hasDefault: true,
    );
    ruleId = _i1.ColumnInt(
      'ruleId',
      this,
    );
  }

  late final WithdrawalFeeUpdateTable updateTable;

  late final _i1.ColumnDouble fixed;

  late final _i1.ColumnDouble percent;

  late final _i1.ColumnDouble minimum;

  late final _i1.ColumnInt ruleId;

  _i2.WithdrawalRuleTable? _rule;

  _i2.WithdrawalRuleTable get rule {
    if (_rule != null) return _rule!;
    _rule = _i1.createRelationTable(
      relationFieldName: 'rule',
      field: WithdrawalFee.t.ruleId,
      foreignField: _i2.WithdrawalRule.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.WithdrawalRuleTable(tableRelation: foreignTableRelation),
    );
    return _rule!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    fixed,
    percent,
    minimum,
    ruleId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'rule') {
      return rule;
    }
    return null;
  }
}

class WithdrawalFeeInclude extends _i1.IncludeObject {
  WithdrawalFeeInclude._({_i2.WithdrawalRuleInclude? rule}) {
    _rule = rule;
  }

  _i2.WithdrawalRuleInclude? _rule;

  @override
  Map<String, _i1.Include?> get includes => {'rule': _rule};

  @override
  _i1.Table<int?> get table => WithdrawalFee.t;
}

class WithdrawalFeeIncludeList extends _i1.IncludeList {
  WithdrawalFeeIncludeList._({
    _i1.WhereExpressionBuilder<WithdrawalFeeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WithdrawalFee.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WithdrawalFee.t;
}

class WithdrawalFeeRepository {
  const WithdrawalFeeRepository._();

  final attachRow = const WithdrawalFeeAttachRowRepository._();

  /// Returns a list of [WithdrawalFee]s matching the given query parameters.
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
  Future<List<WithdrawalFee>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WithdrawalFeeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WithdrawalFeeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WithdrawalFeeTable>? orderByList,
    _i1.Transaction? transaction,
    WithdrawalFeeInclude? include,
  }) async {
    return session.db.find<WithdrawalFee>(
      where: where?.call(WithdrawalFee.t),
      orderBy: orderBy?.call(WithdrawalFee.t),
      orderByList: orderByList?.call(WithdrawalFee.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [WithdrawalFee] matching the given query parameters.
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
  Future<WithdrawalFee?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WithdrawalFeeTable>? where,
    int? offset,
    _i1.OrderByBuilder<WithdrawalFeeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WithdrawalFeeTable>? orderByList,
    _i1.Transaction? transaction,
    WithdrawalFeeInclude? include,
  }) async {
    return session.db.findFirstRow<WithdrawalFee>(
      where: where?.call(WithdrawalFee.t),
      orderBy: orderBy?.call(WithdrawalFee.t),
      orderByList: orderByList?.call(WithdrawalFee.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [WithdrawalFee] by its [id] or null if no such row exists.
  Future<WithdrawalFee?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    WithdrawalFeeInclude? include,
  }) async {
    return session.db.findById<WithdrawalFee>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [WithdrawalFee]s in the list and returns the inserted rows.
  ///
  /// The returned [WithdrawalFee]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WithdrawalFee>> insert(
    _i1.Session session,
    List<WithdrawalFee> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WithdrawalFee>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WithdrawalFee] and returns the inserted row.
  ///
  /// The returned [WithdrawalFee] will have its `id` field set.
  Future<WithdrawalFee> insertRow(
    _i1.Session session,
    WithdrawalFee row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WithdrawalFee>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WithdrawalFee]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WithdrawalFee>> update(
    _i1.Session session,
    List<WithdrawalFee> rows, {
    _i1.ColumnSelections<WithdrawalFeeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WithdrawalFee>(
      rows,
      columns: columns?.call(WithdrawalFee.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WithdrawalFee]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WithdrawalFee> updateRow(
    _i1.Session session,
    WithdrawalFee row, {
    _i1.ColumnSelections<WithdrawalFeeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WithdrawalFee>(
      row,
      columns: columns?.call(WithdrawalFee.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WithdrawalFee] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WithdrawalFee?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WithdrawalFeeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WithdrawalFee>(
      id,
      columnValues: columnValues(WithdrawalFee.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WithdrawalFee]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WithdrawalFee>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WithdrawalFeeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WithdrawalFeeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WithdrawalFeeTable>? orderBy,
    _i1.OrderByListBuilder<WithdrawalFeeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WithdrawalFee>(
      columnValues: columnValues(WithdrawalFee.t.updateTable),
      where: where(WithdrawalFee.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WithdrawalFee.t),
      orderByList: orderByList?.call(WithdrawalFee.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WithdrawalFee]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WithdrawalFee>> delete(
    _i1.Session session,
    List<WithdrawalFee> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WithdrawalFee>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WithdrawalFee].
  Future<WithdrawalFee> deleteRow(
    _i1.Session session,
    WithdrawalFee row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WithdrawalFee>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WithdrawalFee>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WithdrawalFeeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WithdrawalFee>(
      where: where(WithdrawalFee.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WithdrawalFeeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WithdrawalFee>(
      where: where?.call(WithdrawalFee.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class WithdrawalFeeAttachRowRepository {
  const WithdrawalFeeAttachRowRepository._();

  /// Creates a relation between the given [WithdrawalFee] and [WithdrawalRule]
  /// by setting the [WithdrawalFee]'s foreign key `ruleId` to refer to the [WithdrawalRule].
  Future<void> rule(
    _i1.Session session,
    WithdrawalFee withdrawalFee,
    _i2.WithdrawalRule rule, {
    _i1.Transaction? transaction,
  }) async {
    if (withdrawalFee.id == null) {
      throw ArgumentError.notNull('withdrawalFee.id');
    }
    if (rule.id == null) {
      throw ArgumentError.notNull('rule.id');
    }

    var $withdrawalFee = withdrawalFee.copyWith(ruleId: rule.id);
    await session.db.updateRow<WithdrawalFee>(
      $withdrawalFee,
      columns: [WithdrawalFee.t.ruleId],
      transaction: transaction,
    );
  }
}
