import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user.dart';
import 'package:education_app/domain/usecases/auth/get_current_user.dart';
import 'package:education_app/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final logger = Logger();
  final GetCurrentUser _getCurrentUser;
  // final SignOut _signOut;
  // final FetchNumOfReceivedUnusedGiftCards _fetchNumOfReceivedUnusedGiftCards;
  AppUserCubit({
    required GetCurrentUser getCurrentUser,
  })  : _getCurrentUser = getCurrentUser,
        //       _signOut = signOut,
        //       _fetchNumOfReceivedUnusedGiftCards = fetchNumOfReceivedUnusedGiftCards,
        super(const AppUserState.initial());

  void updateUser(UserModel? user) {
    if (user == null) {
      emit(const AppUserState.initial());
    } else {
      emit(state.copyWith(currentUser: user));
    }
  }

  Future<void> checkUserLoggedIn() async {
    final res = await _getCurrentUser(NoPayload());

    res.fold(
      (failure) => emit(const AppUserState.initial()),
      (user) => emit(state.copyWith(currentUser: user)),
    );
  }

  Future<void> signOut({
    VoidCallback? onSuccess,
  }) async {
    // await _signOut.call(NoPayload());
    // updateUser(null);
    // if (onSuccess != null) {
    //   onSuccess();
    // }
  }

  Future<void> initNumOfReceivedUnusedGiftCards() async {
    // final res = await _fetchNumOfReceivedUnusedGiftCards.call(NoPayload());
    // res.fold(
    //   (l) {
    //     logger.w("Error: ${l.errorMessage}");
    //   },
    //   (numRes) {
    //     logger.w("Received num: ${numRes.numOfGiftCards}");
    //     emit(state.copyWith(
    //         numOfReceivedUnusedGiftCards: numRes.numOfGiftCards));
    //   },
    // );
  }
}
