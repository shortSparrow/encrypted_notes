abstract class BioAuthJsInterface {
  bool isAvailable();
  Future<bool> isLocalAuthenticator();
  Future<List<int>> registerBio(
    String randomStringFromServer,
    List<int> userIdArray,
    String userName,
  );
  Future<void> loginBio(
    String randomStringFromServer,
    dynamic rawId,
  );
}