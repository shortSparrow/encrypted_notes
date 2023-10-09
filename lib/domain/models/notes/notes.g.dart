// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SyncedDevice _$$_SyncedDeviceFromJson(Map<String, dynamic> json) =>
    _$_SyncedDevice(
      deviceId: json['deviceId'] as String,
      isSynced: json['isSynced'] as bool,
    );

Map<String, dynamic> _$$_SyncedDeviceToJson(_$_SyncedDevice instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'isSynced': instance.isSynced,
    };

_$_NoteDataForServerEncryptedData _$$_NoteDataForServerEncryptedDataFromJson(
        Map<String, dynamic> json) =>
    _$_NoteDataForServerEncryptedData(
      title: EncryptedMessage.fromJson(json['title'] as Map<String, dynamic>),
      message:
          EncryptedMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NoteDataForServerEncryptedDataToJson(
        _$_NoteDataForServerEncryptedData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
    };

_$_EncryptedMessage _$$_EncryptedMessageFromJson(Map<String, dynamic> json) =>
    _$_EncryptedMessage(
      cipherText:
          (json['cipherText'] as List<dynamic>).map((e) => e as int).toList(),
      nonce: (json['nonce'] as List<dynamic>).map((e) => e as int).toList(),
      mac: (json['mac'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$_EncryptedMessageToJson(_$_EncryptedMessage instance) =>
    <String, dynamic>{
      'cipherText': instance.cipherText,
      'nonce': instance.nonce,
      'mac': instance.mac,
    };
