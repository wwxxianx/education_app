// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_payment_intent_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursePaymentIntentPayload _$CoursePaymentIntentPayloadFromJson(
        Map<String, dynamic> json) =>
    CoursePaymentIntentPayload(
      courseId: json['courseId'] as String,
      appliedVoucherId: json['appliedVoucherId'] as String?,
    );

Map<String, dynamic> _$CoursePaymentIntentPayloadToJson(
        CoursePaymentIntentPayload instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'appliedVoucherId': instance.appliedVoucherId,
    };
