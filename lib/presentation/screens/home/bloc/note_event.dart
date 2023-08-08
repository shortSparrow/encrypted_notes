part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class LoadNotes extends NoteEvent {
  const LoadNotes();
}

final class RefetchNotes extends NoteEvent {
  const RefetchNotes();
}

final class DeleteNote extends NoteEvent {
  final int noteId;
  const DeleteNote({required this.noteId});

  @override
  List<Object> get props => [noteId];
}

final class NavigateToAddNote extends NoteEvent {
  const NavigateToAddNote();
}

final class NavigateToEditNote extends NoteEvent {
  const NavigateToEditNote();
}
