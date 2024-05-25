import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/usecases/auth/logout_usecase.dart';
import 'package:encrypted_notes/main.dart';
import 'package:encrypted_notes/presentation/core/widgets/snackbar.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/usecases/notes/load_notes_use_case.dart';
import 'package:go_router/go_router.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadNoteUseCase _loadNoteUseCase;
  final LogoutUsecase _logoutUsecase;

  HomeBloc({
    required LoadNoteUseCase loadNoteUseCase,
    required LogoutUsecase logoutUsecase,
  })  : _loadNoteUseCase = loadNoteUseCase,
        _logoutUsecase = logoutUsecase,
        super(const HomeState()) {
    on<LoadNotes>(_onLoadNotes);
    on<Logout>(_onLogout);
  }

  late StreamSubscription<List<EncryptedNote>> notesStream;

  dispose() {
    notesStream.cancel(); // stop listen and emit states if widget disposed
    close();
  }

  Future<void> _onLoadNotes(
    LoadNotes event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(loadingLocalStatus: RequestStatus.loading),
    );

    final response = _loadNoteUseCase.getNotes();
    response.loadingNotesFromServerStatus.handleError((error) {
      if (error is AppError) {
        openSnackbar(
          title: "Fail update notes",
          message: error.message,
          contentType: ContentType.failure,
        );
      }
    }).listen((status) {
      this.emit(state.copyWith(loadingFromServerStatus: status));
    });

    notesStream = response.localNotesStream.listen((notes) {
      this.emit(
        state.copyWith(
          loadingLocalStatus: RequestStatus.success,
          loadNotes: notes,
          filteredNotes: notes,
        ),
      );
    });
  }

  Future<void> _onLogout(
    Logout event,
    Emitter<HomeState> emit,
  ) async {
    await _logoutUsecase.logoutAndCleanUserData();
    MyApp.ctx?.go(AppScreens.sign_in.path);
  }
}
