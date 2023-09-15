import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';

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
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required MessageEncryptionUseCase messageEncryptionUseCase,
  })  : _modifyNoteLocalRepository = modifyNoteRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _notesMapper = notesMapper,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _messageEncryptionUseCase = messageEncryptionUseCase;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final NotesMapper _notesMapper;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final MessageEncryptionUseCase _messageEncryptionUseCase;

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
          await _secretSharedPreferencesRepository.getLocalSymmetricKey();
      final String decryptedMessage =
          await _messageEncryptionUseCase.decryptMessageForLocal(
        loadedNote.message,
        localSecretKey,
      );

      return right(
          _notesMapper.encryptedNoteToNote(loadedNote, decryptedMessage));
    } catch (e) {
      return left(GeneralFailure(message: "error"));
    }
  }
}
