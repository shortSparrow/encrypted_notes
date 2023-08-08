import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/comnied_local_remote_response.dart';
import 'package:encrypted_notes/domain/models/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

class AddNoteUseCase {
  AddNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;

  CombinedLocalRemoteResponse<Future<Either<Failure, bool>>,
      Future<Either<Failure, bool>>> addNote(NotesCompanion note) {
    return CombinedLocalRemoteResponse(
      local: _addNoteLocally(note),
      remote: _addNoteRemote(
        Note(
          message: note.message.value,
          createdAt: "111",
          updatedAt: "111",
          id: 333,
        ),
      ),
    );
  }

  Future<Either<Failure, bool>> _addNoteLocally(NotesCompanion note) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      await _modifyNoteLocalRepository.addNote(note);
      return right(true);
    } catch (e) {
      return left(GeneralFailure(message: "local error"));
    }
  }

  Future<Either<Failure, bool>> _addNoteRemote(Note note) async {
    try {
      await Future.delayed(Duration(seconds: 8));
      await _modifyNoteRemoteRepository.addNote(note);
      return right(true);
    } catch (e) {
      return left(GeneralFailure(message: "remote error"));
    }
  }
}
