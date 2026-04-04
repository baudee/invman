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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:invman_client/src/protocol/features/account/models/account.dart'
    as _i3;
import 'package:invman_client/src/protocol/features/app_settings/models/app_settings.dart'
    as _i4;
import 'package:invman_client/src/protocol/features/asset/models/asset.dart'
    as _i5;
import 'package:invman_client/src/protocol/features/asset/models/asset_filter.dart'
    as _i6;
import 'package:invman_client/src/protocol/features/asset/models/asset_value.dart'
    as _i7;
import 'package:invman_client/src/protocol/features/asset/models/asset_time_horizon.dart'
    as _i8;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i9;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i10;
import 'package:invman_client/src/protocol/features/currency/models/currency.dart'
    as _i11;
import 'package:invman_client/src/protocol/features/dividend/models/computed_dividend_value.dart'
    as _i12;
import 'package:invman_client/src/protocol/features/dividend/models/total_dividend_year.dart'
    as _i13;
import 'package:invman_client/src/protocol/features/investment/models/investment.dart'
    as _i14;
import 'package:invman_client/src/protocol/features/investment/models/return.dart'
    as _i15;
import 'package:invman_client/src/protocol/features/investment/models/return_interval.dart'
    as _i16;
import 'package:invman_client/src/protocol/features/transfer/models/transfer.dart'
    as _i17;
import 'package:invman_client/src/protocol/features/withdrawal/models/withdrawal_rule.dart'
    as _i18;
import 'protocol.dart' as _i19;

