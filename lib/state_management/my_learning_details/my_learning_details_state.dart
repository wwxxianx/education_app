import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';

final class MyLearningDetailsState extends Equatable {
  final ApiResult<Course> courseResult;
  // Indicate the current course on the screen
  final CoursePart? currentPart;

  const MyLearningDetailsState({
    required this.courseResult,
    this.currentPart,
  });

  const MyLearningDetailsState.initial() : this(
    courseResult: const ApiResultInitial(),
  );

  MyLearningDetailsState copyWith({
    ApiResult<Course>? courseResult,
    CoursePart? currentPart,
  }) {
    return MyLearningDetailsState(
      courseResult: courseResult ?? this.courseResult,
      currentPart: currentPart ?? this.currentPart,
    );
  }
  
  @override
  List<Object?> get props => [courseResult, currentPart];
}
