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
import '../../withdrawal/models/withdrawal_fee.dart' as _i3;
import 'package:invman_server/src/generated/protocol.dart' as _i4;

abstract class WithdrawalRule implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WithdrawalRule._({
    this.id,
    required this.userId,
    this.user,
    required this.name,
    required this.currencyChangePercentage,
    this.fees,
  });

  factory WithdrawalRule({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required String name,
    required double currencyChangePercentage,
    List<_i3.WithdrawalFee>? fees,
  }) = _WithdrawalRuleImpl;

  factory WithdrawalRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return WithdrawalRule(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      name: jsonSerialization['name'] as String,
      currencyChangePercentage: (jsonSerialization['currencyChangePercentage'] as num).toDouble(),
      fees: jsonSerialization['fees'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.WithdrawalFee>>(
              jsonSerialization['fees'],
            ),
    );
  }

  static final t = WithdrawalRuleTable();

  static const db = WithdrawalRuleRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  _i2.AuthUser? user;

  String name;

  double currencyChangePercentage;

  List<_i3.WithdrawalFee>? fees;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WithdrawalRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WithdrawalRule copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    String? name,
    double? currencyChangePercentage,
    List<_i3.WithdrawalFee>? fees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WithdrawalRule',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'name': name,
      'currencyChangePercentage': currencyChangePercentage,
      if (fees != null) 'fees': fees?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WithdrawalRule',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'name': name,
      'currencyChangePercentage': currencyChangePercentage,
      if (fees != null) 'fees': fees?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static WithdrawalRuleInclude include({
    _i2.AuthUserInclude? user,
    _i3.WithdrawalFeeIncludeList? fees,
  }) {
    return WithdrawalRuleInclude._(
      user: user,
      fees: fees,
    );
  }

  static WithdrawalRuleIncludeList includeList({
    _i1.WhereExpressionBuilder<WithdrawalRuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WithdrawalRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WithdrawalRuleTable>? orderByList,
    WithdrawalRuleInclude? include,
  }) {
    return WithdrawalRuleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WithdrawalRule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WithdrawalRule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WithdrawalRuleImpl extends WithdrawalRule {
  _WithdrawalRuleImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required String name,
    required double currencyChangePercentage,
    List<_i3.WithdrawalFee>? fees,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         name: name,
         currencyChangePercentage: currencyChangePercentage,
         fees: fees,
       );

  /// Returns a shallow copy of this [WithdrawalRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WithdrawalRule copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? name,
    double? currencyChangePercentage,
    Object? fees = _Undefined,
  }) {
    return WithdrawalRule(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      name: name ?? this.name,
      currencyChangePercentage: currencyChangePercentage ?? this.currencyChangePercentage,
      fees: fees is List<_i3.WithdrawalFee>? ? fees : this.fees?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class WithdrawalRuleUpdateTable extends _i1.UpdateTable<WithdrawalRuleTable> {
  WithdrawalRuleUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<double, double> currencyChangePercentage(double value) => _i1.ColumnValue(
    table.currencyChangePercentage,
    value,
  );
}

class WithdrawalRuleTable extends _i1.Table<int?> {
  WithdrawalRuleTable({super.tableRelation}) : super(tableName: 'withdrawal_rule') {
    updateTable = WithdrawalRuleUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    currencyChangePercentage = _i1.ColumnDouble(
      'currencyChangePercentage',
      this,
    );
  }

  late final WithdrawalRuleUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.AuthUserTable? _user;

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble currencyChangePercentage;

  _i3.WithdrawalFeeTable? ___fees;

  _i1.ManyRelation<_i3.WithdrawalFeeTable>? _fees;

  _i2.AuthUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: WithdrawalRule.t.userId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.WithdrawalFeeTable get __fees {
    if (___fees != null) return ___fees!;
    ___fees = _i1.createRelationTable(
      relationFieldName: '__fees',
      field: WithdrawalRule.t.id,
      foreignField: _i3.WithdrawalFee.t.ruleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i3.WithdrawalFeeTable(tableRelation: foreignTableRelation),
    );
    return ___fees!;
  }

  _i1.ManyRelation<_i3.WithdrawalFeeTable> get fees {
    if (_fees != null) return _fees!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'fees',
      field: WithdrawalRule.t.id,
      foreignField: _i3.WithdrawalFee.t.ruleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i3.WithdrawalFeeTable(tableRelation: foreignTableRelation),
    );
    _fees = _i1.ManyRelation<_i3.WithdrawalFeeTable>(
      tableWithRelations: relationTable,
      table: _i3.WithdrawalFeeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _fees!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    name,
    currencyChangePercentage,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'fees') {
      return __fees;
    }
    return null;
  }
}

class WithdrawalRuleInclude extends _i1.IncludeObject {
  WithdrawalRuleInclude._({
    _i2.AuthUserInclude? user,
    _i3.WithdrawalFeeIncludeList? fees,
  }) {
    _user = user;
    _fees = fees;
  }

  _i2.AuthUserInclude? _user;

  _i3.WithdrawalFeeIncludeList? _fees;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'fees': _fees,
  };

  @override
  _i1.Table<int?> get table => WithdrawalRule.t;
}

