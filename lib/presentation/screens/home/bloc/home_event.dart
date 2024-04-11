part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class LoadNotes extends HomeEvent {
  const LoadNotes();
}

final class Logout extends HomeEvent {
  const Logout();
}

final class RefetchNotes extends HomeEvent {
  const RefetchNotes();
}

final class DeleteNote extends HomeEvent {
  final int noteId;
  const DeleteNote({required this.noteId});

  @override
  List<Object> get props => [noteId];
}

final class NavigateToAddNote extends HomeEvent {
  const NavigateToAddNote();
}

final class NavigateToEditNote extends HomeEvent {
  const NavigateToEditNote();
}
