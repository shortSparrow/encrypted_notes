import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/modify_note_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_note_state.freezed.dart';

@freezed
class ModifyNoteState with _$ModifyNoteState {
  const factory ModifyNoteState({
    Note? editableNote,
    @Default(RequestStatus.idle) RequestStatus loadingEditNote,
    @Default(RequestStatus.idle) RequestStatus loadingSaveNote,
    @Default(ModifyNoteMode.add) ModifyNoteMode mode,
  }) = _ModifyNoteState;
}

// import 'package:equatable/equatable.dart';
// part of 'modify_note_bloc.dart';

// class ModifyNoteState extends Equatable {

//   final Note? editableNote;
//   final RequestStatus loadingEditNote;
//   final RequestStatus loadingDaveNote;
//   final ModifyNoteMode mode;
//   const ModifyNoteState({
//     this.editableNote,
//     this.mode = ModifyNoteMode.add,
//     this.loadingEditNote = RequestStatus.idle,
//     this.loadingDaveNote = RequestStatus.idle
//   });

//   ModifyNoteState copyWith({
//     Note? editableNote,
//     ModifyNoteMode? mode,
//     RequestStatus? loadingEditNote,
//   }) {
//     return ModifyNoteState(
//       editableNote: editableNote ?? this.editableNote,
//       mode: mode ?? this.mode,
//       loadingEditNote: loadingEditNote ?? this.loadingEditNote,
//     );
//   }

//   @override
//   List<Object?> get props => [editableNote, mode];
// }
