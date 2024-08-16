import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCourseReviews implements UseCase<List<UserReview>, String> {
  final CourseRepository courseRepository;

  const FetchCourseReviews({required this.courseRepository});

  @override
  Future<Either<Failure, List<UserReview>>> call(String payload) async {
    return await courseRepository.getCourseReviews(payload);
  }
}
