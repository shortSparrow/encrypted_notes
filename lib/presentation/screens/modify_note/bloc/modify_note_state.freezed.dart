// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modify_note_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ModifyNoteState {
  Note? get editableNote => throw _privateConstructorUsedError;
  RequestStatus get loadingEditNote => throw _privateConstructorUsedError;
  RequestStatus get loadingSaveNote => throw _privateConstructorUsedError;
  ModifyNoteMode get mode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModifyNoteStateCopyWith<ModifyNoteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModifyNoteStateCopyWith<$Res> {
  factory $ModifyNoteStateCopyWith(
          ModifyNoteState value, $Res Function(ModifyNoteState) then) =
      _$ModifyNoteStateCopyWithImpl<$Res, ModifyNoteState>;
  @useResult
  $Res call(
      {Note? editableNote,
      RequestStatus loadingEditNote,
      RequestStatus loadingSaveNote,
      ModifyNoteMode mode});

  $NoteCopyWith<$Res>? get editableNote;
}

/// @nodoc
class _$ModifyNoteStateCopyWithImpl<$Res, $Val extends ModifyNoteState>
    implements $ModifyNoteStateCopyWith<$Res> {
  _$ModifyNoteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editableNote = freezed,
    Object? loadingEditNote = null,
    Object? loadingSaveNote = null,
    Object? mode = null,
  }) {
    return _then(_value.copyWith(
      editableNote: freezed == editableNote
          ? _value.editableNote
          : editableNote // ignore: cast_nullable_to_non_nullable
              as Note?,
      loadingEditNote: null == loadingEditNote
          ? _value.loadingEditNote
          : loadingEditNote // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      loadingSaveNote: null == loadingSaveNote
          ? _value.loadingSaveNote
          : loadingSaveNote // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ModifyNoteMode,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NoteCopyWith<$Res>? get editableNote {
    if (_value.editableNote == null) {
      return null;
    }

    return $NoteCopyWith<$Res>(_value.editableNote!, (value) {
      return _then(_value.copyWith(editableNote: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ModifyNoteStateImplCopyWith<$Res>
    implements $ModifyNoteStateCopyWith<$Res> {
  factory _$$ModifyNoteStateImplCopyWith(_$ModifyNoteStateImpl value,
          $Res Function(_$ModifyNoteStateImpl) then) =
      __$$ModifyNoteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Note? editableNote,
      RequestStatus loadingEditNote,
      RequestStatus loadingSaveNote,
      ModifyNoteMode mode});

  @override
  $NoteCopyWith<$Res>? get editableNote;
}

/// @nodoc
class __$$ModifyNoteStateImplCopyWithImpl<$Res>
    extends _$ModifyNoteStateCopyWithImpl<$Res, _$ModifyNoteStateImpl>
    implements _$$ModifyNoteStateImplCopyWith<$Res> {
  __$$ModifyNoteStateImplCopyWithImpl(
      _$ModifyNoteStateImpl _value, $Res Function(_$ModifyNoteStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editableNote = freezed,
    Object? loadingEditNote = null,
    Object? loadingSaveNote = null,
    Object? mode = null,
  }) {
    return _then(_$ModifyNoteStateImpl(
      editableNote: freezed == editableNote
          ? _value.editableNote
          : editableNote // ignore: cast_nullable_to_non_nullable
              as Note?,
      loadingEditNote: null == loadingEditNote
          ? _value.loadingEditNote
          : loadingEditNote // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      loadingSaveNote: null == loadingSaveNote
          ? _value.loadingSaveNote
          : loadingSaveNote // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ModifyNoteMode,
    ));
  }
}

/// @nodoc

class _$ModifyNoteStateImpl implements _ModifyNoteState {
  const _$ModifyNoteStateImpl(
      {this.editableNote,
      this.loadingEditNote = RequestStatus.idle,
      this.loadingSaveNote = RequestStatus.idle,
      this.mode = ModifyNoteMode.add});

  @override
  final Note? editableNote;
  @override
  @JsonKey()
  final RequestStatus loadingEditNote;
  @override
  @JsonKey()
  final RequestStatus loadingSaveNote;
  @override
  @JsonKey()
  final ModifyNoteMode mode;

  @override
  String toString() {
    return 'ModifyNoteState(editableNote: $editableNote, loadingEditNote: $loadingEditNote, loadingSaveNote: $loadingSaveNote, mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModifyNoteStateImpl &&
            (identical(other.editableNote, editableNote) ||
                other.editableNote == editableNote) &&
            (identical(other.loadingEditNote, loadingEditNote) ||
                other.loadingEditNote == loadingEditNote) &&
            (identical(other.loadingSaveNote, loadingSaveNote) ||
                other.loadingSaveNote == loadingSaveNote) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, editableNote, loadingEditNote, loadingSaveNote, mode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModifyNoteStateImplCopyWith<_$ModifyNoteStateImpl> get copyWith =>
      __$$ModifyNoteStateImplCopyWithImpl<_$ModifyNoteStateImpl>(
          this, _$identity);
}

abstract class _ModifyNoteState implements ModifyNoteState {
  const factory _ModifyNoteState(
      {final Note? editableNote,
      final RequestStatus loadingEditNote,
      final RequestStatus loadingSaveNote,
      final ModifyNoteMode mode}) = _$ModifyNoteStateImpl;

  @override
  Note? get editableNote;
  @override
  RequestStatus get loadingEditNote;
  @override
  RequestStatus get loadingSaveNote;
  @override
  ModifyNoteMode get mode;
  @override
  @JsonKey(ignore: true)
  _$$ModifyNoteStateImplCopyWith<_$ModifyNoteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
