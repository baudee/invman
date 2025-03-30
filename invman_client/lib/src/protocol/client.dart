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
import 'package:invman_client/src/protocol/stock/models/stock_list.dart' as _i3;
import 'package:invman_client/src/protocol/stock/models/stock.dart' as _i4;
import 'package:invman_client/src/protocol/transfer/models/transfer_list.dart'
    as _i5;
import 'package:invman_client/src/protocol/transfer/models/transfer.dart'
    as _i6;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i7;
import 'protocol.dart' as _i8;

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
class EndpointStock extends _i1.EndpointRef {
  EndpointStock(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'stock';

  _i2.Future<_i3.StockList> list({
    required int limit,
    required int page,
  }) =>
      caller.callServerEndpoint<_i3.StockList>(
        'stock',
        'list',
        {
          'limit': limit,
          'page': page,
        },
      );

  _i2.Future<_i3.StockList> search({
    required String query,
    required int limit,
  }) =>
      caller.callServerEndpoint<_i3.StockList>(
        'stock',
        'search',
        {
          'query': query,
          'limit': limit,
        },
      );

  _i2.Future<_i4.Stock> save(_i4.Stock stock) =>
      caller.callServerEndpoint<_i4.Stock>(
        'stock',
        'save',
        {'stock': stock},
      );
}

/// {@category Endpoint}
class EndpointTransfer extends _i1.EndpointRef {
  EndpointTransfer(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'transfer';

  _i2.Future<_i5.TransferList> list({
    required int limit,
    required int page,
  }) =>
      caller.callServerEndpoint<_i5.TransferList>(
        'transfer',
        'list',
        {
          'limit': limit,
          'page': page,
        },
      );

  _i2.Future<_i6.Transfer> retrieve(int id) =>
      caller.callServerEndpoint<_i6.Transfer>(
        'transfer',
        'retrieve',
        {'id': id},
      );

  _i2.Future<_i6.Transfer> save(_i6.Transfer transfer) =>
      caller.callServerEndpoint<_i6.Transfer>(
        'transfer',
        'save',
        {'transfer': transfer},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i7.Caller(client);
  }

  late final _i7.Caller auth;
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
          _i8.Protocol(),
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
    stock = EndpointStock(this);
    transfer = EndpointTransfer(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointStock stock;

  late final EndpointTransfer transfer;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'stock': stock,
        'transfer': transfer,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
