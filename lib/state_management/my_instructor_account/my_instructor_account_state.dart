import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:equatable/equatable.dart';

final class MyInstructorAccountState extends Equatable {
  final ApiResult<InstructorProfile> instructorProfileResult;
  final bool isInstructorProfileNull;

  const MyInstructorAccountState({
    required this.instructorProfileResult,
    this.isInstructorProfileNull = false,
  });

  const MyInstructorAccountState.initial()
      : this(instructorProfileResult: const ApiResultInitial());

  MyInstructorAccountState copyWith({
    ApiResult<InstructorProfile>? instructorProfileResult,
    bool? isInstructorProfileNull,
  }) {
    return MyInstructorAccountState(
      instructorProfileResult:
          instructorProfileResult ?? this.instructorProfileResult,
      isInstructorProfileNull: isInstructorProfileNull ?? this.isInstructorProfileNull,
    );
  }

  @override
  List<Object?> get props => [instructorProfileResult, isInstructorProfileNull];
}
