// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SyncedDevice _$SyncedDeviceFromJson(Map<String, dynamic> json) {
  return _SyncedDevice.fromJson(json);
}

/// @nodoc
mixin _$SyncedDevice {
  String get deviceId => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncedDeviceCopyWith<SyncedDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncedDeviceCopyWith<$Res> {
  factory $SyncedDeviceCopyWith(
          SyncedDevice value, $Res Function(SyncedDevice) then) =
      _$SyncedDeviceCopyWithImpl<$Res, SyncedDevice>;
  @useResult
  $Res call({String deviceId, bool isSynced});
}

/// @nodoc
class _$SyncedDeviceCopyWithImpl<$Res, $Val extends SyncedDevice>
    implements $SyncedDeviceCopyWith<$Res> {
  _$SyncedDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? isSynced = null,
  }) {
    return _then(_value.copyWith(
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SyncedDeviceCopyWith<$Res>
    implements $SyncedDeviceCopyWith<$Res> {
  factory _$$_SyncedDeviceCopyWith(
          _$_SyncedDevice value, $Res Function(_$_SyncedDevice) then) =
      __$$_SyncedDeviceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String deviceId, bool isSynced});
}

/// @nodoc
class __$$_SyncedDeviceCopyWithImpl<$Res>
    extends _$SyncedDeviceCopyWithImpl<$Res, _$_SyncedDevice>
    implements _$$_SyncedDeviceCopyWith<$Res> {
  __$$_SyncedDeviceCopyWithImpl(
      _$_SyncedDevice _value, $Res Function(_$_SyncedDevice) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? isSynced = null,
  }) {
    return _then(_$_SyncedDevice(
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SyncedDevice implements _SyncedDevice {
  const _$_SyncedDevice({required this.deviceId, required this.isSynced});

  factory _$_SyncedDevice.fromJson(Map<String, dynamic> json) =>
      _$$_SyncedDeviceFromJson(json);

  @override
  final String deviceId;
  @override
  final bool isSynced;

  @override
  String toString() {
    return 'SyncedDevice(deviceId: $deviceId, isSynced: $isSynced)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SyncedDevice &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, deviceId, isSynced);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SyncedDeviceCopyWith<_$_SyncedDevice> get copyWith =>
      __$$_SyncedDeviceCopyWithImpl<_$_SyncedDevice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SyncedDeviceToJson(
      this,
    );
  }
}

abstract class _SyncedDevice implements SyncedDevice {
  const factory _SyncedDevice(
      {required final String deviceId,
      required final bool isSynced}) = _$_SyncedDevice;

  factory _SyncedDevice.fromJson(Map<String, dynamic> json) =
      _$_SyncedDevice.fromJson;

  @override
  String get deviceId;
  @override
  bool get isSynced;
  @override
  @JsonKey(ignore: true)
  _$$_SyncedDeviceCopyWith<_$_SyncedDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Note {
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String? get globalId => throw _privateConstructorUsedError;
  List<SyncedDevice> get syncedDevices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res, Note>;
  @useResult
  $Res call(
      {String title,
      String message,
      String createdAt,
      String updatedAt,
      int id,
      String? globalId,
      List<SyncedDevice> syncedDevices});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res, $Val extends Note>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? globalId = freezed,
    Object? syncedDevices = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      globalId: freezed == globalId
          ? _value.globalId
          : globalId // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedDevices: null == syncedDevices
          ? _value.syncedDevices
          : syncedDevices // ignore: cast_nullable_to_non_nullable
              as List<SyncedDevice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$$_NoteCopyWith(_$_Note value, $Res Function(_$_Note) then) =
      __$$_NoteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String message,
      String createdAt,
      String updatedAt,
      int id,
      String? globalId,
      List<SyncedDevice> syncedDevices});
}

/// @nodoc
class __$$_NoteCopyWithImpl<$Res> extends _$NoteCopyWithImpl<$Res, _$_Note>
    implements _$$_NoteCopyWith<$Res> {
  __$$_NoteCopyWithImpl(_$_Note _value, $Res Function(_$_Note) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? globalId = freezed,
    Object? syncedDevices = null,
  }) {
    return _then(_$_Note(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      globalId: freezed == globalId
          ? _value.globalId
          : globalId // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedDevices: null == syncedDevices
          ? _value._syncedDevices
          : syncedDevices // ignore: cast_nullable_to_non_nullable
              as List<SyncedDevice>,
    ));
  }
}

/// @nodoc

class _$_Note implements _Note {
  const _$_Note(
      {required this.title,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      required this.id,
      this.globalId,
      required final List<SyncedDevice> syncedDevices})
      : _syncedDevices = syncedDevices;

  @override
  final String title;
  @override
  final String message;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final int id;
  @override
  final String? globalId;
  final List<SyncedDevice> _syncedDevices;
  @override
  List<SyncedDevice> get syncedDevices {
    if (_syncedDevices is EqualUnmodifiableListView) return _syncedDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_syncedDevices);
  }

  @override
  String toString() {
    return 'Note(title: $title, message: $message, createdAt: $createdAt, updatedAt: $updatedAt, id: $id, globalId: $globalId, syncedDevices: $syncedDevices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Note &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.globalId, globalId) ||
                other.globalId == globalId) &&
            const DeepCollectionEquality()
                .equals(other._syncedDevices, _syncedDevices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      message,
      createdAt,
      updatedAt,
      id,
      globalId,
      const DeepCollectionEquality().hash(_syncedDevices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteCopyWith<_$_Note> get copyWith =>
      __$$_NoteCopyWithImpl<_$_Note>(this, _$identity);
}

abstract class _Note implements Note {
  const factory _Note(
      {required final String title,
      required final String message,
      required final String createdAt,
      required final String updatedAt,
      required final int id,
      final String? globalId,
      required final List<SyncedDevice> syncedDevices}) = _$_Note;

  @override
  String get title;
  @override
  String get message;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  int get id;
  @override
  String? get globalId;
  @override
  List<SyncedDevice> get syncedDevices;
  @override
  @JsonKey(ignore: true)
  _$$_NoteCopyWith<_$_Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NoteDataForServer {
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  String get sendToDevice => throw _privateConstructorUsedError;
  int? get globalId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteDataForServerCopyWith<NoteDataForServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteDataForServerCopyWith<$Res> {
  factory $NoteDataForServerCopyWith(
          NoteDataForServer value, $Res Function(NoteDataForServer) then) =
      _$NoteDataForServerCopyWithImpl<$Res, NoteDataForServer>;
  @useResult
  $Res call(
      {String title,
      String message,
      String createdAt,
      String updatedAt,
      String sendToDevice,
      int? globalId});
}

/// @nodoc
class _$NoteDataForServerCopyWithImpl<$Res, $Val extends NoteDataForServer>
    implements $NoteDataForServerCopyWith<$Res> {
  _$NoteDataForServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sendToDevice = null,
    Object? globalId = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      sendToDevice: null == sendToDevice
          ? _value.sendToDevice
          : sendToDevice // ignore: cast_nullable_to_non_nullable
              as String,
      globalId: freezed == globalId
          ? _value.globalId
          : globalId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoteDataForServerCopyWith<$Res>
    implements $NoteDataForServerCopyWith<$Res> {
  factory _$$_NoteDataForServerCopyWith(_$_NoteDataForServer value,
          $Res Function(_$_NoteDataForServer) then) =
      __$$_NoteDataForServerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String message,
      String createdAt,
      String updatedAt,
      String sendToDevice,
      int? globalId});
}

/// @nodoc
class __$$_NoteDataForServerCopyWithImpl<$Res>
    extends _$NoteDataForServerCopyWithImpl<$Res, _$_NoteDataForServer>
    implements _$$_NoteDataForServerCopyWith<$Res> {
  __$$_NoteDataForServerCopyWithImpl(
      _$_NoteDataForServer _value, $Res Function(_$_NoteDataForServer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sendToDevice = null,
    Object? globalId = freezed,
  }) {
    return _then(_$_NoteDataForServer(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      sendToDevice: null == sendToDevice
          ? _value.sendToDevice
          : sendToDevice // ignore: cast_nullable_to_non_nullable
              as String,
      globalId: freezed == globalId
          ? _value.globalId
          : globalId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_NoteDataForServer implements _NoteDataForServer {
  const _$_NoteDataForServer(
      {required this.title,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      required this.sendToDevice,
      this.globalId});

  @override
  final String title;
  @override
  final String message;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String sendToDevice;
  @override
  final int? globalId;

  @override
  String toString() {
    return 'NoteDataForServer(title: $title, message: $message, createdAt: $createdAt, updatedAt: $updatedAt, sendToDevice: $sendToDevice, globalId: $globalId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoteDataForServer &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sendToDevice, sendToDevice) ||
                other.sendToDevice == sendToDevice) &&
            (identical(other.globalId, globalId) ||
                other.globalId == globalId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, message, createdAt,
      updatedAt, sendToDevice, globalId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteDataForServerCopyWith<_$_NoteDataForServer> get copyWith =>
      __$$_NoteDataForServerCopyWithImpl<_$_NoteDataForServer>(
          this, _$identity);
}

abstract class _NoteDataForServer implements NoteDataForServer {
  const factory _NoteDataForServer(
      {required final String title,
      required final String message,
      required final String createdAt,
      required final String updatedAt,
      required final String sendToDevice,
      final int? globalId}) = _$_NoteDataForServer;

  @override
  String get title;
  @override
  String get message;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  String get sendToDevice;
  @override
  int? get globalId;
  @override
  @JsonKey(ignore: true)
  _$$_NoteDataForServerCopyWith<_$_NoteDataForServer> get copyWith =>
      throw _privateConstructorUsedError;
}
