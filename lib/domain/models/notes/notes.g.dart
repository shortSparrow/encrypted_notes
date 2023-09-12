// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