class WithdrawalRuleIncludeList extends _i1.IncludeList {
  WithdrawalRuleIncludeList._({
    _i1.WhereExpressionBuilder<WithdrawalRuleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WithdrawalRule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WithdrawalRule.t;
}

class WithdrawalRuleRepository {
  const WithdrawalRuleRepository._();

  final attach = const WithdrawalRuleAttachRepository._();

  final attachRow = const WithdrawalRuleAttachRowRepository._();

  /// Returns a list of [WithdrawalRule]s matching the given query parameters.
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
  Future<List<WithdrawalRule>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WithdrawalRuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WithdrawalRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WithdrawalRuleTable>? orderByList,
    _i1.Transaction? transaction,
    WithdrawalRuleInclude? include,
  }) async {
    return session.db.find<WithdrawalRule>(
      where: where?.call(WithdrawalRule.t),
      orderBy: orderBy?.call(WithdrawalRule.t),
      orderByList: orderByList?.call(WithdrawalRule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [WithdrawalRule] matching the given query parameters.
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
  Future<WithdrawalRule?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WithdrawalRuleTable>? where,
    int? offset,
    _i1.OrderByBuilder<WithdrawalRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WithdrawalRuleTable>? orderByList,
    _i1.Transaction? transaction,
    WithdrawalRuleInclude? include,
  }) async {
    return session.db.findFirstRow<WithdrawalRule>(
      where: where?.call(WithdrawalRule.t),
      orderBy: orderBy?.call(WithdrawalRule.t),
      orderByList: orderByList?.call(WithdrawalRule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [WithdrawalRule] by its [id] or null if no such row exists.
  Future<WithdrawalRule?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    WithdrawalRuleInclude? include,
  }) async {
    return session.db.findById<WithdrawalRule>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [WithdrawalRule]s in the list and returns the inserted rows.
  ///
  /// The returned [WithdrawalRule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WithdrawalRule>> insert(
    _i1.Session session,
    List<WithdrawalRule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WithdrawalRule>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WithdrawalRule] and returns the inserted row.
  ///
  /// The returned [WithdrawalRule] will have its `id` field set.
  Future<WithdrawalRule> insertRow(
    _i1.Session session,
    WithdrawalRule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WithdrawalRule>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WithdrawalRule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WithdrawalRule>> update(
    _i1.Session session,
    List<WithdrawalRule> rows, {
    _i1.ColumnSelections<WithdrawalRuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WithdrawalRule>(
      rows,
      columns: columns?.call(WithdrawalRule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WithdrawalRule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WithdrawalRule> updateRow(
    _i1.Session session,
    WithdrawalRule row, {
    _i1.ColumnSelections<WithdrawalRuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WithdrawalRule>(
      row,
      columns: columns?.call(WithdrawalRule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WithdrawalRule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WithdrawalRule?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WithdrawalRuleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WithdrawalRule>(
      id,
      columnValues: columnValues(WithdrawalRule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WithdrawalRule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WithdrawalRule>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WithdrawalRuleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WithdrawalRuleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WithdrawalRuleTable>? orderBy,
    _i1.OrderByListBuilder<WithdrawalRuleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WithdrawalRule>(
      columnValues: columnValues(WithdrawalRule.t.updateTable),
      where: where(WithdrawalRule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WithdrawalRule.t),
      orderByList: orderByList?.call(WithdrawalRule.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WithdrawalRule]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WithdrawalRule>> delete(
    _i1.Session session,
    List<WithdrawalRule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WithdrawalRule>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WithdrawalRule].
  Future<WithdrawalRule> deleteRow(
    _i1.Session session,
    WithdrawalRule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WithdrawalRule>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WithdrawalRule>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WithdrawalRuleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WithdrawalRule>(
      where: where(WithdrawalRule.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WithdrawalRuleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WithdrawalRule>(
      where: where?.call(WithdrawalRule.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class WithdrawalRuleAttachRepository {
  const WithdrawalRuleAttachRepository._();

  /// Creates a relation between this [WithdrawalRule] and the given [WithdrawalFee]s
  /// by setting each [WithdrawalFee]'s foreign key `ruleId` to refer to this [WithdrawalRule].
  Future<void> fees(
    _i1.Session session,
    WithdrawalRule withdrawalRule,
    List<_i3.WithdrawalFee> withdrawalFee, {
    _i1.Transaction? transaction,
  }) async {
    if (withdrawalFee.any((e) => e.id == null)) {
      throw ArgumentError.notNull('withdrawalFee.id');
    }
    if (withdrawalRule.id == null) {
      throw ArgumentError.notNull('withdrawalRule.id');
    }

    var $withdrawalFee = withdrawalFee.map((e) => e.copyWith(ruleId: withdrawalRule.id)).toList();
    await session.db.update<_i3.WithdrawalFee>(
      $withdrawalFee,
      columns: [_i3.WithdrawalFee.t.ruleId],
      transaction: transaction,
    );
  }
}

class WithdrawalRuleAttachRowRepository {
  const WithdrawalRuleAttachRowRepository._();

  /// Creates a relation between the given [WithdrawalRule] and [AuthUser]
  /// by setting the [WithdrawalRule]'s foreign key `userId` to refer to the [AuthUser].
  Future<void> user(
    _i1.Session session,
    WithdrawalRule withdrawalRule,
    _i2.AuthUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (withdrawalRule.id == null) {
      throw ArgumentError.notNull('withdrawalRule.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $withdrawalRule = withdrawalRule.copyWith(userId: user.id);
    await session.db.updateRow<WithdrawalRule>(
      $withdrawalRule,
      columns: [WithdrawalRule.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [WithdrawalRule] and the given [WithdrawalFee]
  /// by setting the [WithdrawalFee]'s foreign key `ruleId` to refer to this [WithdrawalRule].
  Future<void> fees(
    _i1.Session session,
    WithdrawalRule withdrawalRule,
    _i3.WithdrawalFee withdrawalFee, {
    _i1.Transaction? transaction,
  }) async {
    if (withdrawalFee.id == null) {
      throw ArgumentError.notNull('withdrawalFee.id');
    }
    if (withdrawalRule.id == null) {
      throw ArgumentError.notNull('withdrawalRule.id');
    }

    var $withdrawalFee = withdrawalFee.copyWith(ruleId: withdrawalRule.id);
    await session.db.updateRow<_i3.WithdrawalFee>(
      $withdrawalFee,
      columns: [_i3.WithdrawalFee.t.ruleId],
      transaction: transaction,
    );
  }
}
