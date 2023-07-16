import 'dart:js_interop';
import 'dart:js_util';

import 'js_interface.dart';

@JS('window.webauth.isAvailable')
external bool _isAvailable();

@JS('window.webauth.isLocalAuthenticator')
external dynamic _isLocalAuthenticator();

@JS('window.webauth.register')
external dynamic _registerBio(
  String randomStringFromServer,
  List<int> userIdArray,
  String userName,
);

@JS('window.webauth.login')
external dynamic _loginBio(
  String randomStringFromServer,
  dynamic rawId,
);

// var state = js.JsObject.fromBrowserObject(js.context['webauth']);
// bool isAuthAvailable = state.callMethod('isAvailable');

class Js implements BioAuthJsInterface {
  @override
  bool isAvailable() {
    return _isAvailable();
  }

  @override
  Future<bool> isLocalAuthenticator() async {
    final res = await promiseToFuture(_isLocalAuthenticator());
    return res;
  }

  @override
  Future<void> loginBio(String randomStringFromServer, rawId) async {
    return await promiseToFuture(_loginBio(randomStringFromServer, rawId));
  }

  @override
  Future<List<int>> registerBio(
    String randomStringFromServer,
    List<int> userIdArray,
    String userName,
  ) async {
    dynamic publicKeyCredential = await promiseToFuture(
      _registerBio(randomStringFromServer, userIdArray, userName),
    );

    final rawId = List<int>.from(publicKeyCredential);
    return rawId;
  }
}
