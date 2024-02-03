// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncedDeviceImpl _$$SyncedDeviceImplFromJson(Map<String, dynamic> json) =>
    _$SyncedDeviceImpl(
      deviceId: json['deviceId'] as String,
      isSynced: json['isSynced'] as bool,
    );

Map<String, dynamic> _$$SyncedDeviceImplToJson(_$SyncedDeviceImpl instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'isSynced': instance.isSynced,
    };

_$NoteDataForServerEncryptedDataImpl
    _$$NoteDataForServerEncryptedDataImplFromJson(Map<String, dynamic> json) =>
        _$NoteDataForServerEncryptedDataImpl(
          title:
              EncryptedMessage.fromJson(json['title'] as Map<String, dynamic>),
          message: EncryptedMessage.fromJson(
              json['message'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$NoteDataForServerEncryptedDataImplToJson(
        _$NoteDataForServerEncryptedDataImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
    };

_$EncryptedMessageImpl _$$EncryptedMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$EncryptedMessageImpl(
      cipherText:
          (json['cipherText'] as List<dynamic>).map((e) => e as int).toList(),
      nonce: (json['nonce'] as List<dynamic>).map((e) => e as int).toList(),
      mac: (json['mac'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$EncryptedMessageImplToJson(
        _$EncryptedMessageImpl instance) =>
    <String, dynamic>{
      'cipherText': instance.cipherText,
      'nonce': instance.nonce,
      'mac': instance.mac,
    };
