import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_voucher.g.dart';

@JsonSerializable()
class UserVoucher extends Equatable {
  final String userId;
  final String voucherId;
  final CourseVoucher? voucher;
  final String createdAt;
  final String? usedAt;
  final String? appliedCourseId;

  const UserVoucher({
    required this.userId,
    required this.voucherId,
    this.voucher,
    required this.createdAt,
    this.usedAt,
    this.appliedCourseId,
  });

  factory UserVoucher.fromJson(Map<String, dynamic> json) =>
      _$UserVoucherFromJson(json);

  Map<String, dynamic> toJson() => _$UserVoucherToJson(this);
  
  @override
  List<Object?> get props => [
    userId,
    voucherId,
    voucher,
    createdAt,
    usedAt,
  ];

  @override
  bool get stringify => true;
}
