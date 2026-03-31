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
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'core/exceptions/error_code.dart' as _i5;
import 'core/exceptions/server_exception.dart' as _i6;
import 'features/account/models/account.dart' as _i7;
import 'features/app_settings/models/app_settings.dart' as _i8;
import 'features/asset/models/asset.dart' as _i9;
import 'features/asset/models/asset_filter.dart' as _i10;
import 'features/asset/models/asset_like.dart' as _i11;
import 'features/asset/models/asset_time_horizon.dart' as _i12;
import 'features/asset/models/asset_type.dart' as _i13;
import 'features/asset/models/asset_value.dart' as _i14;
import 'features/asset/sources/models/td_time_series.dart' as _i15;
import 'features/asset/sources/models/td_time_series_value.dart' as _i16;
import 'features/currency/models/currency.dart' as _i17;
import 'features/currency/models/forex.dart' as _i18;
import 'features/dividend/models/computed_dividend_value.dart' as _i19;
import 'features/dividend/models/dividend_list.dart' as _i20;
import 'features/dividend/models/dividend_value.dart' as _i21;
import 'features/dividend/models/investment_dividend.dart' as _i22;
import 'features/dividend/models/total_dividend_year.dart' as _i23;
import 'features/dividend/sources/models/td_dividend_value.dart' as _i24;
import 'features/dividend/sources/models/td_dividends.dart' as _i25;
import 'features/investment/models/investment.dart' as _i26;
import 'features/investment/models/return.dart' as _i27;
import 'features/investment/models/return_interval.dart' as _i28;
import 'features/transfer/models/transfer.dart' as _i29;
import 'features/withdrawal/models/withdrawal_fee.dart' as _i30;
import 'features/withdrawal/models/withdrawal_rule.dart' as _i31;
import 'package:invman_server/src/generated/features/asset/models/asset.dart'
    as _i32;
import 'package:invman_server/src/generated/features/asset/models/asset_value.dart'
    as _i33;
import 'package:invman_server/src/generated/features/currency/models/currency.dart'
    as _i34;
import 'package:invman_server/src/generated/features/dividend/models/investment_dividend.dart'
    as _i35;
import 'package:invman_server/src/generated/features/dividend/models/total_dividend_year.dart'
    as _i36;
import 'package:invman_server/src/generated/features/investment/models/investment.dart'
    as _i37;
import 'package:invman_server/src/generated/features/investment/models/return.dart'
    as _i38;
import 'package:invman_server/src/generated/features/transfer/models/transfer.dart'
    as _i39;
import 'package:invman_server/src/generated/features/withdrawal/models/withdrawal_rule.dart'
    as _i40;
