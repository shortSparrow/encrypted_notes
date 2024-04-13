abstract class BioAuthRepository {
  Future<bool> isWebBiometricSupported();
  Future<List<int>> registerWebBio(
    String randomStringFromServer,
    List<int> userIdArray,
    String userName,
  );
  Future<void> loginWebBio(
    String randomStringFromServer,
    dynamic rawId,
  );

  Future<bool> loginBio();
}
