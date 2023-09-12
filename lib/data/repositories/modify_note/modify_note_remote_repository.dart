import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_synced_device_list.dart';

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
        AddNotesDeviceInfoResponse(
          deviceId: "device_id_1",
          isSuccess: true,
          devicePublicKey: SimplePublicKey(publicBytes_1, type: KeyPairType.x25519),
        ),
        AddNotesDeviceInfoResponse(
          deviceId: "device_id_2",
          isSuccess: true,
          devicePublicKey: SimplePublicKey(publicBytes_2, type: KeyPairType.x25519),
        ),
        AddNotesDeviceInfoResponse(
          deviceId: "device_id_3",
          isSuccess: false,
          devicePublicKey: SimplePublicKey(publicBytes_3, type: KeyPairType.x25519),
        ),
      ],
    );
  }
}
