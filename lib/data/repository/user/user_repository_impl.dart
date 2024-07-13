import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:education_app/common/constants/constants.dart';
import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/local/shared_preference.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/domain/model/user.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient api;
  final MySharedPreference sp;

  UserRepositoryImpl({
    required this.api,
    required this.sp,
  });

  @override
  Future<Either<Failure, UserModel>> updateUserProfile(
      UserProfilePayload payload) async {
    try {
      final res = await api.updateUserProfile(
        fullName: payload.fullName,
        isOnboardingCompleted: payload.isOnBoardingCompleted,
        profileImageFile: payload.profileImageFile,
      );
      // Update Cached user
      sp.saveData(
        data: jsonEncode(res),
        key: Constants.sharedPreferencesKey.user,
      );
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
      // Get from local cache
      final cachedUser = await sp.getData(Constants.sharedPreferencesKey.user);
      if (cachedUser != null) {
        final user = UserModel.fromJson(jsonDecode(cachedUser));
        return right(user);
      }
      return left(Failure('Failed to get user details'));
      // Get from backend
      // final res = await api.getUserProfile();
      // return right(res);
    } catch (e) {
      return left(Failure('Failed to get user details'));
    }
  }

  
}
