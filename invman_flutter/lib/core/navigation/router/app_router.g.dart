// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'f7fc7852beff292b6a9364cf092f8b9048079924';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [router].
@ProviderFor(router)
const routerProvider = RouterFamily();

/// See also [router].
class RouterFamily extends Family<GoRouter> {
  /// See also [router].
  const RouterFamily();

  /// See also [router].
  RouterProvider call(
    bool sellerMode,
  ) {
    return RouterProvider(
      sellerMode,
    );
  }

  @override
  RouterProvider getProviderOverride(
    covariant RouterProvider provider,
  ) {
    return call(
      provider.sellerMode,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'routerProvider';
}

/// See also [router].
class RouterProvider extends Provider<GoRouter> {
  /// See also [router].
  RouterProvider(
    bool sellerMode,
  ) : this._internal(
          (ref) => router(
            ref as RouterRef,
            sellerMode,
          ),
          from: routerProvider,
          name: r'routerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$routerHash,
          dependencies: RouterFamily._dependencies,
          allTransitiveDependencies: RouterFamily._allTransitiveDependencies,
          sellerMode: sellerMode,
        );

  RouterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sellerMode,
  }) : super.internal();

  final bool sellerMode;

  @override
  Override overrideWith(
    GoRouter Function(RouterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RouterProvider._internal(
        (ref) => create(ref as RouterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sellerMode: sellerMode,
      ),
    );
  }

  @override
  ProviderElement<GoRouter> createElement() {
    return _RouterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RouterProvider && other.sellerMode == sellerMode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sellerMode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RouterRef on ProviderRef<GoRouter> {
  /// The parameter `sellerMode` of this provider.
  bool get sellerMode;
}

class _RouterProviderElement extends ProviderElement<GoRouter> with RouterRef {
  _RouterProviderElement(super.provider);

  @override
  bool get sellerMode => (origin as RouterProvider).sellerMode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
