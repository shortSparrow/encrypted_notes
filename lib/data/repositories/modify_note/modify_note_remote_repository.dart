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
  Future<List<AddNotesResponse>> addNotes(List<NoteForServer> data) async {
    // TODO implement
    final globalId = DateTime.timestamp().millisecond;
    await Future.delayed(const Duration(seconds: 1));
    return [
      AddNotesResponse(
        globalId: globalId,
        addNotesDeviceInfoResponse: [
          NotesDeviceInfoResponse(
            deviceId: "device_1",
            isSuccess: true,
            devicePublicKey:
                SimplePublicKey(publicBytes_1, type: KeyPairType.x25519),
          ),
          NotesDeviceInfoResponse(
            deviceId: "device_2",
            isSuccess: true,
            devicePublicKey:
                SimplePublicKey(publicBytes_2, type: KeyPairType.x25519),
          ),
          NotesDeviceInfoResponse(
            deviceId: "device_3",
            isSuccess: false,
            devicePublicKey:
                SimplePublicKey(publicBytes_3, type: KeyPairType.x25519),
          ),
        ],
      )
    ];
  }

  @override
  Future<List<EditNotesResponse>> editNotes(List<NoteForServer> data) async {
    // TODO implement
    await Future.delayed(const Duration(seconds: 1));
    return [
      EditNotesResponse(
        globalId: data[0].globalId as int,
        addNotesDeviceInfoResponse: [
          NotesDeviceInfoResponse(
            deviceId: "device_1",
            isSuccess: true,
            devicePublicKey:
                SimplePublicKey(publicBytes_1, type: KeyPairType.x25519),
          ),
          NotesDeviceInfoResponse(
            deviceId: "device_2",
            isSuccess: true,
            devicePublicKey:
                SimplePublicKey(publicBytes_2, type: KeyPairType.x25519),
          ),
          NotesDeviceInfoResponse(
            deviceId: "device_3",
            isSuccess: false,
            devicePublicKey:
                SimplePublicKey(publicBytes_3, type: KeyPairType.x25519),
          ),
        ],
      )
    ];
  }
}
