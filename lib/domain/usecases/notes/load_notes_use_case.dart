import 'dart:async';

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
  })  : _modifyNoteRepository = modifyNoteRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository;

  final ModifyNoteLocalRepository _modifyNoteRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;


  GetNotesResponse getNotes() {
    return GetNotesResponse(
      notesStream: _modifyNoteRepository.getNotes(),
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
}
