// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoMetadata {
  Duration get duration => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  double get aspectRatio => throw _privateConstructorUsedError;
  int? get bitrate => throw _privateConstructorUsedError;
  String? get format => throw _privateConstructorUsedError;

  /// Create a copy of VideoMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoMetadataCopyWith<VideoMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoMetadataCopyWith<$Res> {
  factory $VideoMetadataCopyWith(
          VideoMetadata value, $Res Function(VideoMetadata) then) =
      _$VideoMetadataCopyWithImpl<$Res, VideoMetadata>;
  @useResult
  $Res call(
      {Duration duration,
      double width,
      double height,
      double aspectRatio,
      int? bitrate,
      String? format});
}

/// @nodoc
class _$VideoMetadataCopyWithImpl<$Res, $Val extends VideoMetadata>
    implements $VideoMetadataCopyWith<$Res> {
  _$VideoMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
    Object? width = null,
    Object? height = null,
    Object? aspectRatio = null,
    Object? bitrate = freezed,
    Object? format = freezed,
  }) {
    return _then(_value.copyWith(
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      aspectRatio: null == aspectRatio
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      bitrate: freezed == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoMetadataImplCopyWith<$Res>
    implements $VideoMetadataCopyWith<$Res> {
  factory _$$VideoMetadataImplCopyWith(
          _$VideoMetadataImpl value, $Res Function(_$VideoMetadataImpl) then) =
      __$$VideoMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration duration,
      double width,
      double height,
      double aspectRatio,
      int? bitrate,
      String? format});
}

/// @nodoc
class __$$VideoMetadataImplCopyWithImpl<$Res>
    extends _$VideoMetadataCopyWithImpl<$Res, _$VideoMetadataImpl>
    implements _$$VideoMetadataImplCopyWith<$Res> {
  __$$VideoMetadataImplCopyWithImpl(
      _$VideoMetadataImpl _value, $Res Function(_$VideoMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
    Object? width = null,
    Object? height = null,
    Object? aspectRatio = null,
    Object? bitrate = freezed,
    Object? format = freezed,
  }) {
    return _then(_$VideoMetadataImpl(
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      aspectRatio: null == aspectRatio
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      bitrate: freezed == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VideoMetadataImpl
    with DiagnosticableTreeMixin
    implements _VideoMetadata {
  const _$VideoMetadataImpl(
      {required this.duration,
      required this.width,
      required this.height,
      required this.aspectRatio,
      this.bitrate,
      this.format});

  @override
  final Duration duration;
  @override
  final double width;
  @override
  final double height;
  @override
  final double aspectRatio;
  @override
  final int? bitrate;
  @override
  final String? format;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoMetadata(duration: $duration, width: $width, height: $height, aspectRatio: $aspectRatio, bitrate: $bitrate, format: $format)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VideoMetadata'))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('width', width))
      ..add(DiagnosticsProperty('height', height))
      ..add(DiagnosticsProperty('aspectRatio', aspectRatio))
      ..add(DiagnosticsProperty('bitrate', bitrate))
      ..add(DiagnosticsProperty('format', format));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoMetadataImpl &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.aspectRatio, aspectRatio) ||
                other.aspectRatio == aspectRatio) &&
            (identical(other.bitrate, bitrate) || other.bitrate == bitrate) &&
            (identical(other.format, format) || other.format == format));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, duration, width, height, aspectRatio, bitrate, format);

  /// Create a copy of VideoMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoMetadataImplCopyWith<_$VideoMetadataImpl> get copyWith =>
      __$$VideoMetadataImplCopyWithImpl<_$VideoMetadataImpl>(this, _$identity);
}

abstract class _VideoMetadata implements VideoMetadata {
  const factory _VideoMetadata(
      {required final Duration duration,
      required final double width,
      required final double height,
      required final double aspectRatio,
      final int? bitrate,
      final String? format}) = _$VideoMetadataImpl;

  @override
  Duration get duration;
  @override
  double get width;
  @override
  double get height;
  @override
  double get aspectRatio;
  @override
  int? get bitrate;
  @override
  String? get format;

  /// Create a copy of VideoMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoMetadataImplCopyWith<_$VideoMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VideoContent {
  String get videoId => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  ContentLoadingState get loadingState => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  VideoMetadata? get metadata => throw _privateConstructorUsedError;
  Uint8List? get thumbnailData => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime? get lastAccessedAt => throw _privateConstructorUsedError;
  PreloadPriority get priority => throw _privateConstructorUsedError;

  /// Create a copy of VideoContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoContentCopyWith<VideoContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoContentCopyWith<$Res> {
  factory $VideoContentCopyWith(
          VideoContent value, $Res Function(VideoContent) then) =
      _$VideoContentCopyWithImpl<$Res, VideoContent>;
  @useResult
  $Res call(
      {String videoId,
      String url,
      ContentLoadingState loadingState,
      DateTime createdAt,
      VideoMetadata? metadata,
      Uint8List? thumbnailData,
      String? errorMessage,
      DateTime? lastAccessedAt,
      PreloadPriority priority});

  $VideoMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$VideoContentCopyWithImpl<$Res, $Val extends VideoContent>
    implements $VideoContentCopyWith<$Res> {
  _$VideoContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? url = null,
    Object? loadingState = null,
    Object? createdAt = null,
    Object? metadata = freezed,
    Object? thumbnailData = freezed,
    Object? errorMessage = freezed,
    Object? lastAccessedAt = freezed,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as ContentLoadingState,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as VideoMetadata?,
      thumbnailData: freezed == thumbnailData
          ? _value.thumbnailData
          : thumbnailData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastAccessedAt: freezed == lastAccessedAt
          ? _value.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as PreloadPriority,
    ) as $Val);
  }

  /// Create a copy of VideoContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VideoMetadataCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $VideoMetadataCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VideoContentImplCopyWith<$Res>
    implements $VideoContentCopyWith<$Res> {
  factory _$$VideoContentImplCopyWith(
          _$VideoContentImpl value, $Res Function(_$VideoContentImpl) then) =
      __$$VideoContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String videoId,
      String url,
      ContentLoadingState loadingState,
      DateTime createdAt,
      VideoMetadata? metadata,
      Uint8List? thumbnailData,
      String? errorMessage,
      DateTime? lastAccessedAt,
      PreloadPriority priority});

  @override
  $VideoMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$$VideoContentImplCopyWithImpl<$Res>
    extends _$VideoContentCopyWithImpl<$Res, _$VideoContentImpl>
    implements _$$VideoContentImplCopyWith<$Res> {
  __$$VideoContentImplCopyWithImpl(
      _$VideoContentImpl _value, $Res Function(_$VideoContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? url = null,
    Object? loadingState = null,
    Object? createdAt = null,
    Object? metadata = freezed,
    Object? thumbnailData = freezed,
    Object? errorMessage = freezed,
    Object? lastAccessedAt = freezed,
    Object? priority = null,
  }) {
    return _then(_$VideoContentImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as ContentLoadingState,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as VideoMetadata?,
      thumbnailData: freezed == thumbnailData
          ? _value.thumbnailData
          : thumbnailData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastAccessedAt: freezed == lastAccessedAt
          ? _value.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as PreloadPriority,
    ));
  }
}

