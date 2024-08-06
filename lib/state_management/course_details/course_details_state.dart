import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:equatable/equatable.dart';

final class CourseDetailsState extends Equatable {
  final int currentTabIndex;
  final ApiResult<Course> courseResult;
  final ApiResult<UserCourse?> userCourseResult;
  // FAQ
  final ApiResult<List<CourseFAQ>> courseFAQResult;

  // Voucher
  final ApiResult<List<CourseVoucher>> courseVoucherResult;
  final ApiResult<UserVoucher> claimVoucherResult;

  const CourseDetailsState({
    this.currentTabIndex = 0,
    this.courseResult = const ApiResultInitial(),
    this.userCourseResult = const ApiResultInitial(),
    this.courseFAQResult = const ApiResultInitial(),
    this.courseVoucherResult = const ApiResultInitial(),
    this.claimVoucherResult = const ApiResultInitial(),
  });

  const CourseDetailsState.initial() : this(currentTabIndex: 0);

  CourseDetailsState copyWith({
    int? currentTabIndex,
    ApiResult<Course>? courseResult,
    ApiResult<UserCourse?>? userCourseResult,
    ApiResult<List<CourseFAQ>>? courseFAQResult,
    ApiResult<List<CourseVoucher>>? courseVoucherResult,
    ApiResult<UserVoucher>? claimVoucherResult,
  }) {
    return CourseDetailsState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      courseResult: courseResult ?? this.courseResult,
      userCourseResult: userCourseResult ?? this.userCourseResult,
      courseFAQResult: courseFAQResult ?? this.courseFAQResult,
      courseVoucherResult: courseVoucherResult ?? this.courseVoucherResult,
      claimVoucherResult: claimVoucherResult ?? this.claimVoucherResult,
    );
  }

  @override
  List<Object?> get props => [
        currentTabIndex,
        courseResult,
        userCourseResult,
        courseFAQResult,
        courseVoucherResult,
        claimVoucherResult,
      ];
}
