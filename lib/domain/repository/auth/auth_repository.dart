import 'package:education_app/common/error/failure.dart';
import 'package:education_app/domain/model/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserModel>> createUserWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  
  Future<void> signOut();
}
