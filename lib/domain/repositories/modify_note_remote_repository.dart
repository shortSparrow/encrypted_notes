import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

class NotesDeviceInfoResponse {
  final String deviceId;
  final bool isSuccess;
  final SimplePublicKey devicePublicKey;

  NotesDeviceInfoResponse({
    required this.deviceId,
    this.isSuccess = false,
    required this.devicePublicKey,
  });
}

class NotesResponse {
  final String noteGlobalId;
  final List<NotesDeviceInfoResponse> addNotesDeviceInfoResponse;

  NotesResponse({
    required this.noteGlobalId,
    required this.addNotesDeviceInfoResponse,
  });
}

class AddNotesResponse extends NotesResponse {
  AddNotesResponse({
    required super.noteGlobalId,
    required super.addNotesDeviceInfoResponse,
  });
}

class EditNotesResponse extends NotesResponse {
  EditNotesResponse({
    required super.noteGlobalId,
    required super.addNotesDeviceInfoResponse,
  });
}

abstract class ModifyNoteRemoteRepository {
  Future<bool> addNote(Note note);
  Future<List<AddNotesResponse>> addNotes(List<NoteForServer> data);
  Future<List<EditNotesResponse>> editNotes(List<NoteForServer> data);
  Future<bool> editNote(Note note);
  Future<bool> deleteNote(int noteId);
  Stream<List<Note>> getNotes();
}
