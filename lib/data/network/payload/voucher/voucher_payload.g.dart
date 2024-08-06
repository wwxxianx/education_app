// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateVoucherPayload _$CreateVoucherPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateVoucherPayload(
      title: json['title'] as String,
      courseId: json['courseId'] as String,
      afterDiscountValue: (json['afterDiscountValue'] as num).toInt(),
      expiredAt: json['expiredAt'] == null
          ? null
          : DateTime.parse(json['expiredAt'] as String),
      stock: (json['stock'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateVoucherPayloadToJson(
        CreateVoucherPayload instance) =>
    <String, dynamic>{
      'title': instance.title,
      'courseId': instance.courseId,
      'afterDiscountValue': instance.afterDiscountValue,
      'expiredAt': instance.expiredAt?.toIso8601String(),
      'stock': instance.stock,
    };
