part of 'modify_note_bloc.dart';

sealed class ModifyNoteEvent extends Equatable {
  const ModifyNoteEvent();

  @override
  List<Object> get props => [];
}

class SaveNote extends ModifyNoteEvent {
  final String message;
  final String title;

  const SaveNote({required this.message, required this.title});
}

class LoadNote extends ModifyNoteEvent {
  final int noteId;

  const LoadNote({required this.noteId});
}

class SetParams extends ModifyNoteEvent {
  final int? noteId;
  final ModifyNoteMode mode;

  const SetParams({required this.noteId, required this.mode});
}
