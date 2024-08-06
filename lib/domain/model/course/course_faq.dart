import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_faq.g.dart';

@JsonSerializable()
class CourseFAQ {
  final String id;
  final String courseId;
  final String question;
  final String answer;

  const CourseFAQ({
    required this.id,
    required this.courseId,
    required this.question,
    required this.answer,
  });

  factory CourseFAQ.fromJson(Map<String, dynamic> json) =>
      _$CourseFAQFromJson(json);

  Map<String, dynamic> toJson() => _$CourseFAQToJson(this);

  CourseFAQItem toCourseFAQItem() {
    return CourseFAQItem(id: id, question: question, answer: answer);
  }
}
