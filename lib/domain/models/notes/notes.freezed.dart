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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$SyncedDeviceImplCopyWith<$Res>
    implements $SyncedDeviceCopyWith<$Res> {
  factory _$$SyncedDeviceImplCopyWith(
          _$SyncedDeviceImpl value, $Res Function(_$SyncedDeviceImpl) then) =
      __$$SyncedDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String deviceId, bool isSynced});
}

/// @nodoc
class __$$SyncedDeviceImplCopyWithImpl<$Res>
    extends _$SyncedDeviceCopyWithImpl<$Res, _$SyncedDeviceImpl>
    implements _$$SyncedDeviceImplCopyWith<$Res> {
  __$$SyncedDeviceImplCopyWithImpl(
      _$SyncedDeviceImpl _value, $Res Function(_$SyncedDeviceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? isSynced = null,
  }) {
    return _then(_$SyncedDeviceImpl(
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
class _$SyncedDeviceImpl implements _SyncedDevice {
  const _$SyncedDeviceImpl({required this.deviceId, required this.isSynced});

  factory _$SyncedDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncedDeviceImplFromJson(json);

  @override
  final String deviceId;
  @override
  final bool isSynced;

  @override
  String toString() {
    return 'SyncedDevice(deviceId: $deviceId, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncedDeviceImpl &&
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
  _$$SyncedDeviceImplCopyWith<_$SyncedDeviceImpl> get copyWith =>
      __$$SyncedDeviceImplCopyWithImpl<_$SyncedDeviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncedDeviceImplToJson(
      this,
    );
  }
}

abstract class _SyncedDevice implements SyncedDevice {
  const factory _SyncedDevice(
      {required final String deviceId,
      required final bool isSynced}) = _$SyncedDeviceImpl;

  factory _SyncedDevice.fromJson(Map<String, dynamic> json) =
      _$SyncedDeviceImpl.fromJson;

  @override
  String get deviceId;
  @override
  bool get isSynced;
  @override
  @JsonKey(ignore: true)
  _$$SyncedDeviceImplCopyWith<_$SyncedDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DecryptedNote {
  String get title =>
      throw _privateConstructorUsedError; // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
  String get message => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String? get noteGlobalId => throw _privateConstructorUsedError;
  List<SyncedDevice> get syncedDevices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DecryptedNoteCopyWith<DecryptedNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecryptedNoteCopyWith<$Res> {
  factory $DecryptedNoteCopyWith(
          DecryptedNote value, $Res Function(DecryptedNote) then) =
      _$DecryptedNoteCopyWithImpl<$Res, DecryptedNote>;
  @useResult
  $Res call(
      {String title,
      String message,
      String createdAt,
      String updatedAt,
      int id,
      String? noteGlobalId,
      List<SyncedDevice> syncedDevices});
}

/// @nodoc
class _$DecryptedNoteCopyWithImpl<$Res, $Val extends DecryptedNote>
    implements $DecryptedNoteCopyWith<$Res> {
  _$DecryptedNoteCopyWithImpl(this._value, this._then);

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
    Object? noteGlobalId = freezed,
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
      noteGlobalId: freezed == noteGlobalId
          ? _value.noteGlobalId
          : noteGlobalId // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedDevices: null == syncedDevices
          ? _value.syncedDevices
          : syncedDevices // ignore: cast_nullable_to_non_nullable
              as List<SyncedDevice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteImplCopyWith<$Res>
    implements $DecryptedNoteCopyWith<$Res> {
  factory _$$NoteImplCopyWith(
          _$NoteImpl value, $Res Function(_$NoteImpl) then) =
      __$$NoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String message,
      String createdAt,
      String updatedAt,
      int id,
      String? noteGlobalId,
      List<SyncedDevice> syncedDevices});
}

/// @nodoc
class __$$NoteImplCopyWithImpl<$Res>
    extends _$DecryptedNoteCopyWithImpl<$Res, _$NoteImpl>
    implements _$$NoteImplCopyWith<$Res> {
  __$$NoteImplCopyWithImpl(_$NoteImpl _value, $Res Function(_$NoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? noteGlobalId = freezed,
    Object? syncedDevices = null,
  }) {
    return _then(_$NoteImpl(
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
      noteGlobalId: freezed == noteGlobalId
          ? _value.noteGlobalId
          : noteGlobalId // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedDevices: null == syncedDevices
          ? _value._syncedDevices
          : syncedDevices // ignore: cast_nullable_to_non_nullable
              as List<SyncedDevice>,
    ));
  }
}

/// @nodoc

class _$NoteImpl implements _Note {
  const _$NoteImpl(
      {required this.title,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      required this.id,
      required this.noteGlobalId,
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
  final String? noteGlobalId;
  final List<SyncedDevice> _syncedDevices;
  @override
  List<SyncedDevice> get syncedDevices {
    if (_syncedDevices is EqualUnmodifiableListView) return _syncedDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_syncedDevices);
  }

  @override
  String toString() {
    return 'DecryptedNote(title: $title, message: $message, createdAt: $createdAt, updatedAt: $updatedAt, id: $id, noteGlobalId: $noteGlobalId, syncedDevices: $syncedDevices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.noteGlobalId, noteGlobalId) ||
                other.noteGlobalId == noteGlobalId) &&
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
      noteGlobalId,
      const DeepCollectionEquality().hash(_syncedDevices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteImplCopyWith<_$NoteImpl> get copyWith =>
      __$$NoteImplCopyWithImpl<_$NoteImpl>(this, _$identity);
}

abstract class _Note implements DecryptedNote {
  const factory _Note(
      {required final String title,
      required final String message,
      required final String createdAt,
      required final String updatedAt,
      required final int id,
      required final String? noteGlobalId,
      required final List<SyncedDevice> syncedDevices}) = _$NoteImpl;

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
  String? get noteGlobalId;
  @override
  List<SyncedDevice> get syncedDevices;
  @override
  @JsonKey(ignore: true)
  _$$NoteImplCopyWith<_$NoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EncryptedNote {
  String get title =>
      throw _privateConstructorUsedError; // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
  EncryptedMessage get message => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String? get noteGlobalId => throw _privateConstructorUsedError;
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
      String? noteGlobalId,
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
    Object? noteGlobalId = freezed,
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
      noteGlobalId: freezed == noteGlobalId
          ? _value.noteGlobalId
          : noteGlobalId // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$EncryptedNoteImplCopyWith<$Res>
    implements $EncryptedNoteCopyWith<$Res> {
  factory _$$EncryptedNoteImplCopyWith(
          _$EncryptedNoteImpl value, $Res Function(_$EncryptedNoteImpl) then) =
      __$$EncryptedNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      EncryptedMessage message,
      String createdAt,
      String updatedAt,
      int id,
      String? noteGlobalId,
      List<SyncedDevice> syncedDevices});

  @override
  $EncryptedMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$EncryptedNoteImplCopyWithImpl<$Res>
    extends _$EncryptedNoteCopyWithImpl<$Res, _$EncryptedNoteImpl>
    implements _$$EncryptedNoteImplCopyWith<$Res> {
  __$$EncryptedNoteImplCopyWithImpl(
      _$EncryptedNoteImpl _value, $Res Function(_$EncryptedNoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? noteGlobalId = freezed,
    Object? syncedDevices = null,
  }) {
    return _then(_$EncryptedNoteImpl(
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
      noteGlobalId: freezed == noteGlobalId
          ? _value.noteGlobalId
          : noteGlobalId // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedDevices: null == syncedDevices
          ? _value._syncedDevices
          : syncedDevices // ignore: cast_nullable_to_non_nullable
              as List<SyncedDevice>,
    ));
  }
}

/// @nodoc

class _$EncryptedNoteImpl implements _EncryptedNote {
  const _$EncryptedNoteImpl(
      {required this.title,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      required this.id,
      required this.noteGlobalId,
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
  final String? noteGlobalId;
  final List<SyncedDevice> _syncedDevices;
  @override
  List<SyncedDevice> get syncedDevices {
    if (_syncedDevices is EqualUnmodifiableListView) return _syncedDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_syncedDevices);
  }

  @override
  String toString() {
    return 'EncryptedNote(title: $title, message: $message, createdAt: $createdAt, updatedAt: $updatedAt, id: $id, noteGlobalId: $noteGlobalId, syncedDevices: $syncedDevices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncryptedNoteImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.noteGlobalId, noteGlobalId) ||
                other.noteGlobalId == noteGlobalId) &&
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
      noteGlobalId,
      const DeepCollectionEquality().hash(_syncedDevices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EncryptedNoteImplCopyWith<_$EncryptedNoteImpl> get copyWith =>
      __$$EncryptedNoteImplCopyWithImpl<_$EncryptedNoteImpl>(this, _$identity);
}

abstract class _EncryptedNote implements EncryptedNote {
  const factory _EncryptedNote(
      {required final String title,
      required final EncryptedMessage message,
      required final String createdAt,
      required final String updatedAt,
      required final int id,
      required final String? noteGlobalId,
      required final List<SyncedDevice> syncedDevices}) = _$EncryptedNoteImpl;

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
  String? get noteGlobalId;
  @override
  List<SyncedDevice> get syncedDevices;
  @override
  @JsonKey(ignore: true)
  _$$EncryptedNoteImplCopyWith<_$EncryptedNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoteDataForServer _$NoteDataForServerFromJson(Map<String, dynamic> json) {
  return _NoteDataForServer.fromJson(json);
}

/// @nodoc
mixin _$NoteDataForServer {
  NoteDataForServerMetaData get metaData => throw _privateConstructorUsedError;
  NoteDataForServerEncryptedData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      {NoteDataForServerMetaData metaData,
      NoteDataForServerEncryptedData data});

  $NoteDataForServerMetaDataCopyWith<$Res> get metaData;
  $NoteDataForServerEncryptedDataCopyWith<$Res> get data;
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
              as NoteDataForServerEncryptedData,
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
  $NoteDataForServerEncryptedDataCopyWith<$Res> get data {
    return $NoteDataForServerEncryptedDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoteDataForServerImplCopyWith<$Res>
    implements $NoteDataForServerCopyWith<$Res> {
  factory _$$NoteDataForServerImplCopyWith(_$NoteDataForServerImpl value,
          $Res Function(_$NoteDataForServerImpl) then) =
      __$$NoteDataForServerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NoteDataForServerMetaData metaData,
      NoteDataForServerEncryptedData data});

  @override
  $NoteDataForServerMetaDataCopyWith<$Res> get metaData;
  @override
  $NoteDataForServerEncryptedDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$NoteDataForServerImplCopyWithImpl<$Res>
    extends _$NoteDataForServerCopyWithImpl<$Res, _$NoteDataForServerImpl>
    implements _$$NoteDataForServerImplCopyWith<$Res> {
  __$$NoteDataForServerImplCopyWithImpl(_$NoteDataForServerImpl _value,
      $Res Function(_$NoteDataForServerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metaData = null,
    Object? data = null,
  }) {
    return _then(_$NoteDataForServerImpl(
      metaData: null == metaData
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as NoteDataForServerMetaData,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as NoteDataForServerEncryptedData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteDataForServerImpl implements _NoteDataForServer {
  const _$NoteDataForServerImpl({required this.metaData, required this.data});

  factory _$NoteDataForServerImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteDataForServerImplFromJson(json);

  @override
  final NoteDataForServerMetaData metaData;
  @override
  final NoteDataForServerEncryptedData data;

  @override
  String toString() {
    return 'NoteDataForServer(metaData: $metaData, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteDataForServerImpl &&
            (identical(other.metaData, metaData) ||
                other.metaData == metaData) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, metaData, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteDataForServerImplCopyWith<_$NoteDataForServerImpl> get copyWith =>
      __$$NoteDataForServerImplCopyWithImpl<_$NoteDataForServerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteDataForServerImplToJson(
      this,
    );
  }
}

abstract class _NoteDataForServer implements NoteDataForServer {
  const factory _NoteDataForServer(
          {required final NoteDataForServerMetaData metaData,
          required final NoteDataForServerEncryptedData data}) =
      _$NoteDataForServerImpl;

  factory _NoteDataForServer.fromJson(Map<String, dynamic> json) =
      _$NoteDataForServerImpl.fromJson;

  @override
  NoteDataForServerMetaData get metaData;
  @override
  NoteDataForServerEncryptedData get data;
  @override
  @JsonKey(ignore: true)
  _$$NoteDataForServerImplCopyWith<_$NoteDataForServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoteDataForServerMetaData _$NoteDataForServerMetaDataFromJson(
    Map<String, dynamic> json) {
  return _NoteDataForServerMetaData.fromJson(json);
}

/// @nodoc
mixin _$NoteDataForServerMetaData {
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  String get sendToDeviceId => throw _privateConstructorUsedError;
  String? get noteGlobalId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      String? noteGlobalId});
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
    Object? noteGlobalId = freezed,
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
      noteGlobalId: freezed == noteGlobalId
          ? _value.noteGlobalId
          : noteGlobalId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteDataForServerMetaDataImplCopyWith<$Res>
    implements $NoteDataForServerMetaDataCopyWith<$Res> {
  factory _$$NoteDataForServerMetaDataImplCopyWith(
          _$NoteDataForServerMetaDataImpl value,
          $Res Function(_$NoteDataForServerMetaDataImpl) then) =
      __$$NoteDataForServerMetaDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String createdAt,
      String updatedAt,
      String sendToDeviceId,
      String? noteGlobalId});
}

/// @nodoc
class __$$NoteDataForServerMetaDataImplCopyWithImpl<$Res>
    extends _$NoteDataForServerMetaDataCopyWithImpl<$Res,
        _$NoteDataForServerMetaDataImpl>
    implements _$$NoteDataForServerMetaDataImplCopyWith<$Res> {
  __$$NoteDataForServerMetaDataImplCopyWithImpl(
      _$NoteDataForServerMetaDataImpl _value,
      $Res Function(_$NoteDataForServerMetaDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sendToDeviceId = null,
    Object? noteGlobalId = freezed,
  }) {
    return _then(_$NoteDataForServerMetaDataImpl(
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
      noteGlobalId: freezed == noteGlobalId
          ? _value.noteGlobalId
          : noteGlobalId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteDataForServerMetaDataImpl implements _NoteDataForServerMetaData {
  const _$NoteDataForServerMetaDataImpl(
      {required this.createdAt,
      required this.updatedAt,
      required this.sendToDeviceId,
      required this.noteGlobalId});

  factory _$NoteDataForServerMetaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteDataForServerMetaDataImplFromJson(json);

  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String sendToDeviceId;
  @override
  final String? noteGlobalId;

  @override
  String toString() {
    return 'NoteDataForServerMetaData(createdAt: $createdAt, updatedAt: $updatedAt, sendToDeviceId: $sendToDeviceId, noteGlobalId: $noteGlobalId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteDataForServerMetaDataImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sendToDeviceId, sendToDeviceId) ||
                other.sendToDeviceId == sendToDeviceId) &&
            (identical(other.noteGlobalId, noteGlobalId) ||
                other.noteGlobalId == noteGlobalId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, createdAt, updatedAt, sendToDeviceId, noteGlobalId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteDataForServerMetaDataImplCopyWith<_$NoteDataForServerMetaDataImpl>
      get copyWith => __$$NoteDataForServerMetaDataImplCopyWithImpl<
          _$NoteDataForServerMetaDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteDataForServerMetaDataImplToJson(
      this,
    );
  }
}

abstract class _NoteDataForServerMetaData implements NoteDataForServerMetaData {
  const factory _NoteDataForServerMetaData(
      {required final String createdAt,
      required final String updatedAt,
      required final String sendToDeviceId,
      required final String? noteGlobalId}) = _$NoteDataForServerMetaDataImpl;

  factory _NoteDataForServerMetaData.fromJson(Map<String, dynamic> json) =
      _$NoteDataForServerMetaDataImpl.fromJson;

  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  String get sendToDeviceId;
  @override
  String? get noteGlobalId;
  @override
  @JsonKey(ignore: true)
  _$$NoteDataForServerMetaDataImplCopyWith<_$NoteDataForServerMetaDataImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$NoteDataForServerEncryptedDataImplCopyWith<$Res>
    implements $NoteDataForServerEncryptedDataCopyWith<$Res> {
  factory _$$NoteDataForServerEncryptedDataImplCopyWith(
          _$NoteDataForServerEncryptedDataImpl value,
          $Res Function(_$NoteDataForServerEncryptedDataImpl) then) =
      __$$NoteDataForServerEncryptedDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EncryptedMessage title, EncryptedMessage message});

  @override
  $EncryptedMessageCopyWith<$Res> get title;
  @override
  $EncryptedMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$NoteDataForServerEncryptedDataImplCopyWithImpl<$Res>
    extends _$NoteDataForServerEncryptedDataCopyWithImpl<$Res,
        _$NoteDataForServerEncryptedDataImpl>
    implements _$$NoteDataForServerEncryptedDataImplCopyWith<$Res> {
  __$$NoteDataForServerEncryptedDataImplCopyWithImpl(
      _$NoteDataForServerEncryptedDataImpl _value,
      $Res Function(_$NoteDataForServerEncryptedDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_$NoteDataForServerEncryptedDataImpl(
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
class _$NoteDataForServerEncryptedDataImpl
    implements _NoteDataForServerEncryptedData {
  const _$NoteDataForServerEncryptedDataImpl(
      {required this.title, required this.message});

  factory _$NoteDataForServerEncryptedDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NoteDataForServerEncryptedDataImplFromJson(json);

  @override
  final EncryptedMessage title;
  @override
  final EncryptedMessage message;

  @override
  String toString() {
    return 'NoteDataForServerEncryptedData(title: $title, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteDataForServerEncryptedDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteDataForServerEncryptedDataImplCopyWith<
          _$NoteDataForServerEncryptedDataImpl>
      get copyWith => __$$NoteDataForServerEncryptedDataImplCopyWithImpl<
          _$NoteDataForServerEncryptedDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteDataForServerEncryptedDataImplToJson(
      this,
    );
  }
}

abstract class _NoteDataForServerEncryptedData
    implements NoteDataForServerEncryptedData {
  const factory _NoteDataForServerEncryptedData(
          {required final EncryptedMessage title,
          required final EncryptedMessage message}) =
      _$NoteDataForServerEncryptedDataImpl;

  factory _NoteDataForServerEncryptedData.fromJson(Map<String, dynamic> json) =
      _$NoteDataForServerEncryptedDataImpl.fromJson;

  @override
  EncryptedMessage get title;
  @override
  EncryptedMessage get message;
  @override
  @JsonKey(ignore: true)
  _$$NoteDataForServerEncryptedDataImplCopyWith<
          _$NoteDataForServerEncryptedDataImpl>
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
abstract class _$$EncryptedMessageImplCopyWith<$Res>
    implements $EncryptedMessageCopyWith<$Res> {
  factory _$$EncryptedMessageImplCopyWith(_$EncryptedMessageImpl value,
          $Res Function(_$EncryptedMessageImpl) then) =
      __$$EncryptedMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> cipherText, List<int> nonce, List<int> mac});
}

/// @nodoc
class __$$EncryptedMessageImplCopyWithImpl<$Res>
    extends _$EncryptedMessageCopyWithImpl<$Res, _$EncryptedMessageImpl>
    implements _$$EncryptedMessageImplCopyWith<$Res> {
  __$$EncryptedMessageImplCopyWithImpl(_$EncryptedMessageImpl _value,
      $Res Function(_$EncryptedMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cipherText = null,
    Object? nonce = null,
    Object? mac = null,
  }) {
    return _then(_$EncryptedMessageImpl(
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
class _$EncryptedMessageImpl implements _EncryptedMessage {
  const _$EncryptedMessageImpl(
      {required final List<int> cipherText,
      required final List<int> nonce,
      required final List<int> mac})
      : _cipherText = cipherText,
        _nonce = nonce,
        _mac = mac;

  factory _$EncryptedMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$EncryptedMessageImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncryptedMessageImpl &&
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
  _$$EncryptedMessageImplCopyWith<_$EncryptedMessageImpl> get copyWith =>
      __$$EncryptedMessageImplCopyWithImpl<_$EncryptedMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EncryptedMessageImplToJson(
      this,
    );
  }
}

abstract class _EncryptedMessage implements EncryptedMessage {
  const factory _EncryptedMessage(
      {required final List<int> cipherText,
      required final List<int> nonce,
      required final List<int> mac}) = _$EncryptedMessageImpl;

  factory _EncryptedMessage.fromJson(Map<String, dynamic> json) =
      _$EncryptedMessageImpl.fromJson;

  @override
  List<int> get cipherText;
  @override
  List<int> get nonce;
  @override
  List<int> get mac;
  @override
  @JsonKey(ignore: true)
  _$$EncryptedMessageImplCopyWith<_$EncryptedMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
