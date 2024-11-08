import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/domain/usecases/user/update_user_profile.dart';
import 'package:education_app/state_management/onboarding/onboarding_event.dart';
import 'package:education_app/state_management/onboarding/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

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
      final OnSelectCourseCategory e => _onSelectCourseCategory(e, emit),
    };
  }

  void _onSelectCourseCategory(
    OnSelectCourseCategory event,
    Emitter<OnboardingState> emit,
  ) {
    // Add to state if not existed or remove from state if existed
    var selectedCourseCategories = state.selectedCourseCategories;
    if (selectedCourseCategories.contains(event.category)) {
      final updatedCategoryIds =
          selectedCourseCategories.filter((t) => t != event.category).toList();
      emit(state.copyWith(selectedCourseCategories: updatedCategoryIds));
    } else {
      final updatedCategoryIds = [...selectedCourseCategories, event.category];
      emit(state.copyWith(selectedCourseCategories: updatedCategoryIds));
    }
  }

  Future<void> _onCompleteOnboarding(
      CompleteOnboarding event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(updateUserResult: const ApiResultLoading()));
    final payload = UserProfilePayload(
      isOnBoardingCompleted: true,
      favouriteCourseCategoryIds:
          state.selectedCourseCategories.map((e) => e.id).toList(),
    );
    final res = await _updateUserProfile.call(payload);
    res.fold(
      (l) => emit(
          state.copyWith(updateUserResult: ApiResultFailure(l.errorMessage))),
      (r) {
        emit(state.copyWith(updateUserResult: ApiResultSuccess(r)));
        event.onSuccess();
      },
    );
  }
}
