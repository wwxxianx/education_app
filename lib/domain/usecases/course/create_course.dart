import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/course/course_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateCourse implements UseCase<Course, CreateCoursePayload> {
  final CourseRepository courseRepository;

  const CreateCourse({required this.courseRepository});

  @override
  Future<Either<Failure, Course>> call(CreateCoursePayload payload) async {
    return courseRepository.createCourse(payload);
  }
}
