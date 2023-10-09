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
  String get title =>
      throw _privateConstructorUsedError; // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
  String get message => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int? get globalId => throw _privateConstructorUsedError;
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
      int? globalId,
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
              as int?,
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
      int? globalId,
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
              as int?,
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
      required this.globalId,
      required final List<SyncedDevice> syncedDevices})
      : _syncedDevices = syncedDevices;

  @override
  final String title;
// Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
  @override
  final String message;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final int id;
  @override
  final int? globalId;
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
      required final int? globalId,
      required final List<SyncedDevice> syncedDevices}) = _$_Note;

  @override
  String get title;
  @override // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
  String get message;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  int get id;
  @override
  int? get globalId;
  @override
  List<SyncedDevice> get syncedDevices;
  @override
  @JsonKey(ignore: true)
  _$$_NoteCopyWith<_$_Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EncryptedNote {
  String get title =>
      throw _privateConstructorUsedError; // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
  EncryptedMessage get message => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int? get globalId => throw _privateConstructorUsedError;
  List<SyncedDevice> get syncedDevices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncryptedNoteCopyWith<EncryptedNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncryptedNoteCopyWith<$Res> {
  factory $EncryptedNoteCopyWith(
          EncryptedNote value, $Res Function(EncryptedNote) then) =
      _$EncryptedNoteCopyWithImpl<$Res, EncryptedNote>;
  @useResult
  $Res call(
      {String title,
      EncryptedMessage message,
      String createdAt,
      String updatedAt,
      int id,
      int? globalId,
      List<SyncedDevice> syncedDevices});

  $EncryptedMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$EncryptedNoteCopyWithImpl<$Res, $Val extends EncryptedNote>
    implements $EncryptedNoteCopyWith<$Res> {
  _$EncryptedNoteCopyWithImpl(this._value, this._then);

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
              as EncryptedMessage,
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
              as int?,
      syncedDevices: null == syncedDevices
          ? _value.syncedDevices
          : syncedDevices // ignore: cast_nullable_to_non_nullable
              as List<SyncedDevice>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EncryptedMessageCopyWith<$Res> get message {
    return $EncryptedMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EncryptedNoteCopyWith<$Res>
    implements $EncryptedNoteCopyWith<$Res> {
  factory _$$_EncryptedNoteCopyWith(
          _$_EncryptedNote value, $Res Function(_$_EncryptedNote) then) =
      __$$_EncryptedNoteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      EncryptedMessage message,
      String createdAt,
      String updatedAt,
      int id,
      int? globalId,
      List<SyncedDevice> syncedDevices});

  @override
  $EncryptedMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$_EncryptedNoteCopyWithImpl<$Res>
    extends _$EncryptedNoteCopyWithImpl<$Res, _$_EncryptedNote>
    implements _$$_EncryptedNoteCopyWith<$Res> {
  __$$_EncryptedNoteCopyWithImpl(
      _$_EncryptedNote _value, $Res Function(_$_EncryptedNote) _then)
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
    return _then(_$_EncryptedNote(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
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
              as int?,
      syncedDevices: null == syncedDevices
          ? _value._syncedDevices
          : syncedDevices // ignore: cast_nullable_to_non_nullable
              as List<SyncedDevice>,
    ));
  }
}

/// @nodoc

class _$_EncryptedNote implements _EncryptedNote {
  const _$_EncryptedNote(
      {required this.title,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      required this.id,
      required this.globalId,
      required final List<SyncedDevice> syncedDevices})
      : _syncedDevices = syncedDevices;

  @override
  final String title;
// Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
  @override
  final EncryptedMessage message;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final int id;
  @override
  final int? globalId;
  final List<SyncedDevice> _syncedDevices;
  @override
  List<SyncedDevice> get syncedDevices {
    if (_syncedDevices is EqualUnmodifiableListView) return _syncedDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_syncedDevices);
  }

  @override
  String toString() {
    return 'EncryptedNote(title: $title, message: $message, createdAt: $createdAt, updatedAt: $updatedAt, id: $id, globalId: $globalId, syncedDevices: $syncedDevices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EncryptedNote &&
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
  _$$_EncryptedNoteCopyWith<_$_EncryptedNote> get copyWith =>
      __$$_EncryptedNoteCopyWithImpl<_$_EncryptedNote>(this, _$identity);
}

abstract class _EncryptedNote implements EncryptedNote {
  const factory _EncryptedNote(
      {required final String title,
      required final EncryptedMessage message,
      required final String createdAt,
      required final String updatedAt,
      required final int id,
      required final int? globalId,
      required final List<SyncedDevice> syncedDevices}) = _$_EncryptedNote;

  @override
  String get title;
  @override // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
  EncryptedMessage get message;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  int get id;
  @override
  int? get globalId;
  @override
  List<SyncedDevice> get syncedDevices;
  @override
  @JsonKey(ignore: true)
  _$$_EncryptedNoteCopyWith<_$_EncryptedNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NoteForServer {
  int? get globalId => throw _privateConstructorUsedError;
  List<NoteDataForServer> get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteForServerCopyWith<NoteForServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteForServerCopyWith<$Res> {
  factory $NoteForServerCopyWith(
          NoteForServer value, $Res Function(NoteForServer) then) =
      _$NoteForServerCopyWithImpl<$Res, NoteForServer>;
  @useResult
  $Res call({int? globalId, List<NoteDataForServer> data});
}

/// @nodoc
class _$NoteForServerCopyWithImpl<$Res, $Val extends NoteForServer>
    implements $NoteForServerCopyWith<$Res> {
  _$NoteForServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? globalId = freezed,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      globalId: freezed == globalId
          ? _value.globalId
          : globalId // ignore: cast_nullable_to_non_nullable
              as int?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<NoteDataForServer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoteForServerCopyWith<$Res>
    implements $NoteForServerCopyWith<$Res> {
  factory _$$_NoteForServerCopyWith(
          _$_NoteForServer value, $Res Function(_$_NoteForServer) then) =
      __$$_NoteForServerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? globalId, List<NoteDataForServer> data});
}

/// @nodoc
class __$$_NoteForServerCopyWithImpl<$Res>
    extends _$NoteForServerCopyWithImpl<$Res, _$_NoteForServer>
    implements _$$_NoteForServerCopyWith<$Res> {
  __$$_NoteForServerCopyWithImpl(
      _$_NoteForServer _value, $Res Function(_$_NoteForServer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? globalId = freezed,
    Object? data = null,
  }) {
    return _then(_$_NoteForServer(
      globalId: freezed == globalId
          ? _value.globalId
          : globalId // ignore: cast_nullable_to_non_nullable
              as int?,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<NoteDataForServer>,
    ));
  }
}

/// @nodoc

class _$_NoteForServer implements _NoteForServer {
  const _$_NoteForServer(
      {required this.globalId, required final List<NoteDataForServer> data})
      : _data = data;

  @override
  final int? globalId;
  final List<NoteDataForServer> _data;
  @override
  List<NoteDataForServer> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'NoteForServer(globalId: $globalId, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoteForServer &&
            (identical(other.globalId, globalId) ||
                other.globalId == globalId) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, globalId, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteForServerCopyWith<_$_NoteForServer> get copyWith =>
      __$$_NoteForServerCopyWithImpl<_$_NoteForServer>(this, _$identity);
}

abstract class _NoteForServer implements NoteForServer {
  const factory _NoteForServer(
      {required final int? globalId,
      required final List<NoteDataForServer> data}) = _$_NoteForServer;

  @override
  int? get globalId;
  @override
  List<NoteDataForServer> get data;
  @override
  @JsonKey(ignore: true)
  _$$_NoteForServerCopyWith<_$_NoteForServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NoteDataForServer {
  NoteDataForServerMetaData get metaData => throw _privateConstructorUsedError;
  NoteDataForServerData get data => throw _privateConstructorUsedError;

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
  $Res call({NoteDataForServerMetaData metaData, NoteDataForServerData data});

  $NoteDataForServerMetaDataCopyWith<$Res> get metaData;
  $NoteDataForServerDataCopyWith<$Res> get data;
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
    Object? metaData = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      metaData: null == metaData
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as NoteDataForServerMetaData,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as NoteDataForServerData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NoteDataForServerMetaDataCopyWith<$Res> get metaData {
    return $NoteDataForServerMetaDataCopyWith<$Res>(_value.metaData, (value) {
      return _then(_value.copyWith(metaData: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NoteDataForServerDataCopyWith<$Res> get data {
    return $NoteDataForServerDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
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
  $Res call({NoteDataForServerMetaData metaData, NoteDataForServerData data});

  @override
  $NoteDataForServerMetaDataCopyWith<$Res> get metaData;
  @override
  $NoteDataForServerDataCopyWith<$Res> get data;
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
    Object? metaData = null,
    Object? data = null,
  }) {
    return _then(_$_NoteDataForServer(
      metaData: null == metaData
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as NoteDataForServerMetaData,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as NoteDataForServerData,
    ));
  }
}

/// @nodoc

class _$_NoteDataForServer implements _NoteDataForServer {
  const _$_NoteDataForServer({required this.metaData, required this.data});

  @override
  final NoteDataForServerMetaData metaData;
  @override
  final NoteDataForServerData data;

  @override
  String toString() {
    return 'NoteDataForServer(metaData: $metaData, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoteDataForServer &&
            (identical(other.metaData, metaData) ||
                other.metaData == metaData) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, metaData, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteDataForServerCopyWith<_$_NoteDataForServer> get copyWith =>
      __$$_NoteDataForServerCopyWithImpl<_$_NoteDataForServer>(
          this, _$identity);
}

abstract class _NoteDataForServer implements NoteDataForServer {
  const factory _NoteDataForServer(
      {required final NoteDataForServerMetaData metaData,
      required final NoteDataForServerData data}) = _$_NoteDataForServer;

  @override
  NoteDataForServerMetaData get metaData;
  @override
  NoteDataForServerData get data;
  @override
  @JsonKey(ignore: true)
  _$$_NoteDataForServerCopyWith<_$_NoteDataForServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NoteDataForServerMetaData {
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  String get sendToDeviceId => throw _privateConstructorUsedError;
  int? get globalId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteDataForServerMetaDataCopyWith<NoteDataForServerMetaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteDataForServerMetaDataCopyWith<$Res> {
  factory $NoteDataForServerMetaDataCopyWith(NoteDataForServerMetaData value,
          $Res Function(NoteDataForServerMetaData) then) =
      _$NoteDataForServerMetaDataCopyWithImpl<$Res, NoteDataForServerMetaData>;
  @useResult
  $Res call(
      {String createdAt,
      String updatedAt,
      String sendToDeviceId,
      int? globalId});
}

/// @nodoc
class _$NoteDataForServerMetaDataCopyWithImpl<$Res,
        $Val extends NoteDataForServerMetaData>
    implements $NoteDataForServerMetaDataCopyWith<$Res> {
  _$NoteDataForServerMetaDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sendToDeviceId = null,
    Object? globalId = freezed,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      sendToDeviceId: null == sendToDeviceId
          ? _value.sendToDeviceId
          : sendToDeviceId // ignore: cast_nullable_to_non_nullable
              as String,
      globalId: freezed == globalId
          ? _value.globalId
          : globalId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoteDataForServerMetaDataCopyWith<$Res>
    implements $NoteDataForServerMetaDataCopyWith<$Res> {
  factory _$$_NoteDataForServerMetaDataCopyWith(
          _$_NoteDataForServerMetaData value,
          $Res Function(_$_NoteDataForServerMetaData) then) =
      __$$_NoteDataForServerMetaDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String createdAt,
      String updatedAt,
      String sendToDeviceId,
      int? globalId});
}

/// @nodoc
class __$$_NoteDataForServerMetaDataCopyWithImpl<$Res>
    extends _$NoteDataForServerMetaDataCopyWithImpl<$Res,
        _$_NoteDataForServerMetaData>
    implements _$$_NoteDataForServerMetaDataCopyWith<$Res> {
  __$$_NoteDataForServerMetaDataCopyWithImpl(
      _$_NoteDataForServerMetaData _value,
      $Res Function(_$_NoteDataForServerMetaData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sendToDeviceId = null,
    Object? globalId = freezed,
  }) {
    return _then(_$_NoteDataForServerMetaData(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      sendToDeviceId: null == sendToDeviceId
          ? _value.sendToDeviceId
          : sendToDeviceId // ignore: cast_nullable_to_non_nullable
              as String,
      globalId: freezed == globalId
          ? _value.globalId
          : globalId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_NoteDataForServerMetaData implements _NoteDataForServerMetaData {
  const _$_NoteDataForServerMetaData(
      {required this.createdAt,
      required this.updatedAt,
      required this.sendToDeviceId,
      required this.globalId});

  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String sendToDeviceId;
  @override
  final int? globalId;

  @override
  String toString() {
    return 'NoteDataForServerMetaData(createdAt: $createdAt, updatedAt: $updatedAt, sendToDeviceId: $sendToDeviceId, globalId: $globalId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoteDataForServerMetaData &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sendToDeviceId, sendToDeviceId) ||
                other.sendToDeviceId == sendToDeviceId) &&
            (identical(other.globalId, globalId) ||
                other.globalId == globalId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, createdAt, updatedAt, sendToDeviceId, globalId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteDataForServerMetaDataCopyWith<_$_NoteDataForServerMetaData>
      get copyWith => __$$_NoteDataForServerMetaDataCopyWithImpl<
          _$_NoteDataForServerMetaData>(this, _$identity);
}

abstract class _NoteDataForServerMetaData implements NoteDataForServerMetaData {
  const factory _NoteDataForServerMetaData(
      {required final String createdAt,
      required final String updatedAt,
      required final String sendToDeviceId,
      required final int? globalId}) = _$_NoteDataForServerMetaData;

  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  String get sendToDeviceId;
  @override
  int? get globalId;
  @override
  @JsonKey(ignore: true)
  _$$_NoteDataForServerMetaDataCopyWith<_$_NoteDataForServerMetaData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NoteDataForServerData {
  EncryptedMessage get title => throw _privateConstructorUsedError;
  EncryptedMessage get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteDataForServerDataCopyWith<NoteDataForServerData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteDataForServerDataCopyWith<$Res> {
  factory $NoteDataForServerDataCopyWith(NoteDataForServerData value,
          $Res Function(NoteDataForServerData) then) =
      _$NoteDataForServerDataCopyWithImpl<$Res, NoteDataForServerData>;
  @useResult
  $Res call({EncryptedMessage title, EncryptedMessage message});

  $EncryptedMessageCopyWith<$Res> get title;
  $EncryptedMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$NoteDataForServerDataCopyWithImpl<$Res,
        $Val extends NoteDataForServerData>
    implements $NoteDataForServerDataCopyWith<$Res> {
  _$NoteDataForServerDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EncryptedMessageCopyWith<$Res> get title {
    return $EncryptedMessageCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EncryptedMessageCopyWith<$Res> get message {
    return $EncryptedMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NoteDataForServerDataCopyWith<$Res>
    implements $NoteDataForServerDataCopyWith<$Res> {
  factory _$$_NoteDataForServerDataCopyWith(_$_NoteDataForServerData value,
          $Res Function(_$_NoteDataForServerData) then) =
      __$$_NoteDataForServerDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EncryptedMessage title, EncryptedMessage message});

  @override
  $EncryptedMessageCopyWith<$Res> get title;
  @override
  $EncryptedMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$_NoteDataForServerDataCopyWithImpl<$Res>
    extends _$NoteDataForServerDataCopyWithImpl<$Res, _$_NoteDataForServerData>
    implements _$$_NoteDataForServerDataCopyWith<$Res> {
  __$$_NoteDataForServerDataCopyWithImpl(_$_NoteDataForServerData _value,
      $Res Function(_$_NoteDataForServerData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_$_NoteDataForServerData(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
    ));
  }
}

/// @nodoc

class _$_NoteDataForServerData implements _NoteDataForServerData {
  const _$_NoteDataForServerData({required this.title, required this.message});

  @override
  final EncryptedMessage title;
  @override
  final EncryptedMessage message;

  @override
  String toString() {
    return 'NoteDataForServerData(title: $title, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoteDataForServerData &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteDataForServerDataCopyWith<_$_NoteDataForServerData> get copyWith =>
      __$$_NoteDataForServerDataCopyWithImpl<_$_NoteDataForServerData>(
          this, _$identity);
}

abstract class _NoteDataForServerData implements NoteDataForServerData {
  const factory _NoteDataForServerData(
      {required final EncryptedMessage title,
      required final EncryptedMessage message}) = _$_NoteDataForServerData;

  @override
  EncryptedMessage get title;
  @override
  EncryptedMessage get message;
  @override
  @JsonKey(ignore: true)
  _$$_NoteDataForServerDataCopyWith<_$_NoteDataForServerData> get copyWith =>
      throw _privateConstructorUsedError;
}

NoteDataForServerEncryptedData _$NoteDataForServerEncryptedDataFromJson(
    Map<String, dynamic> json) {
  return _NoteDataForServerEncryptedData.fromJson(json);
}

/// @nodoc
mixin _$NoteDataForServerEncryptedData {
  EncryptedMessage get title => throw _privateConstructorUsedError;
  EncryptedMessage get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteDataForServerEncryptedDataCopyWith<NoteDataForServerEncryptedData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteDataForServerEncryptedDataCopyWith<$Res> {
  factory $NoteDataForServerEncryptedDataCopyWith(
          NoteDataForServerEncryptedData value,
          $Res Function(NoteDataForServerEncryptedData) then) =
      _$NoteDataForServerEncryptedDataCopyWithImpl<$Res,
          NoteDataForServerEncryptedData>;
  @useResult
  $Res call({EncryptedMessage title, EncryptedMessage message});

  $EncryptedMessageCopyWith<$Res> get title;
  $EncryptedMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$NoteDataForServerEncryptedDataCopyWithImpl<$Res,
        $Val extends NoteDataForServerEncryptedData>
    implements $NoteDataForServerEncryptedDataCopyWith<$Res> {
  _$NoteDataForServerEncryptedDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EncryptedMessageCopyWith<$Res> get title {
    return $EncryptedMessageCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EncryptedMessageCopyWith<$Res> get message {
    return $EncryptedMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NoteDataForServerEncryptedDataCopyWith<$Res>
    implements $NoteDataForServerEncryptedDataCopyWith<$Res> {
  factory _$$_NoteDataForServerEncryptedDataCopyWith(
          _$_NoteDataForServerEncryptedData value,
          $Res Function(_$_NoteDataForServerEncryptedData) then) =
      __$$_NoteDataForServerEncryptedDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EncryptedMessage title, EncryptedMessage message});

  @override
  $EncryptedMessageCopyWith<$Res> get title;
  @override
  $EncryptedMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$_NoteDataForServerEncryptedDataCopyWithImpl<$Res>
    extends _$NoteDataForServerEncryptedDataCopyWithImpl<$Res,
        _$_NoteDataForServerEncryptedData>
    implements _$$_NoteDataForServerEncryptedDataCopyWith<$Res> {
  __$$_NoteDataForServerEncryptedDataCopyWithImpl(
      _$_NoteDataForServerEncryptedData _value,
      $Res Function(_$_NoteDataForServerEncryptedData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_$_NoteDataForServerEncryptedData(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as EncryptedMessage,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NoteDataForServerEncryptedData
    implements _NoteDataForServerEncryptedData {
  const _$_NoteDataForServerEncryptedData(
      {required this.title, required this.message});

  factory _$_NoteDataForServerEncryptedData.fromJson(
          Map<String, dynamic> json) =>
      _$$_NoteDataForServerEncryptedDataFromJson(json);

  @override
  final EncryptedMessage title;
  @override
  final EncryptedMessage message;

  @override
  String toString() {
    return 'NoteDataForServerEncryptedData(title: $title, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoteDataForServerEncryptedData &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteDataForServerEncryptedDataCopyWith<_$_NoteDataForServerEncryptedData>
      get copyWith => __$$_NoteDataForServerEncryptedDataCopyWithImpl<
          _$_NoteDataForServerEncryptedData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoteDataForServerEncryptedDataToJson(
      this,
    );
  }
}

abstract class _NoteDataForServerEncryptedData
    implements NoteDataForServerEncryptedData {
  const factory _NoteDataForServerEncryptedData(
          {required final EncryptedMessage title,
          required final EncryptedMessage message}) =
      _$_NoteDataForServerEncryptedData;

  factory _NoteDataForServerEncryptedData.fromJson(Map<String, dynamic> json) =
      _$_NoteDataForServerEncryptedData.fromJson;

  @override
  EncryptedMessage get title;
  @override
  EncryptedMessage get message;
  @override
  @JsonKey(ignore: true)
  _$$_NoteDataForServerEncryptedDataCopyWith<_$_NoteDataForServerEncryptedData>
      get copyWith => throw _privateConstructorUsedError;
}

EncryptedMessage _$EncryptedMessageFromJson(Map<String, dynamic> json) {
  return _EncryptedMessage.fromJson(json);
}

/// @nodoc
mixin _$EncryptedMessage {
  List<int> get cipherText => throw _privateConstructorUsedError;
  List<int> get nonce => throw _privateConstructorUsedError;
  List<int> get mac => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EncryptedMessageCopyWith<EncryptedMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncryptedMessageCopyWith<$Res> {
  factory $EncryptedMessageCopyWith(
          EncryptedMessage value, $Res Function(EncryptedMessage) then) =
      _$EncryptedMessageCopyWithImpl<$Res, EncryptedMessage>;
  @useResult
  $Res call({List<int> cipherText, List<int> nonce, List<int> mac});
}

/// @nodoc
class _$EncryptedMessageCopyWithImpl<$Res, $Val extends EncryptedMessage>
    implements $EncryptedMessageCopyWith<$Res> {
  _$EncryptedMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cipherText = null,
    Object? nonce = null,
    Object? mac = null,
  }) {
    return _then(_value.copyWith(
      cipherText: null == cipherText
          ? _value.cipherText
          : cipherText // ignore: cast_nullable_to_non_nullable
              as List<int>,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as List<int>,
      mac: null == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EncryptedMessageCopyWith<$Res>
    implements $EncryptedMessageCopyWith<$Res> {
  factory _$$_EncryptedMessageCopyWith(
          _$_EncryptedMessage value, $Res Function(_$_EncryptedMessage) then) =
      __$$_EncryptedMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> cipherText, List<int> nonce, List<int> mac});
}

/// @nodoc
class __$$_EncryptedMessageCopyWithImpl<$Res>
    extends _$EncryptedMessageCopyWithImpl<$Res, _$_EncryptedMessage>
    implements _$$_EncryptedMessageCopyWith<$Res> {
  __$$_EncryptedMessageCopyWithImpl(
      _$_EncryptedMessage _value, $Res Function(_$_EncryptedMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cipherText = null,
    Object? nonce = null,
    Object? mac = null,
  }) {
    return _then(_$_EncryptedMessage(
      cipherText: null == cipherText
          ? _value._cipherText
          : cipherText // ignore: cast_nullable_to_non_nullable
              as List<int>,
      nonce: null == nonce
          ? _value._nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as List<int>,
      mac: null == mac
          ? _value._mac
          : mac // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EncryptedMessage implements _EncryptedMessage {
  const _$_EncryptedMessage(
      {required final List<int> cipherText,
      required final List<int> nonce,
      required final List<int> mac})
      : _cipherText = cipherText,
        _nonce = nonce,
        _mac = mac;

  factory _$_EncryptedMessage.fromJson(Map<String, dynamic> json) =>
      _$$_EncryptedMessageFromJson(json);

  final List<int> _cipherText;
  @override
  List<int> get cipherText {
    if (_cipherText is EqualUnmodifiableListView) return _cipherText;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cipherText);
  }

  final List<int> _nonce;
  @override
  List<int> get nonce {
    if (_nonce is EqualUnmodifiableListView) return _nonce;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nonce);
  }

  final List<int> _mac;
  @override
  List<int> get mac {
    if (_mac is EqualUnmodifiableListView) return _mac;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mac);
  }

  @override
  String toString() {
    return 'EncryptedMessage(cipherText: $cipherText, nonce: $nonce, mac: $mac)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EncryptedMessage &&
            const DeepCollectionEquality()
                .equals(other._cipherText, _cipherText) &&
            const DeepCollectionEquality().equals(other._nonce, _nonce) &&
            const DeepCollectionEquality().equals(other._mac, _mac));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cipherText),
      const DeepCollectionEquality().hash(_nonce),
      const DeepCollectionEquality().hash(_mac));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EncryptedMessageCopyWith<_$_EncryptedMessage> get copyWith =>
      __$$_EncryptedMessageCopyWithImpl<_$_EncryptedMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EncryptedMessageToJson(
      this,
    );
  }
}

abstract class _EncryptedMessage implements EncryptedMessage {
  const factory _EncryptedMessage(
      {required final List<int> cipherText,
      required final List<int> nonce,
      required final List<int> mac}) = _$_EncryptedMessage;

  factory _EncryptedMessage.fromJson(Map<String, dynamic> json) =
      _$_EncryptedMessage.fromJson;

  @override
  List<int> get cipherText;
  @override
  List<int> get nonce;
  @override
  List<int> get mac;
  @override
  @JsonKey(ignore: true)
  _$$_EncryptedMessageCopyWith<_$_EncryptedMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
