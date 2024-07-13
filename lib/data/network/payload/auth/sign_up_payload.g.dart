// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpPayload _$SignUpPayloadFromJson(Map<String, dynamic> json) =>
    SignUpPayload(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$SignUpPayloadToJson(SignUpPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
    };
