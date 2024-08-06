import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manage_course_details_state.g.dart';

@JsonSerializable()
class CourseFAQItem {
  final String id;
  final String question;
  final String answer;
  const CourseFAQItem({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory CourseFAQItem.fromJson(Map<String, dynamic> json) =>
      _$CourseFAQItemFromJson(json);

  Map<String, dynamic> toJson() => _$CourseFAQItemToJson(this);

  CourseFAQItem copyWith({
    String? id,
    String? question,
    String? answer,
  }) {
    return CourseFAQItem(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }
}

final class ManageCourseDetailsState extends Equatable {
  final int currentTabIndex;
  final ApiResult<Course> courseResult;

  // FAQ
  final ApiResult<List<CourseFAQ>> courseFAQResult;
  final List<CourseFAQItem> courseFAQList;
  final ApiResult<List<CourseFAQ>> updateCourseFAQResult;

  // Voucher
  final ApiResult<List<CourseVoucher>> courseVoucherResult;
  final ApiResult<CourseVoucher> createVoucherResult;
  final String? discountText;
  final String? voucherTitleText;
  final String? voucherStockText;
  final DateTime? voucherExpirationDate;

  final ApiResult<Course> updateCourseResult;

  const ManageCourseDetailsState._({
    this.currentTabIndex = 0,
    this.courseResult = const ApiResultLoading(),
    this.courseFAQResult = const ApiResultInitial(),
    this.updateCourseFAQResult = const ApiResultInitial(),
    required this.updateCourseResult,
    this.courseFAQList = const [],
    this.courseVoucherResult = const ApiResultInitial(),
    this.createVoucherResult = const ApiResultInitial(),
    this.discountText,
    this.voucherTitleText,
    this.voucherStockText,
    this.voucherExpirationDate,
  });

  const ManageCourseDetailsState.initial()
      : this._(
          currentTabIndex: 0,
          updateCourseResult: const ApiResultInitial(),
        );

  ManageCourseDetailsState copyWith({
    int? currentTabIndex,
    ApiResult<Course>? courseResult,
    ApiResult<Course>? updateCourseResult,
    ApiResult<List<CourseFAQ>>? courseFAQResult,
    List<CourseFAQItem>? courseFAQList,
    ApiResult<List<CourseFAQ>>? updateCourseFAQResult,
    ApiResult<List<CourseVoucher>>? courseVoucherResult,
    ApiResult<CourseVoucher>? createVoucherResult,
    String? discountText,
    String? titleText,
    String? voucherStockText,
    DateTime? voucherExpirationDate,
  }) {
    return ManageCourseDetailsState._(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      courseResult: courseResult ?? this.courseResult,
      updateCourseResult: updateCourseResult ?? this.updateCourseResult,
      courseFAQResult: courseFAQResult ?? this.courseFAQResult,
      courseFAQList: courseFAQList ?? this.courseFAQList,
      updateCourseFAQResult:
          updateCourseFAQResult ?? this.updateCourseFAQResult,
      courseVoucherResult: courseVoucherResult ?? this.courseVoucherResult,
      createVoucherResult: createVoucherResult ?? this.createVoucherResult,
      discountText: discountText ?? this.discountText,
      voucherTitleText: titleText ?? this.voucherTitleText,
      voucherStockText: voucherStockText ?? this.voucherStockText,
      voucherExpirationDate:
          voucherExpirationDate ?? this.voucherExpirationDate,
    );
  }

  @override
  List<Object?> get props => [
        currentTabIndex,
        courseResult,
        updateCourseResult,
        courseFAQResult,
        courseFAQList,
        updateCourseFAQResult,
        courseVoucherResult,
        createVoucherResult,
        discountText,
        voucherTitleText,
        voucherStockText,
        voucherExpirationDate,
      ];
}
