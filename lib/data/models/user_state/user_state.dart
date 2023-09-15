abstract class UserStateKeys {
  static const isLogged = 'isLogged';
}

class UserStateDb {
  bool isLogged;

  UserStateDb({
    required this.isLogged,
  });
}
