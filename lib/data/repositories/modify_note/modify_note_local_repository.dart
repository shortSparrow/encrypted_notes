import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/dao/notes_dao.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';

class ModifyNoteLocalRepositoryImpl extends ModifyNoteLocalRepository {
  final NotesDao notesDao;
  final NotesMapper notesMapper = NotesMapper();

  ModifyNoteLocalRepositoryImpl({required this.notesDao});

  @override
  Future<int> addNote(NotesCompanion note) async {
    final noteId = await notesDao.addNote(note);

    return noteId;
  }

  @override
  Future<bool> deleteNote(int noteId) async {
    final deletedNoteId = await notesDao.deleteNote(noteId);

    return deletedNoteId != -1;
  }

  @override
  Future<bool> editNote(NotesCompanion note) async {
    return notesDao.editNote(note);
  }

  @override
  Stream<List<EncryptedNote>> getNotes() {
    return notesDao.getNotes().watch().map((event) => event
        .map((noteDb) => notesMapper.dbNoteToEncryptedNote(noteDb))
        .toList());
  }

  @override
  Future updateSyncingDeviceForNote(
    String syncedDevicesJson,
    int noteId,
  ) {
    return notesDao.updateSyncingDeviceForNote(syncedDevicesJson, noteId);
  }

  @override
  Future<EncryptedNote?> getNoteById(int id) async {
    final result = await notesDao.getNoteById(id);
    if (result == null) {
      return null;
    }
    return notesMapper.dbNoteToEncryptedNote(result);
  }

  @override
  Future<EncryptedNote?> getNoteByGlobalId(String globalId) async {
    final result = await notesDao.getNoteByGlobalId(globalId);
    if (result == null) {
      return null;
    }
    return notesMapper.dbNoteToEncryptedNote(result);
  }

  @override
  Future<bool> addGlobalIdToNote(String noteGlobalId, int noteId) async {
    final result = await notesDao.addGlobalIdToNote(noteGlobalId, noteId);
    return result != -1;
  }

// TODO FIX
  @override
  Future replaceLocalNotesWithRemote(List<NotesCompanion> notes) async {
    await AppDatabase.getInstance().transaction(() async {
      for (var note in notes) {
        final noteGlobalId = note.noteGlobalId.value!; // fixme remove !
        final existingNote = await notesDao.getNoteByGlobalId(noteGlobalId);

        if (existingNote != null) {
          await notesDao.editNote(note.copyWith(id: Value(existingNote.id)));
        } else {
          await notesDao.addNote(note);
        }
      }
    });
  }

  @override
  Future<List<EncryptedNote>> getNotesWhichHasUnSyncedDevice() async {
    final list = await notesDao.getNotesWhichHasUnSyncedDevice();

    return list
        .map((noteDb) => notesMapper.dbNoteToEncryptedNote(noteDb))
        .toList();
  }
}
