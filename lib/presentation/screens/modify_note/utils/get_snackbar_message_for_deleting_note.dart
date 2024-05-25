import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:encrypted_notes/domain/usecases/notes/delete_note_use_case.dart';
import 'package:encrypted_notes/presentation/core/widgets/snackbar.dart';

SnackbarProps? getSnackbarMessageForDeletingNote(
  DeleteNoteResponse deletionResult,
) {
  if (deletionResult.remote == null) {
    // note was present only locally
    return deletionResult.locally
        ? SnackbarProps(
            title: "Note was deleted locally",
            message: "This note was saved only for this device",
            contentType: ContentType.success,
          )
        : SnackbarProps(
            title: "Can't delete note locally",
            contentType: ContentType.failure,
          );
  }

  if (deletionResult.locally == true && deletionResult.remote == true) {
    return SnackbarProps(
      title: "Note deled success",
      contentType: ContentType.success,
    );
  }

  if (deletionResult.locally == true && deletionResult.remote == false) {
    return SnackbarProps(
      title: "Noe was deleted locally",
      message:
          "Note deleted only locally, some error happen on server, we try to delete note later autimcally",
      contentType: ContentType.warning,
    );
  }

  if (deletionResult.locally == false) {
    return deletionResult.remote == true
        ? SnackbarProps(
            title: "Note was deleted remotely",
            message: "Note was deleted remotely but not locally",
            contentType: ContentType.warning,
          )
        : SnackbarProps(
            title: "Can't delete note",
            message: "please try again",
            contentType: ContentType.failure,
          );
  }

  return null;
}
