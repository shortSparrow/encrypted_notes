part of 'note_bloc.dart';

class NoteState extends Equatable {
  final RequestStatus loadingLocalStatus;
  final RequestStatus loadingFromServerStatus;

  final List<Note> loadNotes;
  final List<Note> filteredNotes;

  const NoteState({
    this.loadingLocalStatus = RequestStatus.idle,
    this.loadingFromServerStatus = RequestStatus.idle,
    this.loadNotes = const [],
    this.filteredNotes = const [],
  });

  NoteState copyWith({
    RequestStatus? loadingLocalStatus,
    RequestStatus? loadingFromServerStatus,
    List<Note>? loadNotes,
    List<Note>? filteredNotes,
  }) {
    return NoteState(
      loadingLocalStatus: loadingLocalStatus ?? this.loadingLocalStatus,
      loadingFromServerStatus:
          loadingFromServerStatus ?? this.loadingFromServerStatus,
      loadNotes: loadNotes ?? this.loadNotes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
    );
  }

  @override
  List<Object> get props => [
        loadingLocalStatus,
        loadingFromServerStatus,
        loadNotes,
        filteredNotes,
      ];
}
