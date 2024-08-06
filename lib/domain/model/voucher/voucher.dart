import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher.g.dart';

@JsonSerializable()
class CourseVoucher extends Equatable {
  final String id;
  final String courseId;
  final String title;
  final String? expiredAt;
  final int? stock;
  final int afterDiscountValue;
  final String createdAt;
  final String updatedAt;
  final bool isVoucherAvailable;

  const CourseVoucher({
    required this.id,
    required this.courseId,
    required this.title,
    this.expiredAt,
    this.stock,
    required this.afterDiscountValue,
    required this.createdAt,
    required this.updatedAt,
    required this.isVoucherAvailable,
  });

  factory CourseVoucher.fromJson(Map<String, dynamic> json) =>
      _$CourseVoucherFromJson(json);

  Map<String, dynamic> toJson() => _$CourseVoucherToJson(this);

  String get displayVoucherPrice => "RM ${afterDiscountValue / 100}";
  
  @override
  List<Object?> get props => [
    id,
    courseId,
    title,
    expiredAt,
    stock,
    afterDiscountValue,
    createdAt,
    updatedAt,
    isVoucherAvailable,
  ];
}
