// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_shared_preferences_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SecretSharedPreferencesData _$$_SecretSharedPreferencesDataFromJson(
        Map<String, dynamic> json) =>
    _$_SecretSharedPreferencesData(
      deviceKeyPairForNotes:
          json['deviceKeyPairForNotes'] as Map<String, dynamic>?,
      localSymmetricKey: json['localSymmetricKey'] as Map<String, dynamic>?,
      webBioId: json['webBioId'] as String?,
    );

Map<String, dynamic> _$$_SecretSharedPreferencesDataToJson(
        _$_SecretSharedPreferencesData instance) =>
    <String, dynamic>{
      'deviceKeyPairForNotes': instance.deviceKeyPairForNotes,
      'localSymmetricKey': instance.localSymmetricKey,
      'webBioId': instance.webBioId,
    };
