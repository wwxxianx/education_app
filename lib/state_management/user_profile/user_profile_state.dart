import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

final class UserProfileState extends Equatable {
  final ApiResult<UserModel> updateUserResult;
  
  const UserProfileState({
    this.updateUserResult = const ApiResultInitial(),
  });

  const UserProfileState.initial() : this();

  UserProfileState copyWith({
    ApiResult<UserModel>? updateUserResult,
  }) {
    return UserProfileState(
      updateUserResult: updateUserResult ?? this.updateUserResult,
    );
  }

  @override
  List<Object> get props => [updateUserResult];
}
