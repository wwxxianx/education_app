// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseFAQ _$CourseFAQFromJson(Map<String, dynamic> json) => CourseFAQ(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$CourseFAQToJson(CourseFAQ instance) => <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'question': instance.question,
      'answer': instance.answer,
    };
