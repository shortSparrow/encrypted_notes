import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/usecases/notes/encypt_note_use_case.dart';

class GetNotesResponse {
  final Stream<List<EncryptedNote>> notesStream;
  final Stream<RequestStatus> loadingNotesFromServerStatus;

  GetNotesResponse({
    required this.loadingNotesFromServerStatus,
    required this.notesStream,
  });
}

class LoadNoteUseCase {
  LoadNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required NotesMapper notesMapper,
    required EncryptNoteUseCase encryptNoteUseCase,
  })  : _modifyNoteLocalRepository = modifyNoteRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _notesMapper = notesMapper,
        _encryptNoteUseCase = encryptNoteUseCase;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final NotesMapper _notesMapper;
  final EncryptNoteUseCase _encryptNoteUseCase;

  GetNotesResponse getNotes() {
    return GetNotesResponse(
      notesStream: _modifyNoteLocalRepository.getNotes(),
      loadingNotesFromServerStatus: _getLoadingNotesFromServer(),
    );
  }

  Stream<RequestStatus> _getLoadingNotesFromServer() async* {
    yield RequestStatus.loading;
    try {
      final notesFromServer = await _modifyNoteRemoteRepository.getNotes();
      // TODO sync loaded notes with local

      yield RequestStatus.success;
    } catch (e) {
      yield RequestStatus.failed;
    }
  }

  Future<Either<Failure, Note>> loadNoteById(int noteId) async {
    try {
      final loadedNote = await _modifyNoteLocalRepository.getNoteById(noteId);
      if (loadedNote == null) {
        return left(GeneralFailure(message: "can't find note"));
      }

      final localSecretKey =
          await _encryptNoteUseCase.getLocalSymmetricSecretKey();
      final String decryptedMessage = await _encryptNoteUseCase.decryptLocal(
          loadedNote.message, localSecretKey);

      return right(
          _notesMapper.encryptedNoteToNote(loadedNote, decryptedMessage));
    } catch (e) {
      return left(GeneralFailure(message: "error"));
    }
  }
}
