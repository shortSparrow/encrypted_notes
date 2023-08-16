part of 'home_bloc.dart';

class HomeState extends Equatable {
  final RequestStatus loadingLocalStatus;
  final RequestStatus loadingFromServerStatus;

  final List<Note> loadNotes;
  final List<Note> filteredNotes;

  const HomeState({
    this.loadingLocalStatus = RequestStatus.idle,
    this.loadingFromServerStatus = RequestStatus.idle,
    this.loadNotes = const [],
    this.filteredNotes = const [],
  });

  HomeState copyWith({
    RequestStatus? loadingLocalStatus,
    RequestStatus? loadingFromServerStatus,
    List<Note>? loadNotes,
    List<Note>? filteredNotes,
  }) {
    return HomeState(
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
