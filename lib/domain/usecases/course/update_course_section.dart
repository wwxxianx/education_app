import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/course/course_section_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateCourseSection
    implements UseCase<CourseSection, UpdateCourseSectionPayload> {
  final CourseRepository courseRepository;

  const UpdateCourseSection({required this.courseRepository});

  @override
  Future<Either<Failure, CourseSection>> call(
      UpdateCourseSectionPayload payload) async {
    return await courseRepository.updateCourseSection(payload);
  }
}
