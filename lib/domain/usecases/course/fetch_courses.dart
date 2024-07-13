import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCoursePayload {
  final List<String> categoryIds;
  final String? searchQuery;

  const FetchCoursePayload({
    this.categoryIds = const [],
    this.searchQuery,
  });
}

class FetchCourses implements UseCase<List<Course>, FetchCoursePayload> {
  final CourseRepository courseRepository;

  const FetchCourses({required this.courseRepository});
  @override
  Future<Either<Failure, List<Course>>> call(FetchCoursePayload payload) async {
    return await courseRepository.getCourses(payload);
  }
}
