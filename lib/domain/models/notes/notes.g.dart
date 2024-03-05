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

_$NoteForServerImpl _$$NoteForServerImplFromJson(Map<String, dynamic> json) =>
    _$NoteForServerImpl(
      noteGlobalId: json['noteGlobalId'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => NoteDataForServer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NoteForServerImplToJson(_$NoteForServerImpl instance) =>
    <String, dynamic>{
      'noteGlobalId': instance.noteGlobalId,
      'data': instance.data,
    };

_$NoteDataForServerImpl _$$NoteDataForServerImplFromJson(
        Map<String, dynamic> json) =>
    _$NoteDataForServerImpl(
      metaData: NoteDataForServerMetaData.fromJson(
          json['metaData'] as Map<String, dynamic>),
      data: NoteDataForServerEncryptedData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NoteDataForServerImplToJson(
        _$NoteDataForServerImpl instance) =>
    <String, dynamic>{
      'metaData': instance.metaData,
      'data': instance.data,
    };

_$NoteDataForServerMetaDataImpl _$$NoteDataForServerMetaDataImplFromJson(
        Map<String, dynamic> json) =>
    _$NoteDataForServerMetaDataImpl(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      sendToDeviceId: json['sendToDeviceId'] as String,
      noteGlobalId: json['noteGlobalId'] as String?,
    );

Map<String, dynamic> _$$NoteDataForServerMetaDataImplToJson(
        _$NoteDataForServerMetaDataImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'sendToDeviceId': instance.sendToDeviceId,
      'noteGlobalId': instance.noteGlobalId,
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
