import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

class GetNotesResponse {
  final Stream<List<Note>> notesStream;
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
  })  : _modifyNoteLocalRepository = modifyNoteRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;

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

      return right(loadedNote);
    } catch (e) {
      return left(GeneralFailure(message: "error"));
    }
  }
}
