import 'dart:io';

import 'package:dio/dio.dart';
import 'package:education_app/common/constants/constants.dart';
import 'package:education_app/data/network/payload/auth/login_be_payload.dart';
import 'package:education_app/data/network/payload/auth/sign_up_payload.dart';
import 'package:education_app/data/network/response/auth/tokens_response.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/model/user.dart';
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
}
