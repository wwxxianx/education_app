// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseVoucher _$CourseVoucherFromJson(Map<String, dynamic> json) =>
    CourseVoucher(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      expiredAt: json['expiredAt'] as String?,
      stock: (json['stock'] as num?)?.toInt(),
      afterDiscountValue: (json['afterDiscountValue'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      isVoucherAvailable: json['isVoucherAvailable'] as bool,
    );

Map<String, dynamic> _$CourseVoucherToJson(CourseVoucher instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'title': instance.title,
      'expiredAt': instance.expiredAt,
      'stock': instance.stock,
      'afterDiscountValue': instance.afterDiscountValue,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isVoucherAvailable': instance.isVoucherAvailable,
    };
