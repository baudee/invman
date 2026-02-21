/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart' as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' as _i4;
import 'account/models/account.dart' as _i5;
import 'core/exceptions/error_code.dart' as _i6;
import 'core/exceptions/server_exception.dart' as _i7;
import 'currency/models/currency.dart' as _i8;
import 'investment/models/investment.dart' as _i9;
import 'stock/models/stock.dart' as _i10;
import 'stock/models/stock_like.dart' as _i11;
import 'stock/models/stock_type.dart' as _i12;
import 'transfer/models/transfer.dart' as _i13;
import 'withdrawal/models/withdrawal_fee.dart' as _i14;
import 'withdrawal/models/withdrawal_rule.dart' as _i15;
import 'package:invman_server/src/generated/currency/models/currency.dart' as _i16;
import 'package:invman_server/src/generated/investment/models/investment.dart' as _i17;
import 'package:invman_server/src/generated/stock/models/stock.dart' as _i18;
import 'package:invman_server/src/generated/transfer/models/transfer.dart' as _i19;
import 'package:invman_server/src/generated/withdrawal/models/withdrawal_rule.dart' as _i20;
export 'account/models/account.dart';
export 'core/exceptions/error_code.dart';
export 'core/exceptions/server_exception.dart';
export 'currency/models/currency.dart';
export 'investment/models/investment.dart';
export 'stock/models/stock.dart';
export 'stock/models/stock_like.dart';
export 'stock/models/stock_type.dart';
export 'transfer/models/transfer.dart';
export 'withdrawal/models/withdrawal_fee.dart';
export 'withdrawal/models/withdrawal_rule.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'account',
      dartName: 'Account',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'account_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'currencyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'account_fk_0',
          columns: ['userId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'account_fk_1',
          columns: ['currencyId'],
          referenceTable: 'currency',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'account_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'account_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'currency',
      dartName: 'Currency',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'currency_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'dollarValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'currency_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'currency_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'investment',
      dartName: 'Investment',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'investment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'stockId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'withdrawalRuleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'investAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'investment_fk_0',
          columns: ['userId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'investment_fk_1',
          columns: ['stockId'],
          referenceTable: 'stock',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'investment_fk_2',
          columns: ['withdrawalRuleId'],
          referenceTable: 'withdrawal_rule',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'investment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'investment_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'stock',
      dartName: 'Stock',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'symbol',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'quoteType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:StockType',
        ),
        _i2.ColumnDefinition(
          name: 'logoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'price',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'currencyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'stock_fk_0',
          columns: ['currencyId'],
          referenceTable: 'currency',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'stock_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'stock_symbol_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'symbol',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'stock_name_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'stock_like',
      dartName: 'StockLike',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'stock_like_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'stockId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'stock_like_fk_0',
          columns: ['userId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'stock_like_fk_1',
          columns: ['stockId'],
          referenceTable: 'stock',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'stock_like_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'stock_like_user_stock_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'stockId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'transfer',
      dartName: 'Transfer',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'transfer_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'investmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'transfer_fk_0',
          columns: ['investmentId'],
          referenceTable: 'investment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'transfer_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'investment_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'investmentId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'withdrawal_fee',
      dartName: 'WithdrawalFee',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'withdrawal_fee_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'fixed',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'percent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'minimum',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'ruleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'withdrawal_fee_fk_0',
          columns: ['ruleId'],
          referenceTable: 'withdrawal_rule',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'withdrawal_fee_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'withdrawal_rule',
      dartName: 'WithdrawalRule',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'withdrawal_rule_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'currencyChangePercentage',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'withdrawal_rule_fk_0',
          columns: ['userId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'withdrawal_rule_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.Account) {
      return _i5.Account.fromJson(data) as T;
    }
    if (t == _i6.ErrorCode) {
      return _i6.ErrorCode.fromJson(data) as T;
    }
    if (t == _i7.ServerException) {
      return _i7.ServerException.fromJson(data) as T;
    }
    if (t == _i8.Currency) {
      return _i8.Currency.fromJson(data) as T;
    }
    if (t == _i9.Investment) {
      return _i9.Investment.fromJson(data) as T;
    }
    if (t == _i10.Stock) {
      return _i10.Stock.fromJson(data) as T;
    }
    if (t == _i11.StockLike) {
      return _i11.StockLike.fromJson(data) as T;
    }
    if (t == _i12.StockType) {
      return _i12.StockType.fromJson(data) as T;
    }
    if (t == _i13.Transfer) {
      return _i13.Transfer.fromJson(data) as T;
    }
    if (t == _i14.WithdrawalFee) {
      return _i14.WithdrawalFee.fromJson(data) as T;
    }
    if (t == _i15.WithdrawalRule) {
      return _i15.WithdrawalRule.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.Account?>()) {
      return (data != null ? _i5.Account.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ErrorCode?>()) {
      return (data != null ? _i6.ErrorCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ServerException?>()) {
      return (data != null ? _i7.ServerException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Currency?>()) {
      return (data != null ? _i8.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Investment?>()) {
      return (data != null ? _i9.Investment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Stock?>()) {
      return (data != null ? _i10.Stock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.StockLike?>()) {
      return (data != null ? _i11.StockLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.StockType?>()) {
      return (data != null ? _i12.StockType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Transfer?>()) {
      return (data != null ? _i13.Transfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.WithdrawalFee?>()) {
      return (data != null ? _i14.WithdrawalFee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.WithdrawalRule?>()) {
      return (data != null ? _i15.WithdrawalRule.fromJson(data) : null) as T;
    }
    if (t == List<_i13.Transfer>) {
      return (data as List).map((e) => deserialize<_i13.Transfer>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i13.Transfer>?>()) {
      return (data != null ? (data as List).map((e) => deserialize<_i13.Transfer>(e)).toList() : null) as T;
    }
    if (t == List<_i11.StockLike>) {
      return (data as List).map((e) => deserialize<_i11.StockLike>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i11.StockLike>?>()) {
      return (data != null ? (data as List).map((e) => deserialize<_i11.StockLike>(e)).toList() : null) as T;
    }
    if (t == List<_i9.Investment>) {
      return (data as List).map((e) => deserialize<_i9.Investment>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i9.Investment>?>()) {
      return (data != null ? (data as List).map((e) => deserialize<_i9.Investment>(e)).toList() : null) as T;
    }
    if (t == List<_i14.WithdrawalFee>) {
      return (data as List).map((e) => deserialize<_i14.WithdrawalFee>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i14.WithdrawalFee>?>()) {
      return (data != null ? (data as List).map((e) => deserialize<_i14.WithdrawalFee>(e)).toList() : null) as T;
    }
    if (t == List<_i16.Currency>) {
      return (data as List).map((e) => deserialize<_i16.Currency>(e)).toList() as T;
    }
    if (t == List<_i17.Investment>) {
      return (data as List).map((e) => deserialize<_i17.Investment>(e)).toList() as T;
    }
    if (t == List<_i18.Stock>) {
      return (data as List).map((e) => deserialize<_i18.Stock>(e)).toList() as T;
    }
    if (t == List<_i19.Transfer>) {
      return (data as List).map((e) => deserialize<_i19.Transfer>(e)).toList() as T;
    }
    if (t == List<_i20.WithdrawalRule>) {
      return (data as List).map((e) => deserialize<_i20.WithdrawalRule>(e)).toList() as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.Account => 'Account',
      _i6.ErrorCode => 'ErrorCode',
      _i7.ServerException => 'ServerException',
      _i8.Currency => 'Currency',
      _i9.Investment => 'Investment',
      _i10.Stock => 'Stock',
      _i11.StockLike => 'StockLike',
      _i12.StockType => 'StockType',
      _i13.Transfer => 'Transfer',
      _i14.WithdrawalFee => 'WithdrawalFee',
      _i15.WithdrawalRule => 'WithdrawalRule',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('invman.', '');
    }

    switch (data) {
      case _i5.Account():
        return 'Account';
      case _i6.ErrorCode():
        return 'ErrorCode';
      case _i7.ServerException():
        return 'ServerException';
      case _i8.Currency():
        return 'Currency';
      case _i9.Investment():
        return 'Investment';
      case _i10.Stock():
        return 'Stock';
      case _i11.StockLike():
        return 'StockLike';
      case _i12.StockType():
        return 'StockType';
      case _i13.Transfer():
        return 'Transfer';
      case _i14.WithdrawalFee():
        return 'WithdrawalFee';
      case _i15.WithdrawalRule():
        return 'WithdrawalRule';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Account') {
      return deserialize<_i5.Account>(data['data']);
    }
    if (dataClassName == 'ErrorCode') {
      return deserialize<_i6.ErrorCode>(data['data']);
    }
    if (dataClassName == 'ServerException') {
      return deserialize<_i7.ServerException>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i8.Currency>(data['data']);
    }
    if (dataClassName == 'Investment') {
      return deserialize<_i9.Investment>(data['data']);
    }
    if (dataClassName == 'Stock') {
      return deserialize<_i10.Stock>(data['data']);
    }
    if (dataClassName == 'StockLike') {
      return deserialize<_i11.StockLike>(data['data']);
    }
    if (dataClassName == 'StockType') {
      return deserialize<_i12.StockType>(data['data']);
    }
    if (dataClassName == 'Transfer') {
      return deserialize<_i13.Transfer>(data['data']);
    }
    if (dataClassName == 'WithdrawalFee') {
      return deserialize<_i14.WithdrawalFee>(data['data']);
    }
    if (dataClassName == 'WithdrawalRule') {
      return deserialize<_i15.WithdrawalRule>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.Account:
        return _i5.Account.t;
      case _i8.Currency:
        return _i8.Currency.t;
      case _i9.Investment:
        return _i9.Investment.t;
      case _i10.Stock:
        return _i10.Stock.t;
      case _i11.StockLike:
        return _i11.StockLike.t;
      case _i13.Transfer:
        return _i13.Transfer.t;
      case _i14.WithdrawalFee:
        return _i14.WithdrawalFee.t;
      case _i15.WithdrawalRule:
        return _i15.WithdrawalRule.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() => targetTableDefinitions;

  @override
  String getModuleName() => 'invman';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
