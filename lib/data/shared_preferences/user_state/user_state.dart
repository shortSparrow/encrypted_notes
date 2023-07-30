const userStateBox = 'userStateBox';

abstract class UserStateKeys {
  static const isLogged = 'isLogged';
  static const bioWebId = 'bioWebId';
}

class UserStateDb {
  bool isLogged;
  List<int>? bioWebId;

  UserStateDb({required this.isLogged, required this.bioWebId});
}
