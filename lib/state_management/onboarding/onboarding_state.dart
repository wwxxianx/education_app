import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

final class OnboardingState extends Equatable {
  final ApiResult<UserModel> updateUserResult;
  final List<CourseCategory> selectedCourseCategories;
  const OnboardingState._({
    required this.updateUserResult,
    this.selectedCourseCategories = const [],
  });

  const OnboardingState.initial()
      : this._(updateUserResult: const ApiResultInitial());

  OnboardingState copyWith({
    ApiResult<UserModel>? updateUserResult,
    List<CourseCategory>? selectedCourseCategories,
  }) {
    return OnboardingState._(
      updateUserResult: updateUserResult ?? this.updateUserResult,
      selectedCourseCategories: selectedCourseCategories ?? this.selectedCourseCategories,
    );
  }

  @override
  List<Object?> get props => [updateUserResult, selectedCourseCategories];
}
