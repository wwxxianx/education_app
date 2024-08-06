import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCourseFAQ implements UseCase<List<CourseFAQ>, String> {
  final CourseRepository courseRepository;

  const FetchCourseFAQ({required this.courseRepository});

  @override
  Future<Either<Failure, List<CourseFAQ>>> call(String payload) async {
    return courseRepository.getCourseFAQ(payload);
  }
}
