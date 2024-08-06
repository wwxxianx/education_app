import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/payload/user/favourite_course_payload.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateFavouriteCourse
    implements UseCase<UserFavouriteCourse, UserFavouriteCoursePayload> {
  final UserRepository userRepository;

  UpdateFavouriteCourse({required this.userRepository});

  @override
  Future<Either<Failure, UserFavouriteCourse>> call(
      UserFavouriteCoursePayload payload) async {
    return await userRepository.updateUserFavouriteCourse(payload);
  }
}
