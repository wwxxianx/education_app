import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/usecases/user/update_user_profile.dart';
import 'package:education_app/state_management/user_profile/user_profile_event.dart';
import 'package:education_app/state_management/user_profile/user_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UpdateUserProfile _updateUserProfile;
  UserProfileBloc({
    required UpdateUserProfile updateUserProfile,
  })  : _updateUserProfile = updateUserProfile,
        super(const UserProfileState.initial()) {
    on<UserProfileEvent>(_onEvent);
  }

  Future<void> _onEvent(
    UserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    return switch (event) {
      final OnUpdateUserProfile e => _onUpdateUserProfile(e, emit),
    };
  }

  Future<void> _onUpdateUserProfile(
    OnUpdateUserProfile event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(updateUserResult: const ApiResultLoading()));
    final res = await _updateUserProfile.call(
      event.payload,
    );
    res.fold(
      (l) => emit(state.copyWith(updateUserResult: ApiResultFailure(l.errorMessage))),
      (r) {
        emit(state.copyWith(updateUserResult: ApiResultSuccess(r)));
        if (event.onSuccess != null) {
          event.onSuccess!(r);
        }
      },
    );
  }
}
