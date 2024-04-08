
class DeleteNotesResponse {
  final String globalNoteId;
  final bool isDeleteSuccess;

  DeleteNotesResponse(
      {required this.globalNoteId, required this.isDeleteSuccess});
}

class GetRemovingNotesResponse {
  final String sendToDeviceId;
  final String noteGlobalId;

  GetRemovingNotesResponse({
    required this.sendToDeviceId,
    required this.noteGlobalId,
  });
}