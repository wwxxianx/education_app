import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/local/shared_preference.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/create_course_payload.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:fpdart/src/either.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CourseRepositoryImpl implements CourseRepository {
  final SupabaseClient supabase;
  final MySharedPreference sp;
  final RestClient api;

  const CourseRepositoryImpl({
    required this.supabase,
    required this.sp,
    required this.api,
  });

  @override
  Future<Either<Failure, List<Course>>> getCourses(
      FetchCoursePayload payload) async {
    try {
      // final res = await supabase.from('courses').select("""
      //   id,
      //   title,
      //   description,
      //   topics,
      //   requirements,
      //   thumbnailUrl,
      //   price,
      //   reviewRating,
      //   categories(id,title),
      //   languages(id, language),
      //   course_instructors(id, fullName, title, createdAt),
      //   course_images(id, imageUrl),
      //   levels(id, level),
      //   createdAt,
      //   updatedAt
      // """);
      // final courses = res.map((course) => Course.fromJson(course)).toList();
      return right(Course.samples);
    } catch (e) {
      return left(Failure("Failed to fetch courses"));
    }
  }

  @override
  Future<Either<Failure, Course>> getCourse(String courseId) async {
    try {
      return right(Course.samples.first);
      final res = await supabase.from('courses').select("""
        id,
        title,
        description,
        topics,
        requirements,
        thumbnailUrl,
        price,
        reviewRating,
        categories(id,title),
        languages(id, language),
        course_instructors(id, fullName, profileImageUrl, title, createdAt),
        course_images(id, imageUrl),
        levels(id, level),
        course_sections(
          id, 
          title, 
          order, 
          course_parts(id, title, order, isVideoIncluded, resourceUrl)
        ),
        createdAt,
        updatedAt
      """).eq('id', courseId).maybeSingle();

      if (res == null) {
        // No data found
        return left(Failure('Failed to fetch course details'));
      }
      final course = Course.fromJson(res);
      return right(course);
    } catch (e) {
      return left(Failure("Failed to fetch course details"));
    }
  }

  @override
  Future<Either<Failure, Course>> createCourse(
      CreateCoursePayload payload) async {
    var logger = Logger();
    logger.d(payload);
    try {
      final res = await api.createCourse(
        categoryId: payload.categoryId,
        coursePartsTitle: payload.coursePartsTitle,
        description: payload.description,
        levelId: payload.levelId,
        requirements: payload.requirements,
        title: payload.title,
        topics: payload.topics,
        subcategoryIds: payload.subcategoryIds,
        languageId: payload.languageId,
        sectionOneTitle: payload.sectionOneTitle,
        price: payload.price,
        courseImages: payload.courseImages,
        courseVideo: payload.courseVideo,
        courseResourceFiles: payload.courseResourceFiles,
      );
      return right(res);
    } on Exception catch (e) {
      print('Repo error: ${e}');
      if (e is DioException) {
        logger.d(e.message);
        logger.d(e.type);
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<CourseCategory>>> getCourseCategories() async {
    try {
      final res = await api.getCourseCategories();
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ErrorHandler.dioException(error: e).errorMessage);
      }
      return left(ErrorHandler.otherException(error: e).errorMessage);
    }
  }

  @override
  Future<Either<Failure, List<CourseLevel>>> getCourseLevels() async {
    try {
      final res = await api.getCourseLevels();
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ErrorHandler.dioException(error: e).errorMessage);
      }
      return left(ErrorHandler.otherException(error: e).errorMessage);
    }
  }
}
