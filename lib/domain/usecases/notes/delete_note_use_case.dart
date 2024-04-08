import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

class DeleteNoteResponse {
  final bool? remote; // if null note exist only locally
  final bool locally;

  DeleteNoteResponse({required this.locally, required this.remote});
}

class DeleteNoteUseCase {
  final NotesMapper notesMapper = NotesMapper();

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;

  DeleteNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository;

// TODO А що станеться якщо на сервері видалилося, але сталася при парсингу даних
// TODO А що станеться якщо з сервера повернуласся 403 або 401, я тоді не повинен видаляти ж
// TODO А що станеться якщо сервер тимчасово бдке не прцювати - 500 поимлка
// TODO Відповідь - при заході в апку ми будемо наново слати запит на видалення усіх не видалених ноаток

  Future<DeleteNoteResponse> deleteNote(
      int noteId, String? globalNoteId) async {
    // note exist only on this device
    if (globalNoteId == null) {
      final isLocalSuccess = await _deleteLocally(noteId);
      return DeleteNoteResponse(locally: isLocalSuccess, remote: null);
    } else {
      return _deleteFromServerAndLocally(noteId, globalNoteId);
    }
  }

  Future<bool> _deleteLocally(int noteId) async {
    final isDeletionSuccess =
        await _modifyNoteLocalRepository.deleteNote(noteId);
    print("isDeletedLocally: $isDeletionSuccess");
    return isDeletionSuccess;
  }

  Future<DeleteNoteResponse> _deleteFromServerAndLocally(
    int noteId,
    String globalNoteId,
  ) async {
    try {
      final isRemoteDeletedSuccess =
          await _modifyNoteRemoteRepository.deleteNotes([globalNoteId]);
      if (isRemoteDeletedSuccess[0].isDeleteSuccess == true) {
        final isLocalSuccess = await _deleteLocally(noteId);
        return DeleteNoteResponse(locally: isLocalSuccess, remote: true);
      } else {
        final isLocalSuccess =
            await _handleRemovingLocally(noteId, globalNoteId);
        return DeleteNoteResponse(locally: isLocalSuccess, remote: false);
      }
    } on NetworkFailure {
      final isLocalSuccess = await _handleRemovingLocally(noteId, globalNoteId);
      return DeleteNoteResponse(locally: isLocalSuccess, remote: false);
    } catch (err) {
      print("_deleteFromServerAndLocally err: ${err}");
      return DeleteNoteResponse(locally: false, remote: false);
    }
  }

  Future<bool> _handleRemovingLocally(
    int noteId,
    String globalNoteId,
  ) async {
    final id = await _modifyNoteLocalRepository.addFailedRemoteDeletedNote(
      FailedDeletedNotesCompanion(
        noteId: Value(noteId),
        noteGlobalId: Value(globalNoteId),
      ),
    );

    if (id != -1) {
      final isDeletionSuccess = _deleteLocally(noteId);
      return isDeletionSuccess;
    }
    return false;
  }
}
