import 'package:encrypted_notes/domain/usecases/notes/add_note_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'modify_note_event.dart';
part 'modify_note_state.dart';

class ModifyNoteBloc extends Bloc<ModifyNoteEvent, ModifyNoteState> {
  final AddNoteUseCase _addNoteUseCase;

  ModifyNoteBloc({
    required AddNoteUseCase addNoteUseCase,
  })  : _addNoteUseCase = addNoteUseCase,
        super(const ModifyNoteState()) {
    on<AddNewNote>(_onAddNote);
  }

  Future _onAddNote(
    AddNewNote event,
    Emitter<ModifyNoteState> emit,
  ) async {
    final response = _addNoteUseCase.addNote(
      message: event.message,
      deviceIdList: ["device_id_1", "device_id_2", "device_id_3"],
    );

    response.local.then((value) {
      value.fold(
        (l) {
          print("Error local: ${l}");
        },
        (r) {
          print("Success local: ${r}");
          if (this.isClosed) {
            // TODO show global error
          }
        },
      );
    });

    response.remote.then((value) {
      value.fold(
        (l) {
          print("Error remote: ${l}");
        },
        (r) {
          print("Success remote: ${r}");
        },
      );
    });
  }
}
