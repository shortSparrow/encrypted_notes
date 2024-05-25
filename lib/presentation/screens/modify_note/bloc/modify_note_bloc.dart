import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/usecases/notes/add_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/delete_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/edit_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/load_notes_use_case.dart';
import 'package:encrypted_notes/presentation/core/widgets/snackbar.dart';
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
    if (snackbarMessage != null) {
      openSnackbar(
        title: snackbarMessage.title,
        message: snackbarMessage.message,
        contentType: snackbarMessage.contentType,
      );
    }
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
            openSnackbar(
              title: "Failed load note",
              message: "This note note exist",
              contentType: ContentType.warning,
            );
          case LoadByIdErrorCodes.unexpected:
            this.emit(state.copyWith(loadingEditNote: RequestStatus.failed));
            openSnackbar(
              title: "Failed load note",
              message: "Unexpected error happens",
              contentType: ContentType.failure,
            );
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
      value.fold(
        (error) {
          emit(state.copyWith(loadingSaveNote: RequestStatus.failed));
          switch (error.code) {
            case EditNoteLocalErrorCodes.unexpectedError:
            case EditNoteLocalErrorCodes.cantSaveNote:
              openSnackbar(
                title: "Failed edit note",
                message: "We can't save note locally",
                contentType: ContentType.failure,
              );
          }
        },
        (_) {
          emit(state.copyWith(
              loadingSaveNote: RequestStatus.success,
              editableNote: state.editableNote
                  ?.copyWith(message: message, title: title)));
        },
      );
    });

    response.remote.then((value) {
      value.fold(
        (error) {
          switch (error.code) {
            case EditNoteRemoteErrorCodes.syncedDevicesIsEmpty:
              openSnackbar(
                title: "Failed sync note",
                message: "There are not devices for synchronize note",
                contentType: ContentType.warning,
              );
            case EditNoteRemoteErrorCodes.network:
            case EditNoteRemoteErrorCodes.unexpected:
              openSnackbar(
                title: "Failed sync note",
                message: "We can't sync note with other your devices",
                contentType: ContentType.failure,
              );
          }
        },
        (_) {
          // TODO show checkmark on layout
      
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
          switch (error.code) {
            case LocalAddErrorCodes.noSymmetricKey:
            case LocalAddErrorCodes.unexpectedError:
              openSnackbar(
                title: "Fail save note",
                message: "Unexpected error happens",
                contentType: ContentType.failure,
              );
          }
        },
        (id) {
          // TODO I must revive note
        },
      );
    });

    response.remote.then((value) {
      value.fold(
        (error) {
          openSnackbar(
            title: "Failed sync note",
            message: "We can't send this note to server",
            contentType: ContentType.warning,
          );
          emit(
            state.copyWith(
              loadingSaveNote: RequestStatus.failed,
              mode: ModifyNoteMode.edit,
            ),
          );
        },
        (_) {
          // TODO show checkmark on layout
          emit(
            state.copyWith(
              loadingSaveNote: RequestStatus.success,
              mode: ModifyNoteMode.edit,
            ),
          );
        },
      );
    });
  }
}
