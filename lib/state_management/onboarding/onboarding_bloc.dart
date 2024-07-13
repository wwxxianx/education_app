import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/usecases/user/update_user_profile.dart';
import 'package:education_app/state_management/onboarding/onboarding_event.dart';
import 'package:education_app/state_management/onboarding/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final UpdateUserProfile _updateUserProfile;

  OnboardingBloc({
    required UpdateUserProfile updateUserProfile,
  })  : _updateUserProfile = updateUserProfile,
        super(const OnboardingState.initial()) {
    on<OnboardingEvent>(_onEvent);
  }

  Future<void> _onEvent(
      OnboardingEvent event, Emitter<OnboardingState> emit) async {
    return switch (event) {
      final CompleteOnboarding e => _onCompleteOnboarding(e, emit),
    };
  }

  Future<void> _onCompleteOnboarding(
      CompleteOnboarding event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(updateUserResult: const ApiResultLoading()));
    final res = await _updateUserProfile.call(event.payload);
    res.fold(
      (l) => emit(state.copyWith(updateUserResult: ApiResultFailure(l.errorMessage))),
      (r) {
        emit(state.copyWith(updateUserResult: ApiResultSuccess(r)));
        event.onSuccess();
      },
    );
  }
}
