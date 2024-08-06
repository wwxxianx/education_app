import 'dart:io';

import 'package:dio/dio.dart';
import 'package:education_app/common/constants/constants.dart';
import 'package:education_app/data/network/payload/auth/login_be_payload.dart';
import 'package:education_app/data/network/payload/auth/sign_up_payload.dart';
import 'package:education_app/data/network/payload/payment/course_payment_intent_payload.dart';
import 'package:education_app/data/network/payload/stripe/update_connect_account_payload.dart';
import 'package:education_app/data/network/payload/user/favourite_course_payload.dart';
import 'package:education_app/data/network/payload/voucher/claim_voucher_payload.dart';
import 'package:education_app/data/network/payload/voucher/voucher_payload.dart';
import 'package:education_app/data/network/response/auth/tokens_response.dart';
import 'package:education_app/data/network/response/payment/payment_intent_response.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/model/notification/notification.dart';
import 'package:education_app/domain/model/stripe/connect_account_response.dart';
import 'package:education_app/domain/model/stripe/stripe_account.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:retrofit/http.dart';

part 'retrofit_api.g.dart';

@RestApi(baseUrl: Constants.apiUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  // Auth
  @POST("auth/sign-up")
  Future<TokensResponse> signUp(@Body() SignUpPayload signUpPayload);

  @POST("auth/sign-in")
  Future<UserModelWithAccessToken> signIn(@Body() LoginBEPayload payload);

  @POST("auth/refresh")
  Future<TokensResponse> getRefreshToken();

  // User
  @PATCH("users")
  @MultiPart()
  Future<UserModel> updateUserProfile({
    @Part(name: "fullName") String? fullName,
    @Part(name: "profileImageFile") File? profileImageFile,
    @Part(name: "isOnboardingCompleted") bool? isOnboardingCompleted,
  });

  @GET("users/{id}/instructor-profile")
  Future<InstructorProfile?> getInstructorProfile(
      {@Path("id") required String userId});

  @POST("users/instructor-profile")
  @MultiPart()
  Future<InstructorProfile> createInstructorProfile({
    @Part(name: "fullName") required String fullName,
    @Part(name: "title") required String title,
    @Part(name: "profileImageFile") File? profileImageFile,
  });

  @GET("users/courses")
  Future<List<UserCourse>?> getUserLearningCourses({
    @Query("courseId") String? courseId,
  });

  // Payment
  @POST("payment/connect-account")
  Future<ConnectAccountResponse> connectStripeAccount();

  @POST("payment/onboard-update")
  Future<ConnectAccountResponse> updateConnectAccount();

  @GET("payment/connected-account")
  Future<StripeAccount?> getConnectedAccount();

  @POST("payment/intent/course")
  Future<PaymentIntentResponse> createCoursePaymentIntent(
      @Body() CoursePaymentIntentPayload payload);

  // Constants
  @GET("languages")
  Future<List<Language>> getLanguages();

  @GET("course-levels")
  Future<List<CourseLevel>> getCourseLevels();

  @GET("course-categories")
  Future<List<CourseCategory>> getCourseCategories();

  // Course
  @POST("courses")
  @MultiPart()
  Future<Course> createCourse({
    @Part(name: "categoryId") required String categoryId,
    @Part(name: "coursePartsTitle") required List<String> coursePartsTitle,
    @Part(name: "description") required String description,
    @Part(name: "levelId") required String levelId,
    @Part(name: "requirements") required List<String> requirements,
    @Part(name: "title") required String title,
    @Part(name: "topics") required List<String> topics,
    @Part(name: "subcategoryIds") required List<String> subcategoryIds,
    @Part(name: "languageIds") required String languageId,
    @Part(name: "sectionOneTitle") required String sectionOneTitle,
    @Part(name: "price") double? price,
    @Part(name: "courseImages") required List<File> courseImages,
    @Part(name: "courseResourceFiles") required List<File> courseResourceFiles,
    @Part(name: "courseVideo") File? courseVideo,
  });

  @PATCH("courses/{id}")
  @MultiPart()
  Future<Course> updateCourse({
    @Path("id") required String courseId,
    @Part(name: "categoryId") String? categoryId,
    @Part(name: "description") String? description,
    @Part(name: "levelId") String? levelId,
    @Part(name: "requirements") List<String>? requirements,
    @Part(name: "title") String? title,
    @Part(name: "topics") List<String>? topics,
    @Part(name: "subcategoryIds") List<String>? subcategoryIds,
    @Part(name: "languageIds") String? languageId,
    @Part(name: "price") double? price,
    @Part(name: "courseImages") List<File>? courseImages,
    @Part(name: "courseVideo") File? courseVideo,
    @Part(name: "status") String? status,
  });

  @GET("courses")
  Future<List<Course>> getCourses({
    @Query('instructorId') String? instructorId,
    @Query('categoryIds') List<String> categoryIds = const [],
    @Query('subcategoryIds') List<String> subcategoryIds = const [],
    @Query('isFree') bool? isFree,
    @Query('levelIds') List<String> levelIds = const [],
    @Query('languageIds') List<String> languageIds = const [],
    @Query('searchQuery') String? searchQuery,
    @Query('status') CoursePublishStatus? status,
  });

  @GET("courses/{id}")
  Future<Course> getCourse({
    @Path("id") required String courseId,
  });

  @GET("courses/{id}/faq")
  Future<List<CourseFAQ>> getCourseFAQ({
    @Path("id") required String courseId,
  });

  @PATCH("courses/{id}/faq")
  Future<List<CourseFAQ>> updateCourseFAQ({
    @Path("id") required String courseId,
    @Body() List<CourseFAQItem> faqList = const [],
  });

  // Voucher
  @POST("courses/vouchers")
  Future<CourseVoucher> createVoucher(@Body() CreateVoucherPayload payload);

  @GET("courses/{id}/vouchers")
  Future<List<CourseVoucher>> getCourseVouchers(
      {@Path("id") required String courseId});

  @GET("user-vouchers")
  Future<List<UserVoucher>> getMyVouchers();

  @POST("user-vouchers")
  Future<UserVoucher> claimVoucher(@Body() ClaimVoucherPayload payload);

  // User Favourite Course
  @GET("users/favourite-courses")
  Future<List<UserFavouriteCourse>> getUserFavouriteCourses();

  @POST("users/favourite-courses")
  Future<UserFavouriteCourse> updateUserFavouriteCourse(
      @Body() UserFavouriteCoursePayload payload);

  // Notification
  @GET("users/notifications")
  Future<List<NotificationModel>> getNotifications();

  @PATCH("users/notifications/{id}")
  Future<NotificationModel> updateNotificationToRead(
      {@Path("id") required String notificationId});
}
