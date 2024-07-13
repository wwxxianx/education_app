import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchAllCourseCategories
  implements UseCase<List<CourseCategory>, NoPayload> {
  final CourseRepository courseRepository;

  const FetchAllCourseCategories({required this.courseRepository});
  @override
  Future<Either<Failure, List<CourseCategory>>> call(NoPayload payload) async {
    return await courseRepository.getCourseCategories();
  }
}
