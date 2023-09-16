import 'package:cryptography/cryptography.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwk/jwk.dart';

part 'secret_shared_preferences_data.freezed.dart';
part 'secret_shared_preferences_data.g.dart';

@freezed
class SecretSharedPreferencesData with _$SecretSharedPreferencesData {
  factory SecretSharedPreferencesData({
    required Map<String, Object?>? deviceKeyPairForNotes,
    required Map<String, Object?>?  localSymmetricKey,
    required String? webBioId,
  }) = _SecretSharedPreferencesData;

  factory SecretSharedPreferencesData.fromJson(Map<String, dynamic> json) =>
      _$SecretSharedPreferencesDataFromJson(json);
}


// class SimpleKeyPairConverter
//     extends JsonConverter<SimpleKeyPair, Map<String, dynamic>> {
//   const SimpleKeyPairConverter();

//   @override
//   SimpleKeyPair fromJson(json) {
//     final keyPairJwk = Jwk.fromJson(json['keyPair']);
//     final SimpleKeyPair keyPair = keyPairJwk.toKeyPair() as SimpleKeyPair;

//     return keyPair;
//   }

//   @override
//   toJson(SimpleKeyPair object) async {
//     final keyPair = await Jwk.fromKeyPair(object);
//     return {
//       "keyPair": keyPair.toJson(),
//     };
//   }
// }

// class SecretKeyPairConverter
//     extends JsonConverter<SecretKey, Map<String, dynamic>> {
//   const SecretKeyPairConverter();

//   @override
//   SecretKey fromJson(json) {
//     final keyPairJwk = Jwk.fromJson(json['secretKey']);
//     final SecretKey secretKey = keyPairJwk.toSecretKey();

//     return secretKey;
//   }

//   @override
//   toJson(SecretKey object) async {
//     final secret = await Jwk.fromSecretKey(object,
//         cipher: AesCbc.with256bits(macAlgorithm: Hmac.sha256()));
//     return {
//       "secret": secret.toJson(),
//     };
//   }
// }

// @Freezed(toJson: true)
// class SecretSharedPreferencesData with _$SecretSharedPreferencesData {
//   factory SecretSharedPreferencesData({
//     @SimpleKeyPairConverter() required SimpleKeyPair deviceKeyPairForNotes,
//     @SecretKeyPairConverter() required SecretKey localSymmetricKey,
//   }) = _SecretSharedPreferencesData;

//   factory SecretSharedPreferencesData.fromJson(Map<String, dynamic> json) =>
//       _$SecretSharedPreferencesDataFromJson(json);
// }

