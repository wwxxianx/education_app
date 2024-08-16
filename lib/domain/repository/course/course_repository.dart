import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/network/payload/course/course_faq.dart';
import 'package:education_app/data/network/payload/course/course_filters.dart';
import 'package:education_app/data/network/payload/course/course_part_payload.dart';
import 'package:education_app/data/network/payload/course/course_payload.dart';
import 'package:education_app/data/network/payload/course/course_review_payload.dart';
import 'package:education_app/data/network/payload/course/course_section_payload.dart';
import 'package:education_app/data/network/payload/voucher/claim_voucher_payload.dart';
import 'package:education_app/data/network/payload/voucher/voucher_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CourseRepository {
  Future<Either<Failure, List<CourseLevel>>> getCourseLevels();
  Future<Either<Failure, List<CourseCategory>>> getCourseCategories();
  Future<Either<Failure, List<Course>>> getCourses(CourseFilters payload);
  Future<Either<Failure, Course>> getCourse(String courseId);
  Future<Either<Failure, Course>> createCourse(CreateCoursePayload payload);
  Future<Either<Failure, Course>> updateCourse(UpdateCoursePayload payload);

  // FAQ
  Future<Either<Failure, List<CourseFAQ>>> getCourseFAQ(String courseId);
  Future<Either<Failure, List<CourseFAQ>>> updateCourseFAQ(
    UpdateCourseFAQPayload payload,
  );

  // Voucher
  Future<Either<Failure, List<CourseVoucher>>> getCourseVouchers(
    String courseId,
  );
  Future<Either<Failure, CourseVoucher>> createCourseVoucher(
    CreateVoucherPayload payload,
  );
  Future<Either<Failure, UserVoucher>> claimVoucher(
    ClaimVoucherPayload payload,
  );

  // Review
  Future<Either<Failure, List<UserReview>>> getCourseReviews(String courseId);
  Future<Either<Failure, UserReview>> createCourseReview(
    CourseReviewPayload payload,
  );

  Future<Either<Failure, CourseSection>> updateCourseSection(
    UpdateCourseSectionPayload payload,
  );
  Future<Either<Failure, CourseSection>> createCourseSection(
    CreateCourseSectionPayload payload,
  );
  Future<Either<Failure, CoursePart>> createCoursePart(
    CreateCoursePartPayload payload,
  );
}
