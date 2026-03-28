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
import '../../../features/asset/models/asset.dart' as _i3;
import '../../../features/withdrawal/models/withdrawal_rule.dart' as _i4;
import '../../../features/transfer/models/transfer.dart' as _i5;
import '../../../features/currency/models/forex.dart' as _i6;
import 'package:invman_server/src/generated/protocol.dart' as _i7;

abstract class Investment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Investment._({
    this.id,
    required this.userId,
    this.user,
    required this.name,
    required this.assetId,
    this.asset,
    this.withdrawalRuleId,
    this.withdrawalRule,
    this.transfers,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    this.withdrawAmount,
    this.forex,
  }) : investAmount = investAmount ?? 0.0,
       quantity = quantity ?? 0.0,
       updatedAt = updatedAt ?? DateTime.now();

  factory Investment({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required String name,
    required _i1.UuidValue assetId,
    _i3.Asset? asset,
    int? withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    List<_i5.Transfer>? transfers,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    double? withdrawAmount,
    _i6.Forex? forex,
  }) = _InvestmentImpl;

  factory Investment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Investment(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i7.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      name: jsonSerialization['name'] as String,
      assetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['assetId'],
      ),
      asset: jsonSerialization['asset'] == null
          ? null
          : _i7.Protocol().deserialize<_i3.Asset>(jsonSerialization['asset']),
      withdrawalRuleId: jsonSerialization['withdrawalRuleId'] as int?,
      withdrawalRule: jsonSerialization['withdrawalRule'] == null
          ? null
          : _i7.Protocol().deserialize<_i4.WithdrawalRule>(
              jsonSerialization['withdrawalRule'],
            ),
      transfers: jsonSerialization['transfers'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i5.Transfer>>(
              jsonSerialization['transfers'],
            ),
      investAmount: (jsonSerialization['investAmount'] as num?)?.toDouble(),
      quantity: (jsonSerialization['quantity'] as num?)?.toDouble(),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      withdrawAmount: (jsonSerialization['withdrawAmount'] as num?)?.toDouble(),
      forex: jsonSerialization['forex'] == null
          ? null
          : _i7.Protocol().deserialize<_i6.Forex>(jsonSerialization['forex']),
    );
  }

  static final t = InvestmentTable();

  static const db = InvestmentRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  _i2.AuthUser? user;

  String name;

  _i1.UuidValue assetId;

  _i3.Asset? asset;

  int? withdrawalRuleId;

  _i4.WithdrawalRule? withdrawalRule;

  List<_i5.Transfer>? transfers;

  double investAmount;

  double quantity;

  DateTime updatedAt;

  double? withdrawAmount;

  _i6.Forex? forex;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Investment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Investment copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    String? name,
    _i1.UuidValue? assetId,
    _i3.Asset? asset,
    int? withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    List<_i5.Transfer>? transfers,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    double? withdrawAmount,
    _i6.Forex? forex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Investment',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'name': name,
      'assetId': assetId.toJson(),
      if (asset != null) 'asset': asset?.toJson(),
      if (withdrawalRuleId != null) 'withdrawalRuleId': withdrawalRuleId,
      if (withdrawalRule != null) 'withdrawalRule': withdrawalRule?.toJson(),
      if (transfers != null)
        'transfers': transfers?.toJson(valueToJson: (v) => v.toJson()),
      'investAmount': investAmount,
      'quantity': quantity,
      'updatedAt': updatedAt.toJson(),
      if (withdrawAmount != null) 'withdrawAmount': withdrawAmount,
      if (forex != null) 'forex': forex?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Investment',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'name': name,
      'assetId': assetId.toJson(),
      if (asset != null) 'asset': asset?.toJsonForProtocol(),
      if (withdrawalRuleId != null) 'withdrawalRuleId': withdrawalRuleId,
      if (withdrawalRule != null)
        'withdrawalRule': withdrawalRule?.toJsonForProtocol(),
      if (transfers != null)
        'transfers': transfers?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'investAmount': investAmount,
      'quantity': quantity,
      'updatedAt': updatedAt.toJson(),
      if (withdrawAmount != null) 'withdrawAmount': withdrawAmount,
      if (forex != null) 'forex': forex?.toJsonForProtocol(),
    };
  }

  static InvestmentInclude include({
    _i2.AuthUserInclude? user,
    _i3.AssetInclude? asset,
    _i4.WithdrawalRuleInclude? withdrawalRule,
    _i5.TransferIncludeList? transfers,
  }) {
    return InvestmentInclude._(
      user: user,
      asset: asset,
      withdrawalRule: withdrawalRule,
      transfers: transfers,
    );
  }

  static InvestmentIncludeList includeList({
    _i1.WhereExpressionBuilder<InvestmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InvestmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InvestmentTable>? orderByList,
    InvestmentInclude? include,
  }) {
    return InvestmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Investment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Investment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvestmentImpl extends Investment {
  _InvestmentImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required String name,
    required _i1.UuidValue assetId,
    _i3.Asset? asset,
    int? withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    List<_i5.Transfer>? transfers,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    double? withdrawAmount,
    _i6.Forex? forex,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         name: name,
         assetId: assetId,
         asset: asset,
         withdrawalRuleId: withdrawalRuleId,
         withdrawalRule: withdrawalRule,
         transfers: transfers,
         investAmount: investAmount,
         quantity: quantity,
         updatedAt: updatedAt,
         withdrawAmount: withdrawAmount,
         forex: forex,
       );

  /// Returns a shallow copy of this [Investment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Investment copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? name,
    _i1.UuidValue? assetId,
    Object? asset = _Undefined,
    Object? withdrawalRuleId = _Undefined,
    Object? withdrawalRule = _Undefined,
    Object? transfers = _Undefined,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    Object? withdrawAmount = _Undefined,
    Object? forex = _Undefined,
  }) {
    return Investment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      name: name ?? this.name,
      assetId: assetId ?? this.assetId,
      asset: asset is _i3.Asset? ? asset : this.asset?.copyWith(),
      withdrawalRuleId: withdrawalRuleId is int?
          ? withdrawalRuleId
          : this.withdrawalRuleId,
      withdrawalRule: withdrawalRule is _i4.WithdrawalRule?
          ? withdrawalRule
          : this.withdrawalRule?.copyWith(),
      transfers: transfers is List<_i5.Transfer>?
          ? transfers
          : this.transfers?.map((e0) => e0.copyWith()).toList(),
      investAmount: investAmount ?? this.investAmount,
      quantity: quantity ?? this.quantity,
      updatedAt: updatedAt ?? this.updatedAt,
      withdrawAmount: withdrawAmount is double?
          ? withdrawAmount
          : this.withdrawAmount,
      forex: forex is _i6.Forex? ? forex : this.forex?.copyWith(),
    );
  }
}

