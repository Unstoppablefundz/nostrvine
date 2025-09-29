// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_video_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$individualVideoControllerHash() =>
    r'3e62352d72952f81cdee3832dd025f96ecb5ce0c';

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

/// Provider for individual video controllers with autoDispose
/// Each video gets its own controller instance
///
/// Copied from [individualVideoController].
@ProviderFor(individualVideoController)
const individualVideoControllerProvider = IndividualVideoControllerFamily();

/// Provider for individual video controllers with autoDispose
/// Each video gets its own controller instance
///
/// Copied from [individualVideoController].
class IndividualVideoControllerFamily extends Family<VideoPlayerController> {
  /// Provider for individual video controllers with autoDispose
  /// Each video gets its own controller instance
  ///
  /// Copied from [individualVideoController].
  const IndividualVideoControllerFamily();

  /// Provider for individual video controllers with autoDispose
  /// Each video gets its own controller instance
  ///
  /// Copied from [individualVideoController].
  IndividualVideoControllerProvider call(
    VideoControllerParams params,
  ) {
    return IndividualVideoControllerProvider(
      params,
    );
  }

  @override
  IndividualVideoControllerProvider getProviderOverride(
    covariant IndividualVideoControllerProvider provider,
  ) {
    return call(
      provider.params,
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
  String? get name => r'individualVideoControllerProvider';
}

/// Provider for individual video controllers with autoDispose
/// Each video gets its own controller instance
///
/// Copied from [individualVideoController].
class IndividualVideoControllerProvider
    extends AutoDisposeProvider<VideoPlayerController> {
  /// Provider for individual video controllers with autoDispose
  /// Each video gets its own controller instance
  ///
  /// Copied from [individualVideoController].
  IndividualVideoControllerProvider(
    VideoControllerParams params,
  ) : this._internal(
          (ref) => individualVideoController(
            ref as IndividualVideoControllerRef,
            params,
          ),
          from: individualVideoControllerProvider,
          name: r'individualVideoControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$individualVideoControllerHash,
          dependencies: IndividualVideoControllerFamily._dependencies,
          allTransitiveDependencies:
              IndividualVideoControllerFamily._allTransitiveDependencies,
          params: params,
        );

  IndividualVideoControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final VideoControllerParams params;

  @override
  Override overrideWith(
    VideoPlayerController Function(IndividualVideoControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IndividualVideoControllerProvider._internal(
        (ref) => create(ref as IndividualVideoControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<VideoPlayerController> createElement() {
    return _IndividualVideoControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IndividualVideoControllerProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IndividualVideoControllerRef
    on AutoDisposeProviderRef<VideoPlayerController> {
  /// The parameter `params` of this provider.
  VideoControllerParams get params;
}

class _IndividualVideoControllerProviderElement
    extends AutoDisposeProviderElement<VideoPlayerController>
    with IndividualVideoControllerRef {
  _IndividualVideoControllerProviderElement(super.provider);

  @override
  VideoControllerParams get params =>
      (origin as IndividualVideoControllerProvider).params;
}

String _$videoLoadingStateHash() => r'22f741beecbea8885fcd115ef3047a2fa2eb5e0d';

/// Provider for video loading state
///
/// Copied from [videoLoadingState].
@ProviderFor(videoLoadingState)
const videoLoadingStateProvider = VideoLoadingStateFamily();

/// Provider for video loading state
///
/// Copied from [videoLoadingState].
class VideoLoadingStateFamily extends Family<VideoLoadingState> {
  /// Provider for video loading state
  ///
  /// Copied from [videoLoadingState].
  const VideoLoadingStateFamily();

  /// Provider for video loading state
  ///
  /// Copied from [videoLoadingState].
  VideoLoadingStateProvider call(
    VideoControllerParams params,
  ) {
    return VideoLoadingStateProvider(
      params,
    );
  }

  @override
  VideoLoadingStateProvider getProviderOverride(
    covariant VideoLoadingStateProvider provider,
  ) {
    return call(
      provider.params,
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
  String? get name => r'videoLoadingStateProvider';
}

/// Provider for video loading state
///
/// Copied from [videoLoadingState].
class VideoLoadingStateProvider extends AutoDisposeProvider<VideoLoadingState> {
  /// Provider for video loading state
  ///
  /// Copied from [videoLoadingState].
  VideoLoadingStateProvider(
    VideoControllerParams params,
  ) : this._internal(
          (ref) => videoLoadingState(
            ref as VideoLoadingStateRef,
            params,
          ),
          from: videoLoadingStateProvider,
          name: r'videoLoadingStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoLoadingStateHash,
          dependencies: VideoLoadingStateFamily._dependencies,
          allTransitiveDependencies:
              VideoLoadingStateFamily._allTransitiveDependencies,
          params: params,
        );

  VideoLoadingStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final VideoControllerParams params;

  @override
  Override overrideWith(
    VideoLoadingState Function(VideoLoadingStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VideoLoadingStateProvider._internal(
        (ref) => create(ref as VideoLoadingStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<VideoLoadingState> createElement() {
    return _VideoLoadingStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VideoLoadingStateProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VideoLoadingStateRef on AutoDisposeProviderRef<VideoLoadingState> {
  /// The parameter `params` of this provider.
  VideoControllerParams get params;
}

class _VideoLoadingStateProviderElement
    extends AutoDisposeProviderElement<VideoLoadingState>
    with VideoLoadingStateRef {
  _VideoLoadingStateProviderElement(super.provider);

  @override
  VideoControllerParams get params =>
      (origin as VideoLoadingStateProvider).params;
}

String _$isVideoActiveHash() => r'763c3d07e5cede5d38a174bfedecafa35aedafac';

/// Provider for checking if a specific video is currently active
///
/// Copied from [isVideoActive].
@ProviderFor(isVideoActive)
const isVideoActiveProvider = IsVideoActiveFamily();

/// Provider for checking if a specific video is currently active
///
/// Copied from [isVideoActive].
class IsVideoActiveFamily extends Family<bool> {
  /// Provider for checking if a specific video is currently active
  ///
  /// Copied from [isVideoActive].
  const IsVideoActiveFamily();

  /// Provider for checking if a specific video is currently active
  ///
  /// Copied from [isVideoActive].
  IsVideoActiveProvider call(
    String videoId,
  ) {
    return IsVideoActiveProvider(
      videoId,
    );
  }

  @override
  IsVideoActiveProvider getProviderOverride(
    covariant IsVideoActiveProvider provider,
  ) {
    return call(
      provider.videoId,
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
  String? get name => r'isVideoActiveProvider';
}

/// Provider for checking if a specific video is currently active
///
/// Copied from [isVideoActive].
class IsVideoActiveProvider extends AutoDisposeProvider<bool> {
  /// Provider for checking if a specific video is currently active
  ///
  /// Copied from [isVideoActive].
  IsVideoActiveProvider(
    String videoId,
  ) : this._internal(
          (ref) => isVideoActive(
            ref as IsVideoActiveRef,
            videoId,
          ),
          from: isVideoActiveProvider,
          name: r'isVideoActiveProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isVideoActiveHash,
          dependencies: IsVideoActiveFamily._dependencies,
          allTransitiveDependencies:
              IsVideoActiveFamily._allTransitiveDependencies,
          videoId: videoId,
        );

  IsVideoActiveProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.videoId,
  }) : super.internal();

  final String videoId;

  @override
  Override overrideWith(
    bool Function(IsVideoActiveRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsVideoActiveProvider._internal(
        (ref) => create(ref as IsVideoActiveRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        videoId: videoId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsVideoActiveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsVideoActiveProvider && other.videoId == videoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsVideoActiveRef on AutoDisposeProviderRef<bool> {
  /// The parameter `videoId` of this provider.
  String get videoId;
}

class _IsVideoActiveProviderElement extends AutoDisposeProviderElement<bool>
    with IsVideoActiveRef {
  _IsVideoActiveProviderElement(super.provider);

  @override
  String get videoId => (origin as IsVideoActiveProvider).videoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
