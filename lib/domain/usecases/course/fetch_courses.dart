import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/course/course_filters.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCourses implements UseCase<List<Course>, CourseFilters> {
  final CourseRepository courseRepository;

  const FetchCourses({required this.courseRepository});
  @override
  Future<Either<Failure, List<Course>>> call(CourseFilters filters) async {
    return await courseRepository.getCourses(filters);
  }
}