class InvestmentUpdateTable extends _i1.UpdateTable<InvestmentTable> {
  InvestmentUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> assetId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.assetId,
        value,
      );

  _i1.ColumnValue<int, int> withdrawalRuleId(int? value) => _i1.ColumnValue(
    table.withdrawalRuleId,
    value,
  );

  _i1.ColumnValue<double, double> investAmount(double value) => _i1.ColumnValue(
    table.investAmount,
    value,
  );

  _i1.ColumnValue<double, double> quantity(double value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class InvestmentTable extends _i1.Table<int?> {
  InvestmentTable({super.tableRelation}) : super(tableName: 'investment') {
    updateTable = InvestmentUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    assetId = _i1.ColumnUuid(
      'assetId',
      this,
    );
    withdrawalRuleId = _i1.ColumnInt(
      'withdrawalRuleId',
      this,
    );
    investAmount = _i1.ColumnDouble(
      'investAmount',
      this,
      hasDefault: true,
    );
    quantity = _i1.ColumnDouble(
      'quantity',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final InvestmentUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.AuthUserTable? _user;

  late final _i1.ColumnString name;

  late final _i1.ColumnUuid assetId;

  _i3.AssetTable? _asset;

  late final _i1.ColumnInt withdrawalRuleId;

  _i4.WithdrawalRuleTable? _withdrawalRule;

  _i5.TransferTable? ___transfers;

  _i1.ManyRelation<_i5.TransferTable>? _transfers;

  late final _i1.ColumnDouble investAmount;

  late final _i1.ColumnDouble quantity;

  late final _i1.ColumnDateTime updatedAt;

  _i2.AuthUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Investment.t.userId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.AssetTable get asset {
    if (_asset != null) return _asset!;
    _asset = _i1.createRelationTable(
      relationFieldName: 'asset',
      field: Investment.t.assetId,
      foreignField: _i3.Asset.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AssetTable(tableRelation: foreignTableRelation),
    );
    return _asset!;
  }

  _i4.WithdrawalRuleTable get withdrawalRule {
    if (_withdrawalRule != null) return _withdrawalRule!;
    _withdrawalRule = _i1.createRelationTable(
      relationFieldName: 'withdrawalRule',
      field: Investment.t.withdrawalRuleId,
      foreignField: _i4.WithdrawalRule.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.WithdrawalRuleTable(tableRelation: foreignTableRelation),
    );
    return _withdrawalRule!;
  }

  _i5.TransferTable get __transfers {
    if (___transfers != null) return ___transfers!;
    ___transfers = _i1.createRelationTable(
      relationFieldName: '__transfers',
      field: Investment.t.id,
      foreignField: _i5.Transfer.t.investmentId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.TransferTable(tableRelation: foreignTableRelation),
    );
    return ___transfers!;
  }

  _i1.ManyRelation<_i5.TransferTable> get transfers {
    if (_transfers != null) return _transfers!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'transfers',
      field: Investment.t.id,
      foreignField: _i5.Transfer.t.investmentId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.TransferTable(tableRelation: foreignTableRelation),
    );
    _transfers = _i1.ManyRelation<_i5.TransferTable>(
      tableWithRelations: relationTable,
      table: _i5.TransferTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _transfers!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    name,
    assetId,
    withdrawalRuleId,
    investAmount,
    quantity,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'asset') {
      return asset;
    }
    if (relationField == 'withdrawalRule') {
      return withdrawalRule;
    }
    if (relationField == 'transfers') {
      return __transfers;
    }
    return null;
  }
}

class InvestmentInclude extends _i1.IncludeObject {
  InvestmentInclude._({
    _i2.AuthUserInclude? user,
    _i3.AssetInclude? asset,
    _i4.WithdrawalRuleInclude? withdrawalRule,
    _i5.TransferIncludeList? transfers,
  }) {
    _user = user;
    _asset = asset;
    _withdrawalRule = withdrawalRule;
    _transfers = transfers;
  }

  _i2.AuthUserInclude? _user;

  _i3.AssetInclude? _asset;

  _i4.WithdrawalRuleInclude? _withdrawalRule;

  _i5.TransferIncludeList? _transfers;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'asset': _asset,
    'withdrawalRule': _withdrawalRule,
    'transfers': _transfers,
  };

  @override
  _i1.Table<int?> get table => Investment.t;
}

class InvestmentIncludeList extends _i1.IncludeList {
  InvestmentIncludeList._({
    _i1.WhereExpressionBuilder<InvestmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Investment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Investment.t;
}

class InvestmentRepository {
  const InvestmentRepository._();

  final attach = const InvestmentAttachRepository._();

  final attachRow = const InvestmentAttachRowRepository._();

  final detach = const InvestmentDetachRepository._();

  final detachRow = const InvestmentDetachRowRepository._();

  /// Returns a list of [Investment]s matching the given query parameters.
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
  Future<List<Investment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InvestmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InvestmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InvestmentTable>? orderByList,
    _i1.Transaction? transaction,
    InvestmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Investment>(
      where: where?.call(Investment.t),
      orderBy: orderBy?.call(Investment.t),
      orderByList: orderByList?.call(Investment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Investment] matching the given query parameters.
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
  Future<Investment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InvestmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<InvestmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InvestmentTable>? orderByList,
    _i1.Transaction? transaction,
    InvestmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Investment>(
      where: where?.call(Investment.t),
      orderBy: orderBy?.call(Investment.t),
      orderByList: orderByList?.call(Investment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Investment] by its [id] or null if no such row exists.
  Future<Investment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    InvestmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Investment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Investment]s in the list and returns the inserted rows.
  ///
  /// The returned [Investment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Investment>> insert(
    _i1.DatabaseSession session,
    List<Investment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Investment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Investment] and returns the inserted row.
  ///
  /// The returned [Investment] will have its `id` field set.
  Future<Investment> insertRow(
    _i1.DatabaseSession session,
    Investment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Investment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Investment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Investment>> update(
    _i1.DatabaseSession session,
    List<Investment> rows, {
    _i1.ColumnSelections<InvestmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Investment>(
      rows,
      columns: columns?.call(Investment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Investment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Investment> updateRow(
    _i1.DatabaseSession session,
    Investment row, {
    _i1.ColumnSelections<InvestmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Investment>(
      row,
      columns: columns?.call(Investment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Investment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Investment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<InvestmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Investment>(
      id,
      columnValues: columnValues(Investment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Investment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Investment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<InvestmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<InvestmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InvestmentTable>? orderBy,
    _i1.OrderByListBuilder<InvestmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Investment>(
      columnValues: columnValues(Investment.t.updateTable),
      where: where(Investment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Investment.t),
      orderByList: orderByList?.call(Investment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Investment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Investment>> delete(
    _i1.DatabaseSession session,
    List<Investment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Investment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Investment].
  Future<Investment> deleteRow(
    _i1.DatabaseSession session,
    Investment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Investment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Investment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InvestmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Investment>(
      where: where(Investment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InvestmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Investment>(
      where: where?.call(Investment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Investment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InvestmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Investment>(
      where: where(Investment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class InvestmentAttachRepository {
  const InvestmentAttachRepository._();

  /// Creates a relation between this [Investment] and the given [Transfer]s
  /// by setting each [Transfer]'s foreign key `investmentId` to refer to this [Investment].
  Future<void> transfers(
    _i1.DatabaseSession session,
    Investment investment,
    List<_i5.Transfer> transfer, {
    _i1.Transaction? transaction,
  }) async {
    if (transfer.any((e) => e.id == null)) {
      throw ArgumentError.notNull('transfer.id');
    }
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }

    var $transfer = transfer
        .map((e) => e.copyWith(investmentId: investment.id))
        .toList();
    await session.db.update<_i5.Transfer>(
      $transfer,
      columns: [_i5.Transfer.t.investmentId],
      transaction: transaction,
    );
  }
}

class InvestmentAttachRowRepository {
  const InvestmentAttachRowRepository._();

  /// Creates a relation between the given [Investment] and [AuthUser]
  /// by setting the [Investment]'s foreign key `userId` to refer to the [AuthUser].
  Future<void> user(
    _i1.DatabaseSession session,
    Investment investment,
    _i2.AuthUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $investment = investment.copyWith(userId: user.id);
    await session.db.updateRow<Investment>(
      $investment,
      columns: [Investment.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Investment] and [Asset]
  /// by setting the [Investment]'s foreign key `assetId` to refer to the [Asset].
  Future<void> asset(
    _i1.DatabaseSession session,
    Investment investment,
    _i3.Asset asset, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }

    var $investment = investment.copyWith(assetId: asset.id);
    await session.db.updateRow<Investment>(
      $investment,
      columns: [Investment.t.assetId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Investment] and [WithdrawalRule]
  /// by setting the [Investment]'s foreign key `withdrawalRuleId` to refer to the [WithdrawalRule].
  Future<void> withdrawalRule(
    _i1.DatabaseSession session,
    Investment investment,
    _i4.WithdrawalRule withdrawalRule, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }
    if (withdrawalRule.id == null) {
      throw ArgumentError.notNull('withdrawalRule.id');
    }

    var $investment = investment.copyWith(withdrawalRuleId: withdrawalRule.id);
    await session.db.updateRow<Investment>(
      $investment,
      columns: [Investment.t.withdrawalRuleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Investment] and the given [Transfer]
  /// by setting the [Transfer]'s foreign key `investmentId` to refer to this [Investment].
  Future<void> transfers(
    _i1.DatabaseSession session,
    Investment investment,
    _i5.Transfer transfer, {
    _i1.Transaction? transaction,
  }) async {
    if (transfer.id == null) {
      throw ArgumentError.notNull('transfer.id');
    }
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }

    var $transfer = transfer.copyWith(investmentId: investment.id);
    await session.db.updateRow<_i5.Transfer>(
      $transfer,
      columns: [_i5.Transfer.t.investmentId],
      transaction: transaction,
    );
  }
}

class InvestmentDetachRepository {
  const InvestmentDetachRepository._();

  /// Detaches the relation between this [Investment] and the given [Transfer]
  /// by setting the [Transfer]'s foreign key `investmentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> transfers(
    _i1.DatabaseSession session,
    List<_i5.Transfer> transfer, {
    _i1.Transaction? transaction,
  }) async {
    if (transfer.any((e) => e.id == null)) {
      throw ArgumentError.notNull('transfer.id');
    }

    var $transfer = transfer
        .map((e) => e.copyWith(investmentId: null))
        .toList();
    await session.db.update<_i5.Transfer>(
      $transfer,
      columns: [_i5.Transfer.t.investmentId],
      transaction: transaction,
    );
  }
}

class InvestmentDetachRowRepository {
  const InvestmentDetachRowRepository._();

  /// Detaches the relation between this [Investment] and the [WithdrawalRule] set in `withdrawalRule`
  /// by setting the [Investment]'s foreign key `withdrawalRuleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> withdrawalRule(
    _i1.DatabaseSession session,
    Investment investment, {
    _i1.Transaction? transaction,
  }) async {
    if (investment.id == null) {
      throw ArgumentError.notNull('investment.id');
    }

    var $investment = investment.copyWith(withdrawalRuleId: null);
    await session.db.updateRow<Investment>(
      $investment,
      columns: [Investment.t.withdrawalRuleId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Investment] and the given [Transfer]
  /// by setting the [Transfer]'s foreign key `investmentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> transfers(
    _i1.DatabaseSession session,
    _i5.Transfer transfer, {
    _i1.Transaction? transaction,
  }) async {
    if (transfer.id == null) {
      throw ArgumentError.notNull('transfer.id');
    }

    var $transfer = transfer.copyWith(investmentId: null);
    await session.db.updateRow<_i5.Transfer>(
      $transfer,
      columns: [_i5.Transfer.t.investmentId],
      transaction: transaction,
    );
  }
}
