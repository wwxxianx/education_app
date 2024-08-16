import 'package:json_annotation/json_annotation.dart';

part 'voucher_payload.g.dart';

@JsonSerializable()
class CreateVoucherPayload {
  final String title;
  final String courseId;
  final int afterDiscountValue;
  final DateTime? expiredAt;
  final int? stock;

  const CreateVoucherPayload(
      {required this.title,
      required this.courseId,
      required this.afterDiscountValue,
      this.expiredAt,
      this.stock,});

  factory CreateVoucherPayload.fromJson(Map<String, dynamic> json) =>
      _$CreateVoucherPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateVoucherPayloadToJson(this);

  CreateVoucherPayload copyWith({
    String? title,
    String? courseId,
    int? afterDiscountValue,
    DateTime? expiredAt,
    int? stock,
  }) {
    return CreateVoucherPayload(
      title: title ?? this.title,
      courseId: courseId ?? this.courseId,
      afterDiscountValue: afterDiscountValue ?? this.afterDiscountValue,
      expiredAt: expiredAt ?? this.expiredAt,
      stock: stock ?? this.stock,
    );
  }

  CreateVoucherPayload formatCurrency() {
    return copyWith(afterDiscountValue: afterDiscountValue * 100, );
  }
}
