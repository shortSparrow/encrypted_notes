import 'package:encrypted_notes/data/database/dao/notes_dao.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/models/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';

class ModifyNoteLocalRepositoryImpl extends ModifyNoteLocalRepository {
  final NotesDao notesDao;
  final NotesMapper notesMapper = NotesMapper();

  ModifyNoteLocalRepositoryImpl({required this.notesDao});

  @override
  Future<bool> addNote(NotesCompanion note) async {
    final noteId = await notesDao.addNote(note);

    return noteId != -1;
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
  Stream<List<Note>> getNotes() {
    return notesDao.getNotes().watch().map((event) =>
        event.map((noteDb) => notesMapper.dbNoteToNote(noteDb)).toList());
  }

  @override
  Future updateSyncingDeviceForNote(
    String syncedDevicesJson,
    int noteId,
  ) {
    return notesDao.updateSyncingDeviceForNote(syncedDevicesJson, noteId);
  }
}
