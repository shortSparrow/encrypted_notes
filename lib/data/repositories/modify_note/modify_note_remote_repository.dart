import 'package:encrypted_notes/data/database/dao/notes_dao.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/models/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

class ModifyNoteRemoteRepositoryImpl extends ModifyNoteRemoteRepository {
  final NotesMapper notesMapper = NotesMapper();

  ModifyNoteRemoteRepositoryImpl();

  @override
  Future<bool> addNote(Note note) {
    // TODO: implement addNote
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteNote(int noteId) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<bool> editNote(Note note) {
    // TODO: implement editNote
    throw UnimplementedError();
  }

  @override
  Stream<List<Note>> getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<AddNotesResponse> addNotes(List<NoteDataForServer> data) async {
    // TODO implement
    final globalId = DateTime.timestamp().millisecond;
    await Future.delayed(const Duration(seconds: 1));
    return AddNotesResponse(
      globalId: globalId,
      addNotesDeviceInfoResponse: [
        AddNotesDeviceInfoResponse(deviceId: "device_id_1", isSuccess: true),
        AddNotesDeviceInfoResponse(deviceId: "device_id_2", isSuccess: true),
        AddNotesDeviceInfoResponse(deviceId: "device_id_3", isSuccess: false),
      ],
    );
  }
}
