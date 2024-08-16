import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/course/course_review_payload.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateCourseReview implements UseCase<UserReview, CourseReviewPayload> {
  final CourseRepository courseRepository;

  const CreateCourseReview({required this.courseRepository});

  @override
  Future<Either<Failure, UserReview>> call(CourseReviewPayload payload) async {
    return await courseRepository.createCourseReview(payload);
  }
}
