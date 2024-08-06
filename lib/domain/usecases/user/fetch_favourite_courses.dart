import 'package:education_app/common/error/failure.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchFavouriteCourses
    implements UseCase<List<UserFavouriteCourse>, NoPayload> {
  final UserRepository userRepository;

  FetchFavouriteCourses({required this.userRepository});

  @override
  Future<Either<Failure, List<UserFavouriteCourse>>> call(
      NoPayload payload) async {
    return await userRepository.getUserFavouriteCourses();
  }
}
