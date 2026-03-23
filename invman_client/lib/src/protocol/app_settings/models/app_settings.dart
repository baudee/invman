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

abstract class AppSettings implements _i1.SerializableModel {
  AppSettings._({
    this.id,
    required this.maintenanceMode,
    required this.minVersion,
    this.appStoreUrl,
    this.playStoreUrl,
    required this.symbolsUpdatedAt,
  });

  factory AppSettings({
    int? id,
    required bool maintenanceMode,
    required String minVersion,
    String? appStoreUrl,
    String? playStoreUrl,
    required DateTime symbolsUpdatedAt,
  }) = _AppSettingsImpl;

  factory AppSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppSettings(
      id: jsonSerialization['id'] as int?,
      maintenanceMode: jsonSerialization['maintenanceMode'] as bool,
      minVersion: jsonSerialization['minVersion'] as String,
      appStoreUrl: jsonSerialization['appStoreUrl'] as String?,
      playStoreUrl: jsonSerialization['playStoreUrl'] as String?,
      symbolsUpdatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['symbolsUpdatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  bool maintenanceMode;

  String minVersion;

  String? appStoreUrl;

  String? playStoreUrl;

  DateTime symbolsUpdatedAt;

  /// Returns a shallow copy of this [AppSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppSettings copyWith({
    int? id,
    bool? maintenanceMode,
    String? minVersion,
    String? appStoreUrl,
    String? playStoreUrl,
    DateTime? symbolsUpdatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppSettings',
      if (id != null) 'id': id,
      'maintenanceMode': maintenanceMode,
      'minVersion': minVersion,
      if (appStoreUrl != null) 'appStoreUrl': appStoreUrl,
      if (playStoreUrl != null) 'playStoreUrl': playStoreUrl,
      'symbolsUpdatedAt': symbolsUpdatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppSettingsImpl extends AppSettings {
  _AppSettingsImpl({
    int? id,
    required bool maintenanceMode,
    required String minVersion,
    String? appStoreUrl,
    String? playStoreUrl,
    required DateTime symbolsUpdatedAt,
  }) : super._(
         id: id,
         maintenanceMode: maintenanceMode,
         minVersion: minVersion,
         appStoreUrl: appStoreUrl,
         playStoreUrl: playStoreUrl,
         symbolsUpdatedAt: symbolsUpdatedAt,
       );

  /// Returns a shallow copy of this [AppSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppSettings copyWith({
    Object? id = _Undefined,
    bool? maintenanceMode,
    String? minVersion,
    Object? appStoreUrl = _Undefined,
    Object? playStoreUrl = _Undefined,
    DateTime? symbolsUpdatedAt,
  }) {
    return AppSettings(
      id: id is int? ? id : this.id,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      minVersion: minVersion ?? this.minVersion,
      appStoreUrl: appStoreUrl is String? ? appStoreUrl : this.appStoreUrl,
      playStoreUrl: playStoreUrl is String? ? playStoreUrl : this.playStoreUrl,
      symbolsUpdatedAt: symbolsUpdatedAt ?? this.symbolsUpdatedAt,
    );
  }
}