/// {@category Endpoint}
class EndpointAccount extends _i1.EndpointRef {
  EndpointAccount(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'account';

  _i2.Future<_i3.Account> retrieve() => caller.callServerEndpoint<_i3.Account>(
    'account',
    'retrieve',
    {},
  );

  _i2.Future<_i3.Account> save(_i3.Account account) =>
      caller.callServerEndpoint<_i3.Account>(
        'account',
        'save',
        {'account': account},
      );
}

/// {@category Endpoint}
class EndpointAppSettings extends _i1.EndpointRef {
  EndpointAppSettings(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'appSettings';

  _i2.Future<_i4.AppSettings> get() =>
      caller.callServerEndpoint<_i4.AppSettings>(
        'appSettings',
        'get',
        {},
      );
}

/// {@category Endpoint}
class EndpointAsset extends _i1.EndpointRef {
  EndpointAsset(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'asset';

  _i2.Future<void> like(_i1.UuidValue assetId) =>
      caller.callServerEndpoint<void>(
        'asset',
        'like',
        {'assetId': assetId},
      );

  _i2.Future<void> unlike(_i1.UuidValue assetId) =>
      caller.callServerEndpoint<void>(
        'asset',
        'unlike',
        {'assetId': assetId},
      );

  _i2.Future<_i5.Asset> retrieve(_i1.UuidValue uuid) =>
      caller.callServerEndpoint<_i5.Asset>(
        'asset',
        'retrieve',
        {'uuid': uuid},
      );

  _i2.Future<List<_i5.Asset>> list({
    _i6.AssetFilter? filter,
    required int limit,
    required int page,
  }) => caller.callServerEndpoint<List<_i5.Asset>>(
    'asset',
    'list',
    {
      'filter': filter,
      'limit': limit,
      'page': page,
    },
  );

  _i2.Future<List<_i7.AssetValue>> timeseries(
    _i1.UuidValue assetId, {
    required _i8.AssetTimeHorizon timeHorizon,
  }) => caller.callServerEndpoint<List<_i7.AssetValue>>(
    'asset',
    'timeseries',
    {
      'assetId': assetId,
      'timeHorizon': timeHorizon,
    },
  );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i9.EndpointEmailIdpBase {
  EndpointEmailIdp(_i1.EndpointCaller caller) : super(caller);

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
  _i2.Future<_i10.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i10.AuthSuccess>(
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
  _i2.Future<_i1.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
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
  _i2.Future<String> verifyRegistrationCode({
    required _i1.UuidValue accountRequestId,
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
  _i2.Future<_i10.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i10.AuthSuccess>(
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
  _i2.Future<_i1.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
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
  _i2.Future<String> verifyPasswordResetCode({
    required _i1.UuidValue passwordResetRequestId,
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
  _i2.Future<void> finishPasswordReset({
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

  @override
  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i10.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i1.EndpointCaller caller) : super(caller);

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
  _i2.Future<_i10.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i10.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointCurrency extends _i1.EndpointRef {
  EndpointCurrency(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'currency';

  _i2.Future<List<_i11.Currency>> list() =>
      caller.callServerEndpoint<List<_i11.Currency>>(
        'currency',
        'list',
        {},
      );
}

/// {@category Endpoint}
class EndpointDividend extends _i1.EndpointRef {
  EndpointDividend(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dividend';

  _i2.Future<List<_i12.ComputedDividendValue>> list({
    required int limit,
    required int page,
  }) => caller.callServerEndpoint<List<_i12.ComputedDividendValue>>(
    'dividend',
    'list',
    {
      'limit': limit,
      'page': page,
    },
  );

  _i2.Future<List<_i12.ComputedDividendValue>> calendar() =>
      caller.callServerEndpoint<List<_i12.ComputedDividendValue>>(
        'dividend',
        'calendar',
        {},
      );

  _i2.Future<List<_i13.TotalDividendYear>> total(
    int fromYear,
    int toYear,
  ) => caller.callServerEndpoint<List<_i13.TotalDividendYear>>(
    'dividend',
    'total',
    {
      'fromYear': fromYear,
      'toYear': toYear,
    },
  );
}

/// {@category Endpoint}
class EndpointInvestment extends _i1.EndpointRef {
  EndpointInvestment(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'investment';

  _i2.Future<List<_i14.Investment>> list({
    required int limit,
    required int page,
  }) => caller.callServerEndpoint<List<_i14.Investment>>(
    'investment',
    'list',
    {
      'limit': limit,
      'page': page,
    },
  );

  _i2.Future<_i14.Investment> save(_i14.Investment investment) =>
      caller.callServerEndpoint<_i14.Investment>(
        'investment',
        'save',
        {'investment': investment},
      );

  _i2.Future<_i14.Investment> delete(int id) =>
      caller.callServerEndpoint<_i14.Investment>(
        'investment',
        'delete',
        {'id': id},
      );

  _i2.Future<_i14.Investment> retrieve(int id) =>
      caller.callServerEndpoint<_i14.Investment>(
        'investment',
        'retrieve',
        {'id': id},
      );

  _i2.Future<_i14.Investment> total() =>
      caller.callServerEndpoint<_i14.Investment>(
        'investment',
        'total',
        {},
      );

  _i2.Future<List<_i15.InvestmentReturn>> returns(
    int id, {
    required _i16.InvestmentReturnInterval interval,
  }) => caller.callServerEndpoint<List<_i15.InvestmentReturn>>(
    'investment',
    'returns',
    {
      'id': id,
      'interval': interval,
    },
  );
}

/// {@category Endpoint}
class EndpointTransfer extends _i1.EndpointRef {
  EndpointTransfer(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'transfer';

  _i2.Future<_i17.Transfer> retrieve(int id) =>
      caller.callServerEndpoint<_i17.Transfer>(
        'transfer',
        'retrieve',
        {'id': id},
      );

  _i2.Future<_i17.Transfer> save(_i17.Transfer transfer) =>
      caller.callServerEndpoint<_i17.Transfer>(
        'transfer',
        'save',
        {'transfer': transfer},
      );

  _i2.Future<_i17.Transfer> delete(int id) =>
      caller.callServerEndpoint<_i17.Transfer>(
        'transfer',
        'delete',
        {'id': id},
      );

  _i2.Future<List<_i17.Transfer>> list(
    int investmentId, {
    required int limit,
    required int page,
  }) => caller.callServerEndpoint<List<_i17.Transfer>>(
    'transfer',
    'list',
    {
      'investmentId': investmentId,
      'limit': limit,
      'page': page,
    },
  );
}

/// {@category Endpoint}
class EndpointWithdrawalRule extends _i1.EndpointRef {
  EndpointWithdrawalRule(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'withdrawalRule';

  _i2.Future<List<_i18.WithdrawalRule>> list({
    required int limit,
    required int page,
  }) => caller.callServerEndpoint<List<_i18.WithdrawalRule>>(
    'withdrawalRule',
    'list',
    {
      'limit': limit,
      'page': page,
    },
  );

  _i2.Future<_i18.WithdrawalRule> retrieve(int id) =>
      caller.callServerEndpoint<_i18.WithdrawalRule>(
        'withdrawalRule',
        'retrieve',
        {'id': id},
      );

  _i2.Future<_i18.WithdrawalRule> save(_i18.WithdrawalRule transfer) =>
      caller.callServerEndpoint<_i18.WithdrawalRule>(
        'withdrawalRule',
        'save',
        {'transfer': transfer},
      );

  _i2.Future<_i18.WithdrawalRule> delete(int id) =>
      caller.callServerEndpoint<_i18.WithdrawalRule>(
        'withdrawalRule',
        'delete',
        {'id': id},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i9.Caller(client);
    serverpod_auth_core = _i10.Caller(client);
  }

  late final _i9.Caller serverpod_auth_idp;

  late final _i10.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
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
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i19.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    account = EndpointAccount(this);
    appSettings = EndpointAppSettings(this);
    asset = EndpointAsset(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    currency = EndpointCurrency(this);
    dividend = EndpointDividend(this);
    investment = EndpointInvestment(this);
    transfer = EndpointTransfer(this);
    withdrawalRule = EndpointWithdrawalRule(this);
    modules = Modules(this);
  }

  late final EndpointAccount account;

  late final EndpointAppSettings appSettings;

  late final EndpointAsset asset;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCurrency currency;

  late final EndpointDividend dividend;

  late final EndpointInvestment investment;

  late final EndpointTransfer transfer;

  late final EndpointWithdrawalRule withdrawalRule;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'account': account,
    'appSettings': appSettings,
    'asset': asset,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'currency': currency,
    'dividend': dividend,
    'investment': investment,
    'transfer': transfer,
    'withdrawalRule': withdrawalRule,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
