// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVoucher _$UserVoucherFromJson(Map<String, dynamic> json) => UserVoucher(
      userId: json['userId'] as String,
      voucherId: json['voucherId'] as String,
      voucher: json['voucher'] == null
          ? null
          : CourseVoucher.fromJson(json['voucher'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      usedAt: json['usedAt'] as String?,
      appliedCourseId: json['appliedCourseId'] as String?,
    );

Map<String, dynamic> _$UserVoucherToJson(UserVoucher instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'voucherId': instance.voucherId,
      'voucher': instance.voucher,
      'createdAt': instance.createdAt,
      'usedAt': instance.usedAt,
      'appliedCourseId': instance.appliedCourseId,
    };
