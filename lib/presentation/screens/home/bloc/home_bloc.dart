import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/usecases/notes/load_notes_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required LoadNoteUseCase loadNoteUseCase,
  })  : _loadNoteUseCase = loadNoteUseCase,
        super(const HomeState()) {
    print("init");
    on<LoadNotes>(_onLoadNotes);
  }
  final LoadNoteUseCase _loadNoteUseCase;

  late StreamSubscription<List<Note>> notesStream;

  dispose() {
    notesStream.cancel(); // stop listen and emit states if widget disposed
    close();
    print("dispose");
  }

  Future _onLoadNotes(
    LoadNotes event,
    Emitter<HomeState> emit,
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
      // print("note: ${notes}");
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
