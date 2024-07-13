
import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/domain/model/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserModel>> getUserProfile();
  
  Future<Either<Failure, UserModel>> updateUserProfile(
    UserProfilePayload payload,
  );
}
