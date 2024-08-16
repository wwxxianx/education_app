import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/course/course_part_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateCoursePart implements UseCase<CoursePart, CreateCoursePartPayload> {
  final CourseRepository courseRepository;

  const CreateCoursePart({required this.courseRepository});

  @override
  Future<Either<Failure, CoursePart>> call(
      CreateCoursePartPayload payload) async {
    return await courseRepository.createCoursePart(payload);
  }
}
