import 'package:encrypted_notes/domain/models/notes/notes.dart';

class NoteResponse {
  final String deviceId;
  final bool isSuccess;
  final String noteGlobalId;

  NoteResponse({
    required this.deviceId,
    required this.isSuccess,
    required this.noteGlobalId,
  });
}

class AddNotesResponse {
  final List<NoteResponse> notes;
  final String noteGlobalId;

  AddNotesResponse({
    required this.notes,
    required this.noteGlobalId,
  });
}

class EditNotesResponse {
  final List<NoteResponse> notes;
  final String noteGlobalId;

  EditNotesResponse({
    required this.notes,
    required this.noteGlobalId,
  });
}

class GetAllNotesResponse {
  final EncryptedMessage title;
  final EncryptedMessage message;
  final String createdAt;
  final String updatedAt;
  final String noteGlobalId;
  final String sendFromDeviceId; // send initially from device
  final List<String> syncedWithDevicesId; // send initially from device

  GetAllNotesResponse(
      {required this.title,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      required this.noteGlobalId,
      required this.sendFromDeviceId,
      required this.syncedWithDevicesId});
}

abstract class ModifyNoteRemoteRepository {
  Future<AddNotesResponse> addNote(List<NoteDataForServer> data);
  Future<EditNotesResponse> editNote(List<NoteDataForServer> data);
  Future<bool> deleteNote(int noteId);
  Future<List<GetAllNotesResponse>> getNotes();
}
