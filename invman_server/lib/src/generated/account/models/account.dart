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
import '../../currency/models/currency.dart' as _i3;
import 'package:invman_server/src/generated/protocol.dart' as _i4;

abstract class Account implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Account._({
    this.id,
    required this.userId,
    this.user,
    this.currencyId,
    this.currency,
  });

  factory Account({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    int? currencyId,
    _i3.Currency? currency,
  }) = _AccountImpl;

  factory Account.fromJson(Map<String, dynamic> jsonSerialization) {
    return Account(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      currencyId: jsonSerialization['currencyId'] as int?,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Currency>(
              jsonSerialization['currency'],
            ),
    );
  }

  static final t = AccountTable();

  static const db = AccountRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  _i2.AuthUser? user;

  int? currencyId;

  _i3.Currency? currency;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Account]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Account copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    int? currencyId,
    _i3.Currency? currency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Account',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      if (currencyId != null) 'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Account',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      if (currencyId != null) 'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJsonForProtocol(),
    };
  }

  static AccountInclude include({
    _i2.AuthUserInclude? user,
    _i3.CurrencyInclude? currency,
  }) {
    return AccountInclude._(
      user: user,
      currency: currency,
    );
  }

  static AccountIncludeList includeList({
    _i1.WhereExpressionBuilder<AccountTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccountTable>? orderByList,
    AccountInclude? include,
  }) {
    return AccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Account.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Account.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccountImpl extends Account {
  _AccountImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    int? currencyId,
    _i3.Currency? currency,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         currencyId: currencyId,
         currency: currency,
       );

  /// Returns a shallow copy of this [Account]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Account copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    Object? currencyId = _Undefined,
    Object? currency = _Undefined,
  }) {
    return Account(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      currencyId: currencyId is int? ? currencyId : this.currencyId,
      currency: currency is _i3.Currency? ? currency : this.currency?.copyWith(),
    );
  }
}

class AccountUpdateTable extends _i1.UpdateTable<AccountTable> {
  AccountUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> currencyId(int? value) => _i1.ColumnValue(
    table.currencyId,
    value,
  );
}

class AccountTable extends _i1.Table<int?> {
  AccountTable({super.tableRelation}) : super(tableName: 'account') {
    updateTable = AccountUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    currencyId = _i1.ColumnInt(
      'currencyId',
      this,
    );
  }

  late final AccountUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.AuthUserTable? _user;

  late final _i1.ColumnInt currencyId;

  _i3.CurrencyTable? _currency;

  _i2.AuthUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Account.t.userId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.CurrencyTable get currency {
    if (_currency != null) return _currency!;
    _currency = _i1.createRelationTable(
      relationFieldName: 'currency',
      field: Account.t.currencyId,
      foreignField: _i3.Currency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i3.CurrencyTable(tableRelation: foreignTableRelation),
    );
    return _currency!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    currencyId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'currency') {
      return currency;
    }
    return null;
  }
}

class AccountInclude extends _i1.IncludeObject {
  AccountInclude._({
    _i2.AuthUserInclude? user,
    _i3.CurrencyInclude? currency,
  }) {
    _user = user;
    _currency = currency;
  }

  _i2.AuthUserInclude? _user;

  _i3.CurrencyInclude? _currency;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'currency': _currency,
  };

  @override
  _i1.Table<int?> get table => Account.t;
}

class AccountIncludeList extends _i1.IncludeList {
  AccountIncludeList._({
    _i1.WhereExpressionBuilder<AccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Account.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Account.t;
}

class AccountRepository {
  const AccountRepository._();

  final attachRow = const AccountAttachRowRepository._();

  final detachRow = const AccountDetachRowRepository._();

  /// Returns a list of [Account]s matching the given query parameters.
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
  Future<List<Account>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccountTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccountTable>? orderByList,
    _i1.Transaction? transaction,
    AccountInclude? include,
  }) async {
    return session.db.find<Account>(
      where: where?.call(Account.t),
      orderBy: orderBy?.call(Account.t),
      orderByList: orderByList?.call(Account.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Account] matching the given query parameters.
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
  Future<Account?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccountTable>? where,
    int? offset,
    _i1.OrderByBuilder<AccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccountTable>? orderByList,
    _i1.Transaction? transaction,
    AccountInclude? include,
  }) async {
    return session.db.findFirstRow<Account>(
      where: where?.call(Account.t),
      orderBy: orderBy?.call(Account.t),
      orderByList: orderByList?.call(Account.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Account] by its [id] or null if no such row exists.
  Future<Account?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AccountInclude? include,
  }) async {
    return session.db.findById<Account>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Account]s in the list and returns the inserted rows.
  ///
  /// The returned [Account]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Account>> insert(
    _i1.Session session,
    List<Account> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Account>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Account] and returns the inserted row.
  ///
  /// The returned [Account] will have its `id` field set.
  Future<Account> insertRow(
    _i1.Session session,
    Account row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Account>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Account]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Account>> update(
    _i1.Session session,
    List<Account> rows, {
    _i1.ColumnSelections<AccountTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Account>(
      rows,
      columns: columns?.call(Account.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Account]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Account> updateRow(
    _i1.Session session,
    Account row, {
    _i1.ColumnSelections<AccountTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Account>(
      row,
      columns: columns?.call(Account.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Account] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Account?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AccountUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Account>(
      id,
      columnValues: columnValues(Account.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Account]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Account>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AccountUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AccountTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccountTable>? orderBy,
    _i1.OrderByListBuilder<AccountTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Account>(
      columnValues: columnValues(Account.t.updateTable),
      where: where(Account.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Account.t),
      orderByList: orderByList?.call(Account.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Account]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Account>> delete(
    _i1.Session session,
    List<Account> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Account>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Account].
  Future<Account> deleteRow(
    _i1.Session session,
    Account row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Account>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Account>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AccountTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Account>(
      where: where(Account.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccountTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Account>(
      where: where?.call(Account.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class AccountAttachRowRepository {
  const AccountAttachRowRepository._();

  /// Creates a relation between the given [Account] and [AuthUser]
  /// by setting the [Account]'s foreign key `userId` to refer to the [AuthUser].
  Future<void> user(
    _i1.Session session,
    Account account,
    _i2.AuthUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (account.id == null) {
      throw ArgumentError.notNull('account.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $account = account.copyWith(userId: user.id);
    await session.db.updateRow<Account>(
      $account,
      columns: [Account.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Account] and [Currency]
  /// by setting the [Account]'s foreign key `currencyId` to refer to the [Currency].
  Future<void> currency(
    _i1.Session session,
    Account account,
    _i3.Currency currency, {
    _i1.Transaction? transaction,
  }) async {
    if (account.id == null) {
      throw ArgumentError.notNull('account.id');
    }
    if (currency.id == null) {
      throw ArgumentError.notNull('currency.id');
    }

    var $account = account.copyWith(currencyId: currency.id);
    await session.db.updateRow<Account>(
      $account,
      columns: [Account.t.currencyId],
      transaction: transaction,
    );
  }
}

class AccountDetachRowRepository {
  const AccountDetachRowRepository._();

  /// Detaches the relation between this [Account] and the [Currency] set in `currency`
  /// by setting the [Account]'s foreign key `currencyId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> currency(
    _i1.Session session,
    Account account, {
    _i1.Transaction? transaction,
  }) async {
    if (account.id == null) {
      throw ArgumentError.notNull('account.id');
    }

    var $account = account.copyWith(currencyId: null);
    await session.db.updateRow<Account>(
      $account,
      columns: [Account.t.currencyId],
      transaction: transaction,
    );
  }
}
