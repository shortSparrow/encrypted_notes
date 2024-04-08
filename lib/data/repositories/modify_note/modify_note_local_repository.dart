import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/dao/failed_deleted_notes.dart';
import 'package:encrypted_notes/data/database/dao/notes_dao.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/models/failedDeletedNotes/failedDeletedNotes.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';

class ModifyNoteLocalRepositoryImpl extends ModifyNoteLocalRepository {
  final NotesDao notesDao;
  final FailedDeletedNotesDao failedDeletedNotesDao;
  final NotesMapper notesMapper = NotesMapper();

  ModifyNoteLocalRepositoryImpl({
    required this.notesDao,
    required this.failedDeletedNotesDao,
  });

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

  @override
  Future<int> addFailedRemoteDeletedNote(
      FailedDeletedNotesCompanion failedDeleted) {
    return failedDeletedNotesDao.addFailedRemoteDeletedNote(failedDeleted);
  }

  @override
  Future<List<FailedDeletedNote>> getAllFailedDeletedNote() async {
    final list = await failedDeletedNotesDao.getAllFailedDeletedNote();
    return list
        .map(
          (e) => FailedDeletedNote(
            id: e.id,
            noteId: e.noteId,
            noteGlobalId: e.noteGlobalId,
          ),
        )
        .toList();
  }

  @override
  Future removeFailedRemoteDeletedNote(List<String> globalNoteId) async {
    await failedDeletedNotesDao.deleteFailedRemoteDeletedNote(globalNoteId);
  }

  @override
  Future<bool> deleteNoteByGlobalId(String noteGlobalId) async {
    final id = await notesDao.deleteNoteByGlobalId(noteGlobalId);
    return id != -1;
  }
}
