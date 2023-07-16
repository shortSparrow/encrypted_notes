import 'js_interface.dart';

// needed for importing when target not web and don't get error compilation
class Js implements BioAuthJsInterface {
  @override
  bool isAvailable() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isLocalAuthenticator() {
    throw UnimplementedError();
  }

  @override
  Future<void> loginBio(String randomStringFromServer, rawId) {
    throw UnimplementedError();
  }

  @override
  Future<List<int>> registerBio(
      String randomStringFromServer, List<int> userIdArray, String userName) {
    throw UnimplementedError();
  }
}
