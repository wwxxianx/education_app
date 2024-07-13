import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCourseLevels implements UseCase<List<CourseLevel>, NoPayload> {
  final CourseRepository courseRepository;

  const FetchCourseLevels({required this.courseRepository});

  @override
  Future<Either<Failure, List<CourseLevel>>> call(NoPayload payload) async {
    return await courseRepository.getCourseLevels();
  }
}
