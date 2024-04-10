abstract class AppStateKeys {
  static const isLogged = 'isLogged';
}

class AppState {
  bool isLogged;

  AppState({
    required this.isLogged,
  });
}
