import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:jwk/jwk.dart';

extension SimplePublicKeyConvertorExtension on SimplePublicKey {
  Map<String, Object?> toJson() {
    final SimplePublicKey devicePublicKey = this;

    final jwk = Jwk.fromPublicKey(devicePublicKey);
    return jwk.toJson();
  }

  String toJsonString() {
    final json = toJson();
    return jsonEncode(json);
  }

  static SimplePublicKey fromJson(Map<String, dynamic> json) {
    final jwk = Jwk.fromJson(json);

    return jwk.toPublicKey() as SimplePublicKey;
  }

  static fromJsonString(String jsonString) {
    return fromJson(jsonDecode(jsonString));
  }
}
