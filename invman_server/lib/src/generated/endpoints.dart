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
import '../account/endpoints/account_endpoint.dart' as _i2;
import '../auth/email_idp_endpoint.dart' as _i3;
import '../auth/jwt_refresh_endpoint.dart' as _i4;
import '../currency/endpoints/currency_endpoint.dart' as _i5;
import '../investment/endpoints/investment_endpoint.dart' as _i6;
import '../stock/endpoints/stock_endpoint.dart' as _i7;
import '../transfer/endpoints/transfer_endpoint.dart' as _i8;
import '../withdrawal/endpoints/withdrawal_fee_endpoint.dart' as _i9;
import '../withdrawal/endpoints/withdrawal_rule_endpoint.dart' as _i10;
import 'package:invman_server/src/generated/account/models/account.dart'
    as _i11;
import 'package:invman_server/src/generated/investment/models/investment.dart'
    as _i12;
import 'package:invman_server/src/generated/transfer/models/transfer.dart'
    as _i13;
import 'package:invman_server/src/generated/withdrawal/models/withdrawal_fee.dart'
    as _i14;
import 'package:invman_server/src/generated/withdrawal/models/withdrawal_rule.dart'
    as _i15;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i16;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i17;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'account': _i2.AccountEndpoint()
        ..initialize(
          server,
          'account',
          null,
        ),
      'emailIdp': _i3.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i4.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'currency': _i5.CurrencyEndpoint()
        ..initialize(
          server,
          'currency',
          null,
        ),
      'investment': _i6.InvestmentEndpoint()
        ..initialize(
          server,
          'investment',
          null,
        ),
      'stock': _i7.StockEndpoint()
        ..initialize(
          server,
          'stock',
          null,
        ),
      'transfer': _i8.TransferEndpoint()
        ..initialize(
          server,
          'transfer',
          null,
        ),
      'withdrawalFee': _i9.WithdrawalFeeEndpoint()
        ..initialize(
          server,
          'withdrawalFee',
          null,
        ),
      'withdrawalRule': _i10.WithdrawalRuleEndpoint()
        ..initialize(
          server,
          'withdrawalRule',
          null,
        ),
    };
    connectors['account'] = _i1.EndpointConnector(
      name: 'account',
      endpoint: endpoints['account']!,
      methodConnectors: {
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _i2.AccountEndpoint).retrieve(
                session,
              ),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'account': _i1.ParameterDescription(
              name: 'account',
              type: _i1.getType<_i11.Account>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _i2.AccountEndpoint).save(
                session,
                params['account'],
              ),
        ),
      },
    );
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i4.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['currency'] = _i1.EndpointConnector(
      name: 'currency',
      endpoint: endpoints['currency']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['currency'] as _i5.CurrencyEndpoint).list(session),
        ),
      },
    );
    connectors['investment'] = _i1.EndpointConnector(
      name: 'investment',
      endpoint: endpoints['investment']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['investment'] as _i6.InvestmentEndpoint)
                  .list(session),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'investment': _i1.ParameterDescription(
              name: 'investment',
              type: _i1.getType<_i12.Investment>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['investment'] as _i6.InvestmentEndpoint).save(
                    session,
                    params['investment'],
                  ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['investment'] as _i6.InvestmentEndpoint).delete(
                    session,
                    params['id'],
                  ),
        ),
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['investment'] as _i6.InvestmentEndpoint).retrieve(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['stock'] = _i1.EndpointConnector(
      name: 'stock',
      endpoint: endpoints['stock']!,
      methodConnectors: {
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'uuid': _i1.ParameterDescription(
              name: 'uuid',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stock'] as _i7.StockEndpoint).retrieve(
                session,
                params['uuid'],
              ),
        ),
        'search': _i1.MethodConnector(
          name: 'search',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['stock'] as _i7.StockEndpoint).search(
                session,
                query: params['query'],
                limit: params['limit'],
                page: params['page'],
              ),
        ),
      },
    );
    connectors['transfer'] = _i1.EndpointConnector(
      name: 'transfer',
      endpoint: endpoints['transfer']!,
      methodConnectors: {
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['transfer'] as _i8.TransferEndpoint).retrieve(
                    session,
                    params['id'],
                  ),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'transfer': _i1.ParameterDescription(
              name: 'transfer',
              type: _i1.getType<_i13.Transfer>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transfer'] as _i8.TransferEndpoint).save(
                session,
                params['transfer'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transfer'] as _i8.TransferEndpoint).delete(
                session,
                params['id'],
              ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'investmentId': _i1.ParameterDescription(
              name: 'investmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transfer'] as _i8.TransferEndpoint).list(
                session,
                params['investmentId'],
                limit: params['limit'],
                page: params['page'],
              ),
        ),
      },
    );
    connectors['withdrawalFee'] = _i1.EndpointConnector(
      name: 'withdrawalFee',
      endpoint: endpoints['withdrawalFee']!,
      methodConnectors: {
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['withdrawalFee'] as _i9.WithdrawalFeeEndpoint)
                      .retrieve(
                        session,
                        params['id'],
                      ),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'fee': _i1.ParameterDescription(
              name: 'fee',
              type: _i1.getType<_i14.WithdrawalFee>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['withdrawalFee'] as _i9.WithdrawalFeeEndpoint)
                      .save(
                        session,
                        params['fee'],
                      ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['withdrawalFee'] as _i9.WithdrawalFeeEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
      },
    );
    connectors['withdrawalRule'] = _i1.EndpointConnector(
      name: 'withdrawalRule',
      endpoint: endpoints['withdrawalRule']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['withdrawalRule'] as _i10.WithdrawalRuleEndpoint)
                      .list(
                        session,
                        limit: params['limit'],
                        page: params['page'],
                      ),
        ),
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['withdrawalRule'] as _i10.WithdrawalRuleEndpoint)
                      .retrieve(
                        session,
                        params['id'],
                      ),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'transfer': _i1.ParameterDescription(
              name: 'transfer',
              type: _i1.getType<_i15.WithdrawalRule>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['withdrawalRule'] as _i10.WithdrawalRuleEndpoint)
                      .save(
                        session,
                        params['transfer'],
                      ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['withdrawalRule'] as _i10.WithdrawalRuleEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i16.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i17.Endpoints()
      ..initializeEndpoints(server);
  }
}
