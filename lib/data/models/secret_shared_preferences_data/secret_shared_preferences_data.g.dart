// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_shared_preferences_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecretSharedPreferencesDataImpl _$$SecretSharedPreferencesDataImplFromJson(
        Map<String, dynamic> json) =>
    _$SecretSharedPreferencesDataImpl(
      deviceKeyPairForNotes:
          json['deviceKeyPairForNotes'] as Map<String, dynamic>?,
      localSymmetricKey: json['localSymmetricKey'] as Map<String, dynamic>?,
      webBioId: json['webBioId'] as String?,
    );

Map<String, dynamic> _$$SecretSharedPreferencesDataImplToJson(
        _$SecretSharedPreferencesDataImpl instance) =>
    <String, dynamic>{
      'deviceKeyPairForNotes': instance.deviceKeyPairForNotes,
      'localSymmetricKey': instance.localSymmetricKey,
      'webBioId': instance.webBioId,
    };
