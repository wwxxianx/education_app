import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/network/payload/user/course_progress_payload.dart';
import 'package:education_app/data/network/payload/user/favourite_course_payload.dart';
import 'package:education_app/data/network/payload/user/instructor_profile_payload.dart';
import 'package:education_app/data/network/payload/user/learning_courses_filter.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/data/network/response/course/recommended_course.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/notification/notification.dart';
import 'package:education_app/domain/model/user/course_progress.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserModel>> getUserProfile();

  Future<Either<Failure, UserModel>> updateUserProfile(
    UserProfilePayload payload,
  );

  // Instructor profile
  Future<Either<Failure, InstructorProfile?>> getInstructorProfile(
      {required String userId});

  Future<Either<Failure, InstructorProfile>> createInstructorProfile(
      CreateInstructorProfilePayload payload);

  // Voucher
  Future<Either<Failure, List<UserVoucher>>> getMyVouchers();

  // Participated course
  Future<Either<Failure, List<UserCourse>?>> getUserLearningCourses();
  Future<Either<Failure, UserCourse?>> getUserLearningCourse(
      LearningCoursesFilter filter);

  // Favourite
  Future<Either<Failure, List<UserFavouriteCourse>>> getUserFavouriteCourses();
  Future<Either<Failure, UserFavouriteCourse>> updateUserFavouriteCourse(
      UserFavouriteCoursePayload payload);

  // Notification
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, NotificationModel>> updateNotificationToRead(
      {required String notificationId});

  // Courser progress
  Future<Either<Failure, CourseProgress>> getRecentCourseProgress();
  Future<Either<Failure, CourseProgress>> updateCourseProgress(CourseProgressPayload payload);

  // Recommended course
  Future<Either<Failure, List<Course>>> findRecommendedCourseFromPreference();
  Future<Either<Failure, RecommendedCourseFromPurchaseHistory>> findRecommendedCourseFromPurchaseHistory();
}
