import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/extensions/encryption_key_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'secret_shared_preferences_data.freezed.dart';
part 'secret_shared_preferences_data.g.dart';

@freezed
class SecretSharedPreferencesData with _$SecretSharedPreferencesData {
  factory SecretSharedPreferencesData({
    required Map<String, Object?>? deviceKeyPairForNotes,
    required Map<String, Object?>? localSymmetricKey,
    required String? webBioId,
  }) = _SecretSharedPreferencesData;

  factory SecretSharedPreferencesData.fromJson(Map<String, dynamic> json) =>
      _$SecretSharedPreferencesDataFromJson(json);
}

class SimplePublicKeyConverter
    extends JsonConverter<SimplePublicKey, Map<String, dynamic>> {
  const SimplePublicKeyConverter();

  @override
  SimplePublicKey fromJson(json) {
    return SimplePublicKeyConvertorExtension.fromJson(json);
  }

  @override
  toJson(SimplePublicKey object) {
    return object.toJson();
  }
}
