import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/usecases/notes/add_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/edit_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/load_notes_use_case.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/modify_note_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'modify_note_event.dart';
part 'modify_note_state.dart';

class ModifyNoteBloc extends Bloc<ModifyNoteEvent, ModifyNoteState> {
  final AddNoteUseCase _addNoteUseCase;
  final EditNoteUseCase _editNoteUseCase;
  final LoadNoteUseCase _loadNoteUseCase;

  ModifyNoteBloc({
    required AddNoteUseCase addNoteUseCase,
    required LoadNoteUseCase loadNoteUseCase,
    required EditNoteUseCase editNoteUseCase,
  })  : _addNoteUseCase = addNoteUseCase,
        _loadNoteUseCase = loadNoteUseCase,
        _editNoteUseCase = editNoteUseCase,
        super(const ModifyNoteState()) {
    on<SaveNote>(_onSaveNote);
    on<LoadNote>(_onLoadNote);
    on<SetParams>(_onSetParams);
  }

  Future _onSetParams(
    SetParams event,
    Emitter<ModifyNoteState> emit,
  ) async {
    emit(state.copyWith(mode: event.mode));
    if (event.mode == ModifyNoteMode.edit && event.noteId != null) {
      add(LoadNote(noteId: event.noteId as int));
    }
  }

  Future _onLoadNote(
    LoadNote event,
    Emitter<ModifyNoteState> emit,
  ) async {
    emit(state.copyWith(loadingEditNote: RequestStatus.loading));
    final response = await _loadNoteUseCase.loadNoteById(event.noteId);
    response.fold(
      (l) {
        print("error: ${l}");
        this.emit(state.copyWith(loadingEditNote: RequestStatus.failed));
      },
      (r) {
        this.emit(state.copyWith(
            editableNote: r, loadingEditNote: RequestStatus.success));
      },
    );
  }

  Future _onSaveNote(
    SaveNote event,
    Emitter<ModifyNoteState> emit,
  ) async {
    if (state.mode == ModifyNoteMode.add) {
      _addNote(message: event.message, title: event.title);
    } else if (state.mode == ModifyNoteMode.edit) {
      _editNote(event.message, event.title);
    }
  }

  Future _editNote(String message, String title) async {
    final response = await _editNoteUseCase.editNote(
      note: state.editableNote!.copyWith(
        message: message,
        title: title,
      ),
    );

    response.local.then((value) {
      value.fold(
        (l) {
          print("Error edit note local: ${l}");
        },
        (r) {
          print("Success edit note local: ${r}");
        },
      );
    });

    response.remote.then((value) {
      value.fold(
        (l) {
          print("Error edit note remote: ${l}");
        },
        (r) {
          print("Success edit note remote: ${r}");
        },
      );
    });
  }

  Future _addNote({required String message, required String title}) async {
    final response = await _addNoteUseCase.addNote(
      message: message,
      title: title.isEmpty ? "unknown" : title,
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
