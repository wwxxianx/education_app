import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/network/payload/course/create_course_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CourseRepository {
  Future<Either<Failure, List<CourseLevel>>> getCourseLevels();
  Future<Either<Failure, List<CourseCategory>>> getCourseCategories();
  Future<Either<Failure, List<Course>>> getCourses(FetchCoursePayload payload);
  Future<Either<Failure, Course>> getCourse(String courseId);

  Future<Either<Failure, Course>> createCourse(CreateCoursePayload payload);
}
