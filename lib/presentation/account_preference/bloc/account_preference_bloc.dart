import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/domain/usecases/user/update_user_profile.dart';
import 'package:education_app/presentation/account_preference/bloc/account_preference_event.dart';
import 'package:education_app/presentation/account_preference/bloc/account_preference_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class AccountPreferencesBloc
    extends Bloc<AccountPreferencesEvent, AccountPreferencesState> {
  final UpdateUserProfile _updateUserProfile;
  AccountPreferencesBloc({
    required UpdateUserProfile updateUserProfile,
  })  : _updateUserProfile = updateUserProfile,
        super(const AccountPreferencesState.initial()) {
    on<AccountPreferencesEvent>(_onEvent);
  }

  Future<void> _onEvent(AccountPreferencesEvent event,
      Emitter<AccountPreferencesState> emit) async {
    return switch (event) {
      final OnInitSelectedCategoryIds e => _onInitSelectedCategoryIds(e, emit),
      final OnSelectCategory e => _onSelectCategory(e, emit),
      final OnUpdateUser e => _onUpdateUser(e, emit),
    };
  }

  void _onInitSelectedCategoryIds(
    OnInitSelectedCategoryIds event,
    Emitter<AccountPreferencesState> emit,
  ) {
    final currentUser = event.currentUser;
    if (currentUser != null &&
        currentUser.preference != null &&
        currentUser.preference!.favouriteCourseCategories.isNotEmpty) {
      emit(
        state.copyWith(
          selectedCategoryIds: currentUser
              .preference!.favouriteCourseCategories
              .map((category) => category.id)
              .toList(),
        ),
      );
    }
  }

  Future<void> _onUpdateUser(
      OnUpdateUser event, Emitter<AccountPreferencesState> emit) async {
    emit(state.copyWith(updateUserResult: const ApiResultLoading()));
    final payload = UserProfilePayload(
      favouriteCourseCategoryIds: state.selectedCategoryIds
    );
    final res = await _updateUserProfile.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          updateUserResult: ApiResultFailure(failure.errorMessage))),
      (userModel) {
        emit(state.copyWith(updateUserResult: const ApiResultInitial()));
        event.onSuccess(userModel);
      },
    );
  }

  void _onSelectCategory(
      OnSelectCategory event, Emitter<AccountPreferencesState> emit) {
    if (state.selectedCategoryIds.contains(event.id)) {
      emit(state.copyWith(
          selectedCategoryIds: state.selectedCategoryIds
              .filter((id) => id != event.id)
              .toList()));
    } else {
      emit(state.copyWith(
          selectedCategoryIds: [...state.selectedCategoryIds, event.id]));
    }
  }
}
