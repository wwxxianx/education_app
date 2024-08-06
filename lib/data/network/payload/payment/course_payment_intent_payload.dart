import 'package:json_annotation/json_annotation.dart';

part 'course_payment_intent_payload.g.dart';

@JsonSerializable()
class CoursePaymentIntentPayload {
  final String courseId;
  final String? appliedVoucherId;

  const CoursePaymentIntentPayload({
    required this.courseId,
    this.appliedVoucherId,
  });

  factory CoursePaymentIntentPayload.fromJson(Map<String, dynamic> json) =>
      _$CoursePaymentIntentPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CoursePaymentIntentPayloadToJson(this);
}