/// @nodoc

class _$VideoContentImpl extends _VideoContent with DiagnosticableTreeMixin {
  const _$VideoContentImpl(
      {required this.videoId,
      required this.url,
      required this.loadingState,
      required this.createdAt,
      this.metadata,
      this.thumbnailData,
      this.errorMessage,
      this.lastAccessedAt,
      this.priority = PreloadPriority.background})
      : super._();

  @override
  final String videoId;
  @override
  final String url;
  @override
  final ContentLoadingState loadingState;
  @override
  final DateTime createdAt;
  @override
  final VideoMetadata? metadata;
  @override
  final Uint8List? thumbnailData;
  @override
  final String? errorMessage;
  @override
  final DateTime? lastAccessedAt;
  @override
  @JsonKey()
  final PreloadPriority priority;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoContent(videoId: $videoId, url: $url, loadingState: $loadingState, createdAt: $createdAt, metadata: $metadata, thumbnailData: $thumbnailData, errorMessage: $errorMessage, lastAccessedAt: $lastAccessedAt, priority: $priority)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VideoContent'))
      ..add(DiagnosticsProperty('videoId', videoId))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('loadingState', loadingState))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('metadata', metadata))
      ..add(DiagnosticsProperty('thumbnailData', thumbnailData))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('lastAccessedAt', lastAccessedAt))
      ..add(DiagnosticsProperty('priority', priority));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoContentImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailData, thumbnailData) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastAccessedAt, lastAccessedAt) ||
                other.lastAccessedAt == lastAccessedAt) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      videoId,
      url,
      loadingState,
      createdAt,
      metadata,
      const DeepCollectionEquality().hash(thumbnailData),
      errorMessage,
      lastAccessedAt,
      priority);

  /// Create a copy of VideoContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoContentImplCopyWith<_$VideoContentImpl> get copyWith =>
      __$$VideoContentImplCopyWithImpl<_$VideoContentImpl>(this, _$identity);
}

