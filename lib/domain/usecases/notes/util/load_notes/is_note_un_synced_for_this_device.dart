import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:collection/collection.dart';

bool isNoteUnSyncedForThisDevice(
  List<EncryptedNote> unSyncedNotesForThisDevice,
  String noteGlobalId,
) {
  final unSyncedNote = unSyncedNotesForThisDevice
      .firstWhereOrNull((element) => element.noteGlobalId == noteGlobalId);

  return unSyncedNote != null;
}
