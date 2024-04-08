import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

class DeleteFailedRemoteDeletedNotesUseCase {
  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;

  DeleteFailedRemoteDeletedNotesUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository;

  Future deleteAllFailedDeletedNotes() async {
    final failedDeletedNotes =
        await _modifyNoteLocalRepository.getAllFailedDeletedNote();

    final List<String> globalIds = failedDeletedNotes
        .where((element) => element.noteGlobalId != null)
        .map((e) => e.noteGlobalId!)
        .toList();

    if (globalIds.isEmpty) return;

    final res = await _modifyNoteRemoteRepository.deleteNotes(globalIds);
    final remoteDeletedSuccessIds = res
        .where((element) => element.isDeleteSuccess == true)
        .map((e) => e.globalNoteId)
        .toList();

    await _modifyNoteLocalRepository
        .removeFailedRemoteDeletedNote(remoteDeletedSuccessIds);
  }
}
