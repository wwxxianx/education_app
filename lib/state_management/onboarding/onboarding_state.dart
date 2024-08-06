import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

final class OnboardingState extends Equatable {
  final ApiResult<UserModel> updateUserResult;

  const OnboardingState._({
    required this.updateUserResult,
  });

  const OnboardingState.initial()
      : this._(updateUserResult: const ApiResultInitial());

  OnboardingState copyWith({
    ApiResult<UserModel>? updateUserResult,
  }) {
    return OnboardingState._(
      updateUserResult: updateUserResult ?? this.updateUserResult,
    );
  }

  @override
  List<Object?> get props => [updateUserResult];
}
