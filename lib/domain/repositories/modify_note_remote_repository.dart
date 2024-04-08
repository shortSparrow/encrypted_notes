import 'package:encrypted_notes/domain/models/notes/modify_notes.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

abstract class ModifyNoteRemoteRepository {
  Future<AddNotesResponse> addNote(List<NoteDataForServer> data);
  Future<EditNotesResponse> editNote(List<NoteDataForServer> data);
  Future<List<DeleteNotesResponse>> deleteNotes(List<String> globalNoteIds);
  Future<List<GetAllNotesResponse>> getNotes();
  Future<List<GetRemovingNotesResponse>> getRemovingNotes();
  Future<void> confirmRemovingNoteFromDevice(List<String> globalNoteIds);
}