export 'core/exceptions/error_code.dart';
export 'core/exceptions/server_exception.dart';
export 'features/account/models/account.dart';
export 'features/app_settings/models/app_settings.dart';
export 'features/asset/models/asset.dart';
export 'features/asset/models/asset_filter.dart';
export 'features/asset/models/asset_like.dart';
export 'features/asset/models/asset_time_horizon.dart';
export 'features/asset/models/asset_type.dart';
export 'features/asset/models/asset_value.dart';
export 'features/asset/sources/models/td_time_series.dart';
export 'features/asset/sources/models/td_time_series_value.dart';
export 'features/currency/models/currency.dart';
export 'features/currency/models/forex.dart';
export 'features/dividend/models/computed_dividend_value.dart';
export 'features/dividend/models/dividend_list.dart';
export 'features/dividend/models/dividend_value.dart';
export 'features/dividend/models/investment_dividend.dart';
export 'features/dividend/models/total_dividend_year.dart';
export 'features/dividend/sources/models/td_dividend_value.dart';
export 'features/dividend/sources/models/td_dividends.dart';
export 'features/investment/models/investment.dart';
export 'features/investment/models/return.dart';
export 'features/investment/models/return_interval.dart';
export 'features/transfer/models/transfer.dart';
export 'features/withdrawal/models/withdrawal_fee.dart';
export 'features/withdrawal/models/withdrawal_rule.dart';

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
      name: 'app_settings',
      dartName: 'AppSettings',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'maintenanceMode',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'minVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'appStoreUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'playStoreUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_settings_pkey',
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
      name: 'asset',
      dartName: 'Asset',
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
          name: 'exchange',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AssetType',
        ),
        _i2.ColumnDefinition(
          name: 'logoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          constraintName: 'asset_fk_0',
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
          indexName: 'asset_pkey',
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
          indexName: 'asset_symbol_exchange_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'symbol',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'exchange',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'asset_name_idx',
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
      name: 'asset_like',
      dartName: 'AssetLike',
      schema: 'public',
      module: 'invman',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'asset_like_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'assetId',
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
          constraintName: 'asset_like_fk_0',
          columns: ['userId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'asset_like_fk_1',
          columns: ['assetId'],
          referenceTable: 'asset',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'asset_like_pkey',
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
          indexName: 'asset_like_user_asset_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'assetId',
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
          name: 'assetId',
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
          columns: ['assetId'],
          referenceTable: 'asset',
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

    if (t == _i5.ErrorCode) {
      return _i5.ErrorCode.fromJson(data) as T;
    }
    if (t == _i6.ServerException) {
      return _i6.ServerException.fromJson(data) as T;
    }
    if (t == _i7.Account) {
      return _i7.Account.fromJson(data) as T;
    }
    if (t == _i8.AppSettings) {
      return _i8.AppSettings.fromJson(data) as T;
    }
    if (t == _i9.Asset) {
      return _i9.Asset.fromJson(data) as T;
    }
    if (t == _i10.AssetFilter) {
      return _i10.AssetFilter.fromJson(data) as T;
    }
    if (t == _i11.AssetLike) {
      return _i11.AssetLike.fromJson(data) as T;
    }
    if (t == _i12.AssetTimeHorizon) {
      return _i12.AssetTimeHorizon.fromJson(data) as T;
    }
    if (t == _i13.AssetType) {
      return _i13.AssetType.fromJson(data) as T;
    }
    if (t == _i14.AssetValue) {
      return _i14.AssetValue.fromJson(data) as T;
    }
    if (t == _i15.TwelveDataTimeSeries) {
      return _i15.TwelveDataTimeSeries.fromJson(data) as T;
    }
    if (t == _i16.TwelveDataTimeSeriesValue) {
      return _i16.TwelveDataTimeSeriesValue.fromJson(data) as T;
    }
    if (t == _i17.Currency) {
      return _i17.Currency.fromJson(data) as T;
    }
    if (t == _i18.Forex) {
      return _i18.Forex.fromJson(data) as T;
    }
    if (t == _i19.ComputedDividendValue) {
      return _i19.ComputedDividendValue.fromJson(data) as T;
    }
    if (t == _i20.DividendList) {
      return _i20.DividendList.fromJson(data) as T;
    }
    if (t == _i21.DividendValue) {
      return _i21.DividendValue.fromJson(data) as T;
    }
    if (t == _i22.InvestmentDividend) {
      return _i22.InvestmentDividend.fromJson(data) as T;
    }
    if (t == _i23.TotalDividendYear) {
      return _i23.TotalDividendYear.fromJson(data) as T;
    }
    if (t == _i24.TwelveDataDividendValue) {
      return _i24.TwelveDataDividendValue.fromJson(data) as T;
    }
    if (t == _i25.TwelveDataDividends) {
      return _i25.TwelveDataDividends.fromJson(data) as T;
    }
    if (t == _i26.Investment) {
      return _i26.Investment.fromJson(data) as T;
    }
    if (t == _i27.InvestmentReturn) {
      return _i27.InvestmentReturn.fromJson(data) as T;
    }
    if (t == _i28.InvestmentReturnInterval) {
      return _i28.InvestmentReturnInterval.fromJson(data) as T;
    }
    if (t == _i29.Transfer) {
      return _i29.Transfer.fromJson(data) as T;
    }
    if (t == _i30.WithdrawalFee) {
      return _i30.WithdrawalFee.fromJson(data) as T;
    }
    if (t == _i31.WithdrawalRule) {
      return _i31.WithdrawalRule.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.ErrorCode?>()) {
      return (data != null ? _i5.ErrorCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ServerException?>()) {
      return (data != null ? _i6.ServerException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Account?>()) {
      return (data != null ? _i7.Account.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AppSettings?>()) {
      return (data != null ? _i8.AppSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Asset?>()) {
      return (data != null ? _i9.Asset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AssetFilter?>()) {
      return (data != null ? _i10.AssetFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.AssetLike?>()) {
      return (data != null ? _i11.AssetLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AssetTimeHorizon?>()) {
      return (data != null ? _i12.AssetTimeHorizon.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AssetType?>()) {
      return (data != null ? _i13.AssetType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.AssetValue?>()) {
      return (data != null ? _i14.AssetValue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.TwelveDataTimeSeries?>()) {
      return (data != null ? _i15.TwelveDataTimeSeries.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.TwelveDataTimeSeriesValue?>()) {
      return (data != null
              ? _i16.TwelveDataTimeSeriesValue.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i17.Currency?>()) {
      return (data != null ? _i17.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Forex?>()) {
      return (data != null ? _i18.Forex.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ComputedDividendValue?>()) {
      return (data != null ? _i19.ComputedDividendValue.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.DividendList?>()) {
      return (data != null ? _i20.DividendList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.DividendValue?>()) {
      return (data != null ? _i21.DividendValue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.InvestmentDividend?>()) {
      return (data != null ? _i22.InvestmentDividend.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.TotalDividendYear?>()) {
      return (data != null ? _i23.TotalDividendYear.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.TwelveDataDividendValue?>()) {
      return (data != null ? _i24.TwelveDataDividendValue.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.TwelveDataDividends?>()) {
      return (data != null ? _i25.TwelveDataDividends.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.Investment?>()) {
      return (data != null ? _i26.Investment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.InvestmentReturn?>()) {
      return (data != null ? _i27.InvestmentReturn.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.InvestmentReturnInterval?>()) {
      return (data != null
              ? _i28.InvestmentReturnInterval.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i29.Transfer?>()) {
      return (data != null ? _i29.Transfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.WithdrawalFee?>()) {
      return (data != null ? _i30.WithdrawalFee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.WithdrawalRule?>()) {
      return (data != null ? _i31.WithdrawalRule.fromJson(data) : null) as T;
    }
    if (t == List<_i11.AssetLike>) {
      return (data as List).map((e) => deserialize<_i11.AssetLike>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i11.AssetLike>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i11.AssetLike>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i26.Investment>) {
      return (data as List).map((e) => deserialize<_i26.Investment>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i26.Investment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i26.Investment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == Map<String, String?>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String?>(v)),
          )
          as T;
    }
    if (t == List<_i16.TwelveDataTimeSeriesValue>) {
      return (data as List)
              .map((e) => deserialize<_i16.TwelveDataTimeSeriesValue>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.DividendValue>) {
      return (data as List)
              .map((e) => deserialize<_i21.DividendValue>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.ComputedDividendValue>) {
      return (data as List)
              .map((e) => deserialize<_i19.ComputedDividendValue>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.TwelveDataDividendValue>) {
      return (data as List)
              .map((e) => deserialize<_i24.TwelveDataDividendValue>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.Transfer>) {
      return (data as List).map((e) => deserialize<_i29.Transfer>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i29.Transfer>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i29.Transfer>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i30.WithdrawalFee>) {
      return (data as List)
              .map((e) => deserialize<_i30.WithdrawalFee>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i30.WithdrawalFee>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i30.WithdrawalFee>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i32.Asset>) {
      return (data as List).map((e) => deserialize<_i32.Asset>(e)).toList()
          as T;
    }
    if (t == List<_i33.AssetValue>) {
      return (data as List).map((e) => deserialize<_i33.AssetValue>(e)).toList()
          as T;
    }
    if (t == List<_i34.Currency>) {
      return (data as List).map((e) => deserialize<_i34.Currency>(e)).toList()
          as T;
    }
    if (t == List<_i35.InvestmentDividend>) {
      return (data as List)
              .map((e) => deserialize<_i35.InvestmentDividend>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.TotalDividendYear>) {
      return (data as List)
              .map((e) => deserialize<_i36.TotalDividendYear>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.Investment>) {
      return (data as List).map((e) => deserialize<_i37.Investment>(e)).toList()
          as T;
    }
    if (t == List<_i38.InvestmentReturn>) {
      return (data as List)
              .map((e) => deserialize<_i38.InvestmentReturn>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.Transfer>) {
      return (data as List).map((e) => deserialize<_i39.Transfer>(e)).toList()
          as T;
    }
    if (t == List<_i40.WithdrawalRule>) {
      return (data as List)
              .map((e) => deserialize<_i40.WithdrawalRule>(e))
              .toList()
          as T;
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
      _i5.ErrorCode => 'ErrorCode',
      _i6.ServerException => 'ServerException',
      _i7.Account => 'Account',
      _i8.AppSettings => 'AppSettings',
      _i9.Asset => 'Asset',
      _i10.AssetFilter => 'AssetFilter',
      _i11.AssetLike => 'AssetLike',
      _i12.AssetTimeHorizon => 'AssetTimeHorizon',
      _i13.AssetType => 'AssetType',
      _i14.AssetValue => 'AssetValue',
      _i15.TwelveDataTimeSeries => 'TwelveDataTimeSeries',
      _i16.TwelveDataTimeSeriesValue => 'TwelveDataTimeSeriesValue',
      _i17.Currency => 'Currency',
      _i18.Forex => 'Forex',
      _i19.ComputedDividendValue => 'ComputedDividendValue',
      _i20.DividendList => 'DividendList',
      _i21.DividendValue => 'DividendValue',
      _i22.InvestmentDividend => 'InvestmentDividend',
      _i23.TotalDividendYear => 'TotalDividendYear',
      _i24.TwelveDataDividendValue => 'TwelveDataDividendValue',
      _i25.TwelveDataDividends => 'TwelveDataDividends',
      _i26.Investment => 'Investment',
      _i27.InvestmentReturn => 'InvestmentReturn',
      _i28.InvestmentReturnInterval => 'InvestmentReturnInterval',
      _i29.Transfer => 'Transfer',
      _i30.WithdrawalFee => 'WithdrawalFee',
      _i31.WithdrawalRule => 'WithdrawalRule',
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
      case _i5.ErrorCode():
        return 'ErrorCode';
      case _i6.ServerException():
        return 'ServerException';
      case _i7.Account():
        return 'Account';
      case _i8.AppSettings():
        return 'AppSettings';
      case _i9.Asset():
        return 'Asset';
      case _i10.AssetFilter():
        return 'AssetFilter';
      case _i11.AssetLike():
        return 'AssetLike';
      case _i12.AssetTimeHorizon():
        return 'AssetTimeHorizon';
      case _i13.AssetType():
        return 'AssetType';
      case _i14.AssetValue():
        return 'AssetValue';
      case _i15.TwelveDataTimeSeries():
        return 'TwelveDataTimeSeries';
      case _i16.TwelveDataTimeSeriesValue():
        return 'TwelveDataTimeSeriesValue';
      case _i17.Currency():
        return 'Currency';
      case _i18.Forex():
        return 'Forex';
      case _i19.ComputedDividendValue():
        return 'ComputedDividendValue';
      case _i20.DividendList():
        return 'DividendList';
      case _i21.DividendValue():
        return 'DividendValue';
      case _i22.InvestmentDividend():
        return 'InvestmentDividend';
      case _i23.TotalDividendYear():
        return 'TotalDividendYear';
      case _i24.TwelveDataDividendValue():
        return 'TwelveDataDividendValue';
      case _i25.TwelveDataDividends():
        return 'TwelveDataDividends';
      case _i26.Investment():
        return 'Investment';
      case _i27.InvestmentReturn():
        return 'InvestmentReturn';
      case _i28.InvestmentReturnInterval():
        return 'InvestmentReturnInterval';
      case _i29.Transfer():
        return 'Transfer';
      case _i30.WithdrawalFee():
        return 'WithdrawalFee';
      case _i31.WithdrawalRule():
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
    if (dataClassName == 'ErrorCode') {
      return deserialize<_i5.ErrorCode>(data['data']);
    }
    if (dataClassName == 'ServerException') {
      return deserialize<_i6.ServerException>(data['data']);
    }
    if (dataClassName == 'Account') {
      return deserialize<_i7.Account>(data['data']);
    }
    if (dataClassName == 'AppSettings') {
      return deserialize<_i8.AppSettings>(data['data']);
    }
    if (dataClassName == 'Asset') {
      return deserialize<_i9.Asset>(data['data']);
    }
    if (dataClassName == 'AssetFilter') {
      return deserialize<_i10.AssetFilter>(data['data']);
    }
    if (dataClassName == 'AssetLike') {
      return deserialize<_i11.AssetLike>(data['data']);
    }
    if (dataClassName == 'AssetTimeHorizon') {
      return deserialize<_i12.AssetTimeHorizon>(data['data']);
    }
    if (dataClassName == 'AssetType') {
      return deserialize<_i13.AssetType>(data['data']);
    }
    if (dataClassName == 'AssetValue') {
      return deserialize<_i14.AssetValue>(data['data']);
    }
    if (dataClassName == 'TwelveDataTimeSeries') {
      return deserialize<_i15.TwelveDataTimeSeries>(data['data']);
    }
    if (dataClassName == 'TwelveDataTimeSeriesValue') {
      return deserialize<_i16.TwelveDataTimeSeriesValue>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i17.Currency>(data['data']);
    }
    if (dataClassName == 'Forex') {
      return deserialize<_i18.Forex>(data['data']);
    }
    if (dataClassName == 'ComputedDividendValue') {
      return deserialize<_i19.ComputedDividendValue>(data['data']);
    }
    if (dataClassName == 'DividendList') {
      return deserialize<_i20.DividendList>(data['data']);
    }
    if (dataClassName == 'DividendValue') {
      return deserialize<_i21.DividendValue>(data['data']);
    }
    if (dataClassName == 'InvestmentDividend') {
      return deserialize<_i22.InvestmentDividend>(data['data']);
    }
    if (dataClassName == 'TotalDividendYear') {
      return deserialize<_i23.TotalDividendYear>(data['data']);
    }
    if (dataClassName == 'TwelveDataDividendValue') {
      return deserialize<_i24.TwelveDataDividendValue>(data['data']);
    }
    if (dataClassName == 'TwelveDataDividends') {
      return deserialize<_i25.TwelveDataDividends>(data['data']);
    }
    if (dataClassName == 'Investment') {
      return deserialize<_i26.Investment>(data['data']);
    }
    if (dataClassName == 'InvestmentReturn') {
      return deserialize<_i27.InvestmentReturn>(data['data']);
    }
    if (dataClassName == 'InvestmentReturnInterval') {
      return deserialize<_i28.InvestmentReturnInterval>(data['data']);
    }
    if (dataClassName == 'Transfer') {
      return deserialize<_i29.Transfer>(data['data']);
    }
    if (dataClassName == 'WithdrawalFee') {
      return deserialize<_i30.WithdrawalFee>(data['data']);
    }
    if (dataClassName == 'WithdrawalRule') {
      return deserialize<_i31.WithdrawalRule>(data['data']);
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
      case _i7.Account:
        return _i7.Account.t;
      case _i8.AppSettings:
        return _i8.AppSettings.t;
      case _i9.Asset:
        return _i9.Asset.t;
      case _i11.AssetLike:
        return _i11.AssetLike.t;
      case _i17.Currency:
        return _i17.Currency.t;
      case _i26.Investment:
        return _i26.Investment.t;
      case _i29.Transfer:
        return _i29.Transfer.t;
      case _i30.WithdrawalFee:
        return _i30.WithdrawalFee.t;
      case _i31.WithdrawalRule:
        return _i31.WithdrawalRule.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
