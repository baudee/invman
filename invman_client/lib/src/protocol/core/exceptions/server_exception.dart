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
import '../../core/exceptions/error_code.dart' as _i2;

abstract class ServerException
    implements _i1.SerializableException, _i1.SerializableModel {
  ServerException._({
    required this.errorCode,
    this.message,
  });

  factory ServerException({
    required _i2.ErrorCode errorCode,
    String? message,
  }) = _ServerExceptionImpl;

  factory ServerException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServerException(
      errorCode:
          _i2.ErrorCode.fromJson((jsonSerialization['errorCode'] as String)),
      message: jsonSerialization['message'] as String?,
    );
  }

  _i2.ErrorCode errorCode;

  String? message;

  ServerException copyWith({
    _i2.ErrorCode? errorCode,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'errorCode': errorCode.toJson(),
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServerExceptionImpl extends ServerException {
  _ServerExceptionImpl({
    required _i2.ErrorCode errorCode,
    String? message,
  }) : super._(
          errorCode: errorCode,
          message: message,
        );

  @override
  ServerException copyWith({
    _i2.ErrorCode? errorCode,
    Object? message = _Undefined,
  }) {
    return ServerException(
      errorCode: errorCode ?? this.errorCode,
      message: message is String? ? message : this.message,
    );
  }
}
