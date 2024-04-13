import 'package:encrypted_notes/domain/usecases/notes/delete_note_use_case.dart';

String getSnackbarMessageForDeletingNote(DeleteNoteResponse deletionResult) {
  if (deletionResult.remote == null) {
    // note was present only locally
    return deletionResult.locally
        ? "Note was deleted locally success"
        : "Can't delete note locally";
  }

  if (deletionResult.locally == true && deletionResult.remote == true) {
    return "Note deled success";
  }

  if (deletionResult.locally == true && deletionResult.remote == false) {
    return "Note deleted only locally, some error happen on server, we try to delete note later autimcally";
  }

  if (deletionResult.locally == false) {
    return deletionResult.remote == true
        ? "Note was deleted remotely but not locally"
        : "can't delete note, please try again";
  }

  return "";
}