abstract class _VideoContent extends VideoContent {
  const factory _VideoContent(
      {required final String videoId,
      required final String url,
      required final ContentLoadingState loadingState,
      required final DateTime createdAt,
      final VideoMetadata? metadata,
      final Uint8List? thumbnailData,
      final String? errorMessage,
      final DateTime? lastAccessedAt,
      final PreloadPriority priority}) = _$VideoContentImpl;
  const _VideoContent._() : super._();

  @override
  String get videoId;
  @override
  String get url;
  @override
  ContentLoadingState get loadingState;
  @override
  DateTime get createdAt;
  @override
  VideoMetadata? get metadata;
  @override
  Uint8List? get thumbnailData;
  @override
  String? get errorMessage;
  @override
  DateTime? get lastAccessedAt;
  @override
  PreloadPriority get priority;

  /// Create a copy of VideoContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoContentImplCopyWith<_$VideoContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SingleVideoState {
  VideoControllerState get state => throw _privateConstructorUsedError;
  String? get currentVideoId => throw _privateConstructorUsedError;
  String? get previousVideoId => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isInBackground => throw _privateConstructorUsedError;
  DateTime? get lastStateChange => throw _privateConstructorUsedError;

  /// Create a copy of SingleVideoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SingleVideoStateCopyWith<SingleVideoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleVideoStateCopyWith<$Res> {
  factory $SingleVideoStateCopyWith(
          SingleVideoState value, $Res Function(SingleVideoState) then) =
      _$SingleVideoStateCopyWithImpl<$Res, SingleVideoState>;
  @useResult
  $Res call(
      {VideoControllerState state,
      String? currentVideoId,
      String? previousVideoId,
      String? errorMessage,
      bool isInBackground,
      DateTime? lastStateChange});
}

/// @nodoc
class _$SingleVideoStateCopyWithImpl<$Res, $Val extends SingleVideoState>
    implements $SingleVideoStateCopyWith<$Res> {
  _$SingleVideoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SingleVideoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? currentVideoId = freezed,
    Object? previousVideoId = freezed,
    Object? errorMessage = freezed,
    Object? isInBackground = null,
    Object? lastStateChange = freezed,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as VideoControllerState,
      currentVideoId: freezed == currentVideoId
          ? _value.currentVideoId
          : currentVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      previousVideoId: freezed == previousVideoId
          ? _value.previousVideoId
          : previousVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isInBackground: null == isInBackground
          ? _value.isInBackground
          : isInBackground // ignore: cast_nullable_to_non_nullable
              as bool,
      lastStateChange: freezed == lastStateChange
          ? _value.lastStateChange
          : lastStateChange // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SingleVideoStateImplCopyWith<$Res>
    implements $SingleVideoStateCopyWith<$Res> {
  factory _$$SingleVideoStateImplCopyWith(_$SingleVideoStateImpl value,
          $Res Function(_$SingleVideoStateImpl) then) =
      __$$SingleVideoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {VideoControllerState state,
      String? currentVideoId,
      String? previousVideoId,
      String? errorMessage,
      bool isInBackground,
      DateTime? lastStateChange});
}

