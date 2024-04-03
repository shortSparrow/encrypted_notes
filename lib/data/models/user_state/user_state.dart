abstract class UserStateKeys {
  static const isLogged = 'isLogged';
  static const deviceId = 'deviceId';
}

class UserStateDb {
  bool isLogged;
  String deviceId;

  UserStateDb({
    required this.isLogged,
    required this.deviceId,
  });
}
