import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCourse implements UseCase<Course, String> {
  final CourseRepository courseRepository;

  const FetchCourse({required this.courseRepository});
  @override
  Future<Either<Failure, Course>> call(String courseId) async {
    return await courseRepository.getCourse(courseId);
  }
}
