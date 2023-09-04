import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

import '../../failures/failures.dart';
import '../../models/combined_local_remote_response/combined_local_remote_response.dart';

class EditNoteUseCase {
  EditNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required NotesMapper notesMapper,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _notesMapper = notesMapper;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final NotesMapper _notesMapper;
}
