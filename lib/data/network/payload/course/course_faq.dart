import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';

class UpdateCourseFAQPayload {
  final String courseId;
  final List<CourseFAQItem> faqList;

  const UpdateCourseFAQPayload({
    required this.courseId,
    required this.faqList,
  });
}
