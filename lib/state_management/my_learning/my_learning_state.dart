import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:equatable/equatable.dart';

final class MyLearningState extends Equatable {
  final ApiResult<List<UserCourse>> coursesResult;

  const MyLearningState({
    required this.coursesResult,
  });

  const MyLearningState.initial() : this(coursesResult: const ApiResultInitial());

  MyLearningState copyWith({
    ApiResult<List<UserCourse>>? coursesResult,
  }) {
    return MyLearningState(
      coursesResult: coursesResult ?? this.coursesResult,
    );
  }

  @override
  List<Object> get props => [coursesResult];
}