/// @nodoc
class __$$SingleVideoStateImplCopyWithImpl<$Res>
    extends _$SingleVideoStateCopyWithImpl<$Res, _$SingleVideoStateImpl>
    implements _$$SingleVideoStateImplCopyWith<$Res> {
  __$$SingleVideoStateImplCopyWithImpl(_$SingleVideoStateImpl _value,
      $Res Function(_$SingleVideoStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SingleVideoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? currentVideoId = freezed,
    Object? previousVideoId = freezed,
    Object? errorMessage = freezed,
    Object? isInBackground = null,
    Object? lastStateChange = freezed,
  }) {
    return _then(_$SingleVideoStateImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as VideoControllerState,
      currentVideoId: freezed == currentVideoId
          ? _value.currentVideoId
          : currentVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      previousVideoId: freezed == previousVideoId
          ? _value.previousVideoId
          : previousVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isInBackground: null == isInBackground
          ? _value.isInBackground
          : isInBackground // ignore: cast_nullable_to_non_nullable
              as bool,
      lastStateChange: freezed == lastStateChange
          ? _value.lastStateChange
          : lastStateChange // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SingleVideoStateImpl extends _SingleVideoState
    with DiagnosticableTreeMixin {
  const _$SingleVideoStateImpl(
      {this.state = VideoControllerState.idle,
      this.currentVideoId,
      this.previousVideoId,
      this.errorMessage,
      this.isInBackground = false,
      this.lastStateChange})
      : super._();

  @override
  @JsonKey()
  final VideoControllerState state;
  @override
  final String? currentVideoId;
  @override
  final String? previousVideoId;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isInBackground;
  @override
  final DateTime? lastStateChange;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SingleVideoState(state: $state, currentVideoId: $currentVideoId, previousVideoId: $previousVideoId, errorMessage: $errorMessage, isInBackground: $isInBackground, lastStateChange: $lastStateChange)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SingleVideoState'))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('currentVideoId', currentVideoId))
      ..add(DiagnosticsProperty('previousVideoId', previousVideoId))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('isInBackground', isInBackground))
      ..add(DiagnosticsProperty('lastStateChange', lastStateChange));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SingleVideoStateImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.currentVideoId, currentVideoId) ||
                other.currentVideoId == currentVideoId) &&
            (identical(other.previousVideoId, previousVideoId) ||
                other.previousVideoId == previousVideoId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isInBackground, isInBackground) ||
                other.isInBackground == isInBackground) &&
            (identical(other.lastStateChange, lastStateChange) ||
                other.lastStateChange == lastStateChange));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state, currentVideoId,
      previousVideoId, errorMessage, isInBackground, lastStateChange);

  /// Create a copy of SingleVideoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleVideoStateImplCopyWith<_$SingleVideoStateImpl> get copyWith =>
      __$$SingleVideoStateImplCopyWithImpl<_$SingleVideoStateImpl>(
          this, _$identity);
}

abstract class _SingleVideoState extends SingleVideoState {
  const factory _SingleVideoState(
      {final VideoControllerState state,
      final String? currentVideoId,
      final String? previousVideoId,
      final String? errorMessage,
      final bool isInBackground,
      final DateTime? lastStateChange}) = _$SingleVideoStateImpl;
  const _SingleVideoState._() : super._();

  @override
  VideoControllerState get state;
  @override
  String? get currentVideoId;
  @override
  String? get previousVideoId;
  @override
  String? get errorMessage;
  @override
  bool get isInBackground;
  @override
  DateTime? get lastStateChange;

  /// Create a copy of SingleVideoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SingleVideoStateImplCopyWith<_$SingleVideoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VideoContentBufferState {
  Map<String, VideoContent> get content => throw _privateConstructorUsedError;
  int get totalSize => throw _privateConstructorUsedError;
  double get estimatedMemoryMB => throw _privateConstructorUsedError;
  DateTime? get lastCleanup => throw _privateConstructorUsedError;

  /// Create a copy of VideoContentBufferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoContentBufferStateCopyWith<VideoContentBufferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoContentBufferStateCopyWith<$Res> {
  factory $VideoContentBufferStateCopyWith(VideoContentBufferState value,
          $Res Function(VideoContentBufferState) then) =
      _$VideoContentBufferStateCopyWithImpl<$Res, VideoContentBufferState>;
  @useResult
  $Res call(
      {Map<String, VideoContent> content,
      int totalSize,
      double estimatedMemoryMB,
      DateTime? lastCleanup});
}

/// @nodoc
class _$VideoContentBufferStateCopyWithImpl<$Res,
        $Val extends VideoContentBufferState>
    implements $VideoContentBufferStateCopyWith<$Res> {
  _$VideoContentBufferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoContentBufferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? totalSize = null,
    Object? estimatedMemoryMB = null,
    Object? lastCleanup = freezed,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, VideoContent>,
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedMemoryMB: null == estimatedMemoryMB
          ? _value.estimatedMemoryMB
          : estimatedMemoryMB // ignore: cast_nullable_to_non_nullable
              as double,
      lastCleanup: freezed == lastCleanup
          ? _value.lastCleanup
          : lastCleanup // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoContentBufferStateImplCopyWith<$Res>
    implements $VideoContentBufferStateCopyWith<$Res> {
  factory _$$VideoContentBufferStateImplCopyWith(
          _$VideoContentBufferStateImpl value,
          $Res Function(_$VideoContentBufferStateImpl) then) =
      __$$VideoContentBufferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, VideoContent> content,
      int totalSize,
      double estimatedMemoryMB,
      DateTime? lastCleanup});
}

/// @nodoc
class __$$VideoContentBufferStateImplCopyWithImpl<$Res>
    extends _$VideoContentBufferStateCopyWithImpl<$Res,
        _$VideoContentBufferStateImpl>
    implements _$$VideoContentBufferStateImplCopyWith<$Res> {
  __$$VideoContentBufferStateImplCopyWithImpl(
      _$VideoContentBufferStateImpl _value,
      $Res Function(_$VideoContentBufferStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoContentBufferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? totalSize = null,
    Object? estimatedMemoryMB = null,
    Object? lastCleanup = freezed,
  }) {
    return _then(_$VideoContentBufferStateImpl(
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, VideoContent>,
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedMemoryMB: null == estimatedMemoryMB
          ? _value.estimatedMemoryMB
          : estimatedMemoryMB // ignore: cast_nullable_to_non_nullable
              as double,
      lastCleanup: freezed == lastCleanup
          ? _value.lastCleanup
          : lastCleanup // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$VideoContentBufferStateImpl extends _VideoContentBufferState
    with DiagnosticableTreeMixin {
  const _$VideoContentBufferStateImpl(
      {final Map<String, VideoContent> content = const {},
      this.totalSize = 0,
      this.estimatedMemoryMB = 0.0,
      this.lastCleanup})
      : _content = content,
        super._();

  final Map<String, VideoContent> _content;
  @override
  @JsonKey()
  Map<String, VideoContent> get content {
    if (_content is EqualUnmodifiableMapView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_content);
  }

  @override
  @JsonKey()
  final int totalSize;
  @override
  @JsonKey()
  final double estimatedMemoryMB;
  @override
  final DateTime? lastCleanup;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoContentBufferState(content: $content, totalSize: $totalSize, estimatedMemoryMB: $estimatedMemoryMB, lastCleanup: $lastCleanup)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VideoContentBufferState'))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('totalSize', totalSize))
      ..add(DiagnosticsProperty('estimatedMemoryMB', estimatedMemoryMB))
      ..add(DiagnosticsProperty('lastCleanup', lastCleanup));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoContentBufferStateImpl &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.totalSize, totalSize) ||
                other.totalSize == totalSize) &&
            (identical(other.estimatedMemoryMB, estimatedMemoryMB) ||
                other.estimatedMemoryMB == estimatedMemoryMB) &&
            (identical(other.lastCleanup, lastCleanup) ||
                other.lastCleanup == lastCleanup));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_content),
      totalSize,
      estimatedMemoryMB,
      lastCleanup);

  /// Create a copy of VideoContentBufferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoContentBufferStateImplCopyWith<_$VideoContentBufferStateImpl>
      get copyWith => __$$VideoContentBufferStateImplCopyWithImpl<
          _$VideoContentBufferStateImpl>(this, _$identity);
}

abstract class _VideoContentBufferState extends VideoContentBufferState {
  const factory _VideoContentBufferState(
      {final Map<String, VideoContent> content,
      final int totalSize,
      final double estimatedMemoryMB,
      final DateTime? lastCleanup}) = _$VideoContentBufferStateImpl;
  const _VideoContentBufferState._() : super._();

  @override
  Map<String, VideoContent> get content;
  @override
  int get totalSize;
  @override
  double get estimatedMemoryMB;
  @override
  DateTime? get lastCleanup;

  /// Create a copy of VideoContentBufferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoContentBufferStateImplCopyWith<_$VideoContentBufferStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
