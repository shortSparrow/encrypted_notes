import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/usecases/notes/add_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/load_notes_use_case.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc({
    required LoadNoteUseCase loadNoteUseCase,
    required AddNoteUseCase addNoteUseCase,
  })  : _loadNoteUseCase = loadNoteUseCase,
        _addNoteUseCase = addNoteUseCase,
        super(const NoteState()) {
    print("init");
    on<LoadNotes>(_onLoadNotes);
    on<NavigateToAddNote>(_tempOnAddNote);
  }
  final LoadNoteUseCase _loadNoteUseCase;
  final AddNoteUseCase _addNoteUseCase;
  late StreamSubscription<List<Note>> notesStream;

  Future _tempOnAddNote(
    NavigateToAddNote event,
    Emitter<NoteState> emit,
  ) async {
    final response =
        _addNoteUseCase.addNote(const NotesCompanion(message: Value("2")));
    final local = await response.local;
    local.fold(
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
    final remote = await response.remote;
    remote.fold(
      (l) {
        print("Error remote: ${l}");
      },
      (r) {
        print("Success remote: ${r}");
      },
    );
  }

  dispose() {
    notesStream.cancel(); // stop listen and emit states if widget disposed
    close();
    print("dispose");
  }

  Future _onLoadNotes(
    LoadNotes event,
    Emitter<NoteState> emit,
  ) async {
    print("load notes");
    emit(state.copyWith(
      loadingLocalStatus: RequestStatus.loading,
    ));

    final response = _loadNoteUseCase.getNotes();
    response.loadingNotesFromServerStatus.listen((status) {
      this.emit(state.copyWith(loadingFromServerStatus: status));
      print("loading fromserver status: ${status}");
    });
    notesStream = response.notesStream.listen((notes) {
      print("note: ${notes}");
      this.emit(
        state.copyWith(
          loadingLocalStatus: RequestStatus.success,
          loadNotes: notes,
          filteredNotes: notes,
        ),
      );
    });
  }
}
