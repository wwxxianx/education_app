import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/course/course_faq.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateCourseFAQ
    implements UseCase<List<CourseFAQ>, UpdateCourseFAQPayload> {
  final CourseRepository courseRepository;

  const UpdateCourseFAQ({required this.courseRepository});

  @override
  Future<Either<Failure, List<CourseFAQ>>> call(UpdateCourseFAQPayload payload) async {
    return await courseRepository.updateCourseFAQ(payload);
  }
}
