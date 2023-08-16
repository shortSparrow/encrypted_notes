part of 'modify_note_bloc.dart';

sealed class ModifyNoteEvent extends Equatable {
  const ModifyNoteEvent();

  @override
  List<Object> get props => [];
}

class AddNewNote extends ModifyNoteEvent{
  final String message;

  const AddNewNote({required this.message});
}