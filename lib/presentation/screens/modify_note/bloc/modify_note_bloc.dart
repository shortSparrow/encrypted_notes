import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/usecases/notes/add_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/delete_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/edit_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/load_notes_use_case.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/bloc/modify_note_state.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/modify_note_screen.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/utils/get_snackbar_message_for_deleting_note.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'modify_note_event.dart';

class ModifyNoteBloc extends Bloc<ModifyNoteEvent, ModifyNoteState> {
  final AddNoteUseCase _addNoteUseCase;
  final EditNoteUseCase _editNoteUseCase;
  final LoadNoteUseCase _loadNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  ModifyNoteBloc({
    required AddNoteUseCase addNoteUseCase,
    required LoadNoteUseCase loadNoteUseCase,
    required EditNoteUseCase editNoteUseCase,
    required DeleteNoteUseCase deleteNoteUseCase,
  })  : _addNoteUseCase = addNoteUseCase,
        _loadNoteUseCase = loadNoteUseCase,
        _editNoteUseCase = editNoteUseCase,
        _deleteNoteUseCase = deleteNoteUseCase,
        super(const ModifyNoteState()) {
    on<SaveNote>(_onSaveNote);
    on<LoadNote>(_onLoadNote);
    on<SetParams>(_onSetParams);
    on<OnDeleteNote>(_onDeleteNote);
  }

  Future _onDeleteNote(
    OnDeleteNote event,
    Emitter<ModifyNoteState> emit,
  ) async {
    final deletionResult = await _deleteNoteUseCase.deleteNote(
        state.editableNote!.id, state.editableNote?.noteGlobalId);

    final snackbarMessage = getSnackbarMessageForDeletingNote(deletionResult);
    // TODO show snackbar
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
      (error) {
        switch (error.code) {
          case LoadByIdErrorCodes.noteNotExist:
          case LoadByIdErrorCodes.unexpectedError:
            this.emit(state.copyWith(loadingEditNote: RequestStatus.failed));
        }
      },
      (decryptedNote) {
        this.emit(
          state.copyWith(
            editableNote: decryptedNote,
            loadingEditNote: RequestStatus.success,
          ),
        );
      },
    );
  }

  Future _onSaveNote(
    SaveNote event,
    Emitter<ModifyNoteState> emit,
  ) async {
    this.emit(state.copyWith(loadingSaveNote: RequestStatus.loading));

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
      emit(
        state.copyWith(
          loadingSaveNote: RequestStatus.success,
          mode: ModifyNoteMode.edit,
        ),
      );
      value.fold(
        (error) {
          print("Error edit note local: ${error}");
          // TODO show snackbar failed save locally
        },
        (_) {
    
        },
      );
    });
    response.remote.then((value) {
      value.fold(
        (error) {
          print("Error edit note remote: ${error}");
          // TODO show snackbar
        },
        (_) {
          print("Success edit note remote:");
          // TODO show snackbar
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
        (error) {
          print("Error local: ${error}");
        },
        (id) {
          print("Success local: ${id}");
          //  TODO set editablde note or go from screen
          if (this.isClosed) {
            // TODO show global error
          }
        },
      );
    });

    response.remote.then((value) {
      value.fold(
        (error) {
          print("Error remote: ${error}");
        },
        (_) {
          //  TODO set editablde note or go from screen
          print("Success remote:");
        },
      );
    });

    emit(
      state.copyWith(
        loadingSaveNote: RequestStatus.success,
        mode: ModifyNoteMode.edit,
      ),
    ); // TODO fix it, may be not success
  }
}
