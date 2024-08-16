import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:education_app/common/constants/constants.dart';
import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/local/shared_preference.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/course_progress_payload.dart';
import 'package:education_app/data/network/payload/user/favourite_course_payload.dart';
import 'package:education_app/data/network/payload/user/instructor_profile_payload.dart';
import 'package:education_app/data/network/payload/user/learning_courses_filter.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/data/network/response/course/recommended_course.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/notification/notification.dart';
import 'package:education_app/domain/model/user/course_progress.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
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
        preferenceCourseCategoryIds: payload.favouriteCourseCategoryIds,
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

  @override
  Future<Either<Failure, InstructorProfile?>> getInstructorProfile(
      {required String userId}) async {
    try {
      final res = await api.getInstructorProfile(userId: userId);
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
  Future<Either<Failure, InstructorProfile>> createInstructorProfile(
      CreateInstructorProfilePayload payload) async {
    try {
      final res = await api.createInstructorProfile(
        fullName: payload.fullName,
        title: payload.title,
        profileImageFile: payload.profileImageFile,
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
  Future<Either<Failure, List<UserVoucher>>> getMyVouchers() async {
    try {
      final res = await api.getMyVouchers();
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
  Future<Either<Failure, List<UserCourse>?>> getUserLearningCourses() async {
    try {
      final res = await api.getUserLearningCourses();
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
  Future<Either<Failure, UserCourse?>> getUserLearningCourse(
      LearningCoursesFilter filter) async {
    try {
      final res = await api.getUserLearningCourses(courseId: filter.courseId);
      if (res == null) {
        return right(null);
      }
      return right(res.first);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<UserFavouriteCourse>>>
      getUserFavouriteCourses() async {
    try {
      final res = await api.getUserFavouriteCourses();
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
  Future<Either<Failure, UserFavouriteCourse>> updateUserFavouriteCourse(
      UserFavouriteCoursePayload payload) async {
    try {
      final res = await api.updateUserFavouriteCourse(payload);
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
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final res = await api.getNotifications();
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
  Future<Either<Failure, NotificationModel>> updateNotificationToRead(
      {required String notificationId}) async {
    try {
      final res =
          await api.updateNotificationToRead(notificationId: notificationId);
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
  Future<Either<Failure, CourseProgress>> getRecentCourseProgress() async {
    try {
      final cachedData =
          await sp.getData(Constants.sharedPreferencesKey.courseProgress);
      if (cachedData != null) {
        final res = CourseProgress.fromJson(jsonDecode(cachedData));
        return right(res);
      }
      final res = await api.getRecentCourseProgress();
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
  Future<Either<Failure, CourseProgress>> updateCourseProgress(
      CourseProgressPayload payload) async {
    try {
      final res = await api.updateCourseProgress(payload: payload);
      sp.saveData(
        key: Constants.sharedPreferencesKey.courseProgress,
        data: jsonEncode(res),
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
  Future<Either<Failure, List<Course>>>
      findRecommendedCourseFromPreference() async {
    try {
      final res = await api.findRecommendedCourseFromPreference();
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
  Future<Either<Failure, RecommendedCourseFromPurchaseHistory>>
      findRecommendedCourseFromPurchaseHistory() async {
    try {
      final res = await api.findRecommendedCourseFromPurchaseHistory();
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }
}
