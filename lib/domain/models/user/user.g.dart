// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      phone: json['phone'] as String,
      token: json['token'] as String,
      bioWedId:
          (json['bioWedId'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'token': instance.token,
      'bioWedId': instance.bioWedId,
    };
