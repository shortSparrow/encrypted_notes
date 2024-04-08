import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/modify_note_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_note_state.freezed.dart';

@freezed
class ModifyNoteState with _$ModifyNoteState {
  const factory ModifyNoteState({
    Note? editableNote,
    @Default(RequestStatus.idle) RequestStatus loadingEditNote,
    @Default(RequestStatus.idle) RequestStatus loadingSaveNote,
    @Default(ModifyNoteMode.add) ModifyNoteMode mode,
  }) = _ModifyNoteState;
}
