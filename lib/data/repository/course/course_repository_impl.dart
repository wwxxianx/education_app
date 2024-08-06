import 'package:dio/dio.dart';
import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/local/shared_preference.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_faq.dart';
import 'package:education_app/data/network/payload/course/course_filters.dart';
import 'package:education_app/data/network/payload/course/course_payload.dart';
import 'package:education_app/data/network/payload/voucher/claim_voucher_payload.dart';
import 'package:education_app/data/network/payload/voucher/voucher_payload.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
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
      CourseFilters filters) async {
    try {
      final res = await api.getCourses(
        categoryIds: filters.categoryIds,
        instructorId: filters.instructorId,
        isFree: filters.isFree,
        languageIds: filters.languageIds,
        levelIds: filters.levelIds,
        searchQuery: filters.searchQuery,
        status: filters.status,
        subcategoryIds: filters.subcategoryIds,
      );
      return right(res);
    } catch (e) {
      return left(Failure("Failed to fetch courses"));
    }
  }

  @override
  Future<Either<Failure, Course>> getCourse(String courseId) async {
    try {
      final res = await api.getCourse(courseId: courseId);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
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
      if (e is DioException) {
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
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<CourseLevel>>> getCourseLevels() async {
    try {
      final res = await api.getCourseLevels();
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, Course>> updateCourse(
      UpdateCoursePayload payload) async {
    try {
      final res = await api.updateCourse(
        courseId: payload.courseId,
        categoryId: payload.categoryId,
        description: payload.description,
        levelId: payload.levelId,
        requirements: payload.requirements,
        title: payload.title,
        topics: payload.topics,
        subcategoryIds: payload.subcategoryIds,
        languageId: payload.languageId,
        price: payload.price,
        courseImages: payload.courseImages,
        courseVideo: payload.courseVideo,
        status: payload.status != null ? payload.status!.name : null,
      );
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<CourseFAQ>>> getCourseFAQ(String courseId) async {
    try {
      final res = await api.getCourseFAQ(courseId: courseId);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<CourseFAQ>>> updateCourseFAQ(
      UpdateCourseFAQPayload payload) async {
    try {
      final res = await api.updateCourseFAQ(
          courseId: payload.courseId, faqList: payload.faqList);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, CourseVoucher>> createCourseVoucher(
      CreateVoucherPayload payload) async {
    try {
      final res = await api.createVoucher(payload.formatCurrency());
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<CourseVoucher>>> getCourseVouchers(
      String courseId) async {
    try {
      final res = await api.getCourseVouchers(courseId: courseId);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserVoucher>> claimVoucher(
      ClaimVoucherPayload payload) async {
    try {
      final res = await api.claimVoucher(payload);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Failure(ErrorHandler.dioException(error: e).errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }
}
