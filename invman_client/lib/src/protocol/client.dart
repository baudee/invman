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
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:invman_client/src/protocol/investment/models/investment_list.dart'
    as _i5;
import 'package:invman_client/src/protocol/investment/models/investment.dart'
    as _i6;
import 'package:invman_client/src/protocol/stock/models/stock.dart' as _i7;
import 'package:invman_client/src/protocol/transfer/models/transfer.dart'
    as _i8;
import 'package:invman_client/src/protocol/withdrawal/models/withdrawal_fee.dart'
    as _i9;
import 'package:invman_client/src/protocol/withdrawal/models/withdrawal_rule_list.dart'
    as _i10;
import 'package:invman_client/src/protocol/withdrawal/models/withdrawal_rule.dart'
    as _i11;
import 'protocol.dart' as _i12;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointInvestment extends _i2.EndpointRef {
  EndpointInvestment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'investment';

  _i3.Future<_i5.InvestmentList> list({
    required String currency,
    required int limit,
    required int page,
  }) => caller.callServerEndpoint<_i5.InvestmentList>(
    'investment',
    'list',
    {
      'currency': currency,
      'limit': limit,
      'page': page,
    },
  );

  _i3.Future<_i6.Investment> total({required String currency}) =>
      caller.callServerEndpoint<_i6.Investment>(
        'investment',
        'total',
        {'currency': currency},
      );

  _i3.Future<_i6.Investment> save(
    _i6.Investment investment, {
    required String currency,
  }) => caller.callServerEndpoint<_i6.Investment>(
    'investment',
    'save',
    {
      'investment': investment,
      'currency': currency,
    },
  );

  _i3.Future<_i6.Investment> delete(int id) =>
      caller.callServerEndpoint<_i6.Investment>(
        'investment',
        'delete',
        {'id': id},
      );

  _i3.Future<_i6.Investment> retrieve(
    int id, {
    required String currency,
  }) => caller.callServerEndpoint<_i6.Investment>(
    'investment',
    'retrieve',
    {
      'id': id,
      'currency': currency,
    },
  );
}

/// {@category Endpoint}
class EndpointStock extends _i2.EndpointRef {
  EndpointStock(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'stock';

  _i3.Future<_i7.Stock> retrieve(String symbol) =>
      caller.callServerEndpoint<_i7.Stock>(
        'stock',
        'retrieve',
        {'symbol': symbol},
      );

  _i3.Future<List<_i7.Stock>> search({
    required String query,
    required int limit,
  }) => caller.callServerEndpoint<List<_i7.Stock>>(
    'stock',
    'search',
    {
      'query': query,
      'limit': limit,
    },
  );
}

/// {@category Endpoint}
class EndpointTransfer extends _i2.EndpointRef {
  EndpointTransfer(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'transfer';

  _i3.Future<_i8.Transfer> retrieve(int id) =>
      caller.callServerEndpoint<_i8.Transfer>(
        'transfer',
        'retrieve',
        {'id': id},
      );

  _i3.Future<_i8.Transfer> save(_i8.Transfer transfer) =>
      caller.callServerEndpoint<_i8.Transfer>(
        'transfer',
        'save',
        {'transfer': transfer},
      );

  _i3.Future<_i8.Transfer> delete(int id) =>
      caller.callServerEndpoint<_i8.Transfer>(
        'transfer',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointWithdrawalFee extends _i2.EndpointRef {
  EndpointWithdrawalFee(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'withdrawalFee';

  _i3.Future<_i9.WithdrawalFee> retrieve(int id) =>
      caller.callServerEndpoint<_i9.WithdrawalFee>(
        'withdrawalFee',
        'retrieve',
        {'id': id},
      );

  _i3.Future<_i9.WithdrawalFee> save(_i9.WithdrawalFee fee) =>
      caller.callServerEndpoint<_i9.WithdrawalFee>(
        'withdrawalFee',
        'save',
        {'fee': fee},
      );

  _i3.Future<_i9.WithdrawalFee> delete(int id) =>
      caller.callServerEndpoint<_i9.WithdrawalFee>(
        'withdrawalFee',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointWithdrawalRule extends _i2.EndpointRef {
  EndpointWithdrawalRule(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'withdrawalRule';

  _i3.Future<_i10.WithdrawalRuleList> list({
    required int limit,
    required int page,
  }) => caller.callServerEndpoint<_i10.WithdrawalRuleList>(
    'withdrawalRule',
    'list',
    {
      'limit': limit,
      'page': page,
    },
  );

  _i3.Future<_i11.WithdrawalRule> retrieve(int id) =>
      caller.callServerEndpoint<_i11.WithdrawalRule>(
        'withdrawalRule',
        'retrieve',
        {'id': id},
      );

  _i3.Future<_i11.WithdrawalRule> save(_i11.WithdrawalRule transfer) =>
      caller.callServerEndpoint<_i11.WithdrawalRule>(
        'withdrawalRule',
        'save',
        {'transfer': transfer},
      );

  _i3.Future<_i11.WithdrawalRule> delete(int id) =>
      caller.callServerEndpoint<_i11.WithdrawalRule>(
        'withdrawalRule',
        'delete',
        {'id': id},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i12.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    investment = EndpointInvestment(this);
    stock = EndpointStock(this);
    transfer = EndpointTransfer(this);
    withdrawalFee = EndpointWithdrawalFee(this);
    withdrawalRule = EndpointWithdrawalRule(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointInvestment investment;

  late final EndpointStock stock;

  late final EndpointTransfer transfer;

  late final EndpointWithdrawalFee withdrawalFee;

  late final EndpointWithdrawalRule withdrawalRule;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'investment': investment,
    'stock': stock,
    'transfer': transfer,
    'withdrawalFee': withdrawalFee,
    'withdrawalRule': withdrawalRule,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
