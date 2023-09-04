import 'package:encrypted_notes/domain/models/notes/notes.dart';

class AddNotesDeviceInfoResponse {
  final String deviceId;
  final bool isSuccess;

  AddNotesDeviceInfoResponse({required this.deviceId, this.isSuccess = false});
}

class AddNotesResponse {
  final int globalId;
  final List<AddNotesDeviceInfoResponse> addNotesDeviceInfoResponse;

  AddNotesResponse({
    required this.globalId,
    required this.addNotesDeviceInfoResponse,
  });
}

abstract class ModifyNoteRemoteRepository {
  Future<bool> addNote(Note note);
  Future<AddNotesResponse> addNotes(List<NoteDataForServer> data);
  Future<bool> editNote(Note note);
  Future<bool> deleteNote(int noteId);
  Stream<List<Note>> getNotes();
}
