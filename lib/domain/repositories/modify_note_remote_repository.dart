import 'dart:ffi';

import 'package:encrypted_notes/domain/models/notes.dart';

class AddNotesResponse {
  final String deviceId;
  final bool isSuccess;

  AddNotesResponse({required this.deviceId, this.isSuccess = false});
}

abstract class ModifyNoteRemoteRepository {
  Future<bool> addNote(Note note);
  Future<List<AddNotesResponse>> addNotes(List<NoteDataForServer> data);
  Future<bool> editNote(Note note);
  Future<bool> deleteNote(int noteId);
  Stream<List<Note>> getNotes();
}
