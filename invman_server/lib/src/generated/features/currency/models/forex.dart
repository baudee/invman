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

abstract class Forex implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Forex._({
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.timestamp,
  });

  factory Forex({
    required String fromCurrency,
    required String toCurrency,
    required double rate,
    required DateTime timestamp,
  }) = _ForexImpl;

  factory Forex.fromJson(Map<String, dynamic> jsonSerialization) {
    return Forex(
      fromCurrency: jsonSerialization['fromCurrency'] as String,
      toCurrency: jsonSerialization['toCurrency'] as String,
      rate: (jsonSerialization['rate'] as num).toDouble(),
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  String fromCurrency;

  String toCurrency;

  double rate;

  DateTime timestamp;

  /// Returns a shallow copy of this [Forex]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Forex copyWith({
    String? fromCurrency,
    String? toCurrency,
    double? rate,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Forex',
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'rate': rate,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Forex',
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'rate': rate,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ForexImpl extends Forex {
  _ForexImpl({
    required String fromCurrency,
    required String toCurrency,
    required double rate,
    required DateTime timestamp,
  }) : super._(
         fromCurrency: fromCurrency,
         toCurrency: toCurrency,
         rate: rate,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [Forex]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Forex copyWith({
    String? fromCurrency,
    String? toCurrency,
    double? rate,
    DateTime? timestamp,
  }) {
    return Forex(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      rate: rate ?? this.rate,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
