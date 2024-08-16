import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/response/course/recommended_course.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchPurchaseRecommendedCourse
    implements UseCase<RecommendedCourseFromPurchaseHistory, NoPayload> {
  final UserRepository userRepository;

  const FetchPurchaseRecommendedCourse({required this.userRepository});

  @override
  Future<Either<Failure, RecommendedCourseFromPurchaseHistory>> call(NoPayload payload) async {
    return await userRepository.findRecommendedCourseFromPurchaseHistory();
  }
}
