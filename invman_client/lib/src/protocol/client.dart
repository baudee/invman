/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:invman_client/src/protocol/investment/models/investment_list.dart'
    as _i3;
import 'package:invman_client/src/protocol/investment/models/investment.dart'
    as _i4;
import 'package:invman_client/src/protocol/stock/models/stock.dart' as _i5;
import 'package:invman_client/src/protocol/transfer/models/transfer_list.dart'
    as _i6;
import 'package:invman_client/src/protocol/transfer/models/transfer.dart'
    as _i7;
import 'package:invman_client/src/protocol/withdrawal/models/withdrawal_fee.dart'
    as _i8;
import 'package:invman_client/src/protocol/withdrawal/models/withdrawal_rule_list.dart'
    as _i9;
import 'package:invman_client/src/protocol/withdrawal/models/withdrawal_rule.dart'
    as _i10;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i11;
import 'protocol.dart' as _i12;

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<bool> isEmailAvailable({required String email}) =>
      caller.callServerEndpoint<bool>(
        'auth',
        'isEmailAvailable',
        {'email': email},
      );
}

/// {@category Endpoint}
class EndpointInvestment extends _i1.EndpointRef {
  EndpointInvestment(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'investment';

  _i2.Future<_i3.InvestmentList> list({
    required String currency,
    required int limit,
    required int page,
  }) =>
      caller.callServerEndpoint<_i3.InvestmentList>(
        'investment',
        'list',
        {
          'currency': currency,
          'limit': limit,
          'page': page,
        },
      );

  _i2.Future<_i4.Investment> total({required String currency}) =>
      caller.callServerEndpoint<_i4.Investment>(
        'investment',
        'total',
        {'currency': currency},
      );

  _i2.Future<_i4.Investment> save(
    _i4.Investment investment, {
    required String currency,
  }) =>
      caller.callServerEndpoint<_i4.Investment>(
        'investment',
        'save',
        {
          'investment': investment,
          'currency': currency,
        },
      );

  _i2.Future<_i4.Investment> delete(int id) =>
      caller.callServerEndpoint<_i4.Investment>(
        'investment',
        'delete',
        {'id': id},
      );

  _i2.Future<_i4.Investment> retrieve(
    int id, {
    required String currency,
  }) =>
      caller.callServerEndpoint<_i4.Investment>(
        'investment',
        'retrieve',
        {
          'id': id,
          'currency': currency,
        },
      );
}

/// {@category Endpoint}
class EndpointStock extends _i1.EndpointRef {
  EndpointStock(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'stock';

  _i2.Future<_i5.Stock> retrieve(String symbol) =>
      caller.callServerEndpoint<_i5.Stock>(
        'stock',
        'retrieve',
        {'symbol': symbol},
      );

  _i2.Future<List<_i5.Stock>> search({
    required String query,
    required int limit,
  }) =>
      caller.callServerEndpoint<List<_i5.Stock>>(
        'stock',
        'search',
        {
          'query': query,
          'limit': limit,
        },
      );
}

/// {@category Endpoint}
class EndpointTransfer extends _i1.EndpointRef {
  EndpointTransfer(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'transfer';

  _i2.Future<_i6.TransferList> list({
    required int limit,
    required int page,
  }) =>
      caller.callServerEndpoint<_i6.TransferList>(
        'transfer',
        'list',
        {
          'limit': limit,
          'page': page,
        },
      );

  _i2.Future<_i7.Transfer> retrieve(int id) =>
      caller.callServerEndpoint<_i7.Transfer>(
        'transfer',
        'retrieve',
        {'id': id},
      );

  _i2.Future<_i7.Transfer> save(_i7.Transfer transfer) =>
      caller.callServerEndpoint<_i7.Transfer>(
        'transfer',
        'save',
        {'transfer': transfer},
      );

  _i2.Future<_i7.Transfer> delete(int id) =>
      caller.callServerEndpoint<_i7.Transfer>(
        'transfer',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointWithdrawalFee extends _i1.EndpointRef {
  EndpointWithdrawalFee(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'withdrawalFee';

  _i2.Future<_i8.WithdrawalFee> retrieve(int id) =>
      caller.callServerEndpoint<_i8.WithdrawalFee>(
        'withdrawalFee',
        'retrieve',
        {'id': id},
      );

  _i2.Future<_i8.WithdrawalFee> save(_i8.WithdrawalFee fee) =>
      caller.callServerEndpoint<_i8.WithdrawalFee>(
        'withdrawalFee',
        'save',
        {'fee': fee},
      );

  _i2.Future<_i8.WithdrawalFee> delete(int id) =>
      caller.callServerEndpoint<_i8.WithdrawalFee>(
        'withdrawalFee',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointWithdrawalRule extends _i1.EndpointRef {
  EndpointWithdrawalRule(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'withdrawalRule';

  _i2.Future<_i9.WithdrawalRuleList> list({
    required int limit,
    required int page,
  }) =>
      caller.callServerEndpoint<_i9.WithdrawalRuleList>(
        'withdrawalRule',
        'list',
        {
          'limit': limit,
          'page': page,
        },
      );

  _i2.Future<_i10.WithdrawalRule> retrieve(int id) =>
      caller.callServerEndpoint<_i10.WithdrawalRule>(
        'withdrawalRule',
        'retrieve',
        {'id': id},
      );

  _i2.Future<_i10.WithdrawalRule> save(_i10.WithdrawalRule transfer) =>
      caller.callServerEndpoint<_i10.WithdrawalRule>(
        'withdrawalRule',
        'save',
        {'transfer': transfer},
      );

  _i2.Future<_i10.WithdrawalRule> delete(int id) =>
      caller.callServerEndpoint<_i10.WithdrawalRule>(
        'withdrawalRule',
        'delete',
        {'id': id},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i11.Caller(client);
  }

  late final _i11.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i12.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    investment = EndpointInvestment(this);
    stock = EndpointStock(this);
    transfer = EndpointTransfer(this);
    withdrawalFee = EndpointWithdrawalFee(this);
    withdrawalRule = EndpointWithdrawalRule(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointInvestment investment;

  late final EndpointStock stock;

  late final EndpointTransfer transfer;

  late final EndpointWithdrawalFee withdrawalFee;

  late final EndpointWithdrawalRule withdrawalRule;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'investment': investment,
        'stock': stock,
        'transfer': transfer,
        'withdrawalFee': withdrawalFee,
        'withdrawalRule': withdrawalRule,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
