part of 'modify_note_bloc.dart';

class ModifyNoteState extends Equatable {
  final Note? editableNote;
  final RequestStatus loadingEditNote;
  final ModifyNoteMode mode;
  const ModifyNoteState(
      {this.editableNote,
      this.mode = ModifyNoteMode.add,
      this.loadingEditNote = RequestStatus.idle});

  ModifyNoteState copyWith({
    Note? editableNote,
    ModifyNoteMode? mode,
    RequestStatus? loadingEditNote,
  }) {
    return ModifyNoteState(
      editableNote: editableNote ?? this.editableNote,
      mode: mode ?? this.mode,
      loadingEditNote: loadingEditNote ?? this.loadingEditNote,
    );
  }

  @override
  List<Object?> get props => [editableNote, mode];
}
