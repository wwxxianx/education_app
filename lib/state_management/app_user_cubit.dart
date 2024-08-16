import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/notification/notification.dart';
import 'package:education_app/domain/model/user/course_progress.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/domain/usecases/auth/get_current_user.dart';
import 'package:education_app/domain/usecases/auth/sign_out.dart';
import 'package:education_app/domain/usecases/notification/fetch_notifications.dart';
import 'package:education_app/domain/usecases/notification/read_notification.dart';
import 'package:education_app/domain/usecases/user/fetch_my_vouchers.dart';
import 'package:education_app/domain/usecases/user/fetch_recent_course_progress.dart';
import 'package:education_app/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final logger = Logger();
  final GetCurrentUser _getCurrentUser;
  final FetchMyVouchers _fetchMyVouchers;
  final FetchNotifications _fetchNotifications;
  final ToggleReadNotification _toggleReadNotification;
  final SupabaseClient _supabase;
  final SignOut _signOut;
  final FetchRecentCourseProgress _fetchRecentCourseProgress;
  // final FetchNumOfReceivedUnusedGiftCards _fetchNumOfReceivedUnusedGiftCards;
  AppUserCubit({
    required GetCurrentUser getCurrentUser,
    required FetchMyVouchers fetchMyVouchers,
    required FetchNotifications fetchNotifications,
    required ToggleReadNotification toggleReadNotification,
    required SupabaseClient supabase,
    required SignOut signOut,
    required FetchRecentCourseProgress fetchRecentCourseProgress,
  })  : _getCurrentUser = getCurrentUser,
        _fetchMyVouchers = fetchMyVouchers,
        _fetchNotifications = fetchNotifications,
        _toggleReadNotification = toggleReadNotification,
        _supabase = supabase,
        _signOut = signOut,
        _fetchRecentCourseProgress = fetchRecentCourseProgress,
        //       _fetchNumOfReceivedUnusedGiftCards = fetchNumOfReceivedUnusedGiftCards,
        super(const AppUserState.initial());

  Future<void> listenToRealtimeNotification() async {
    final currentUser = state.currentUser;
    if (currentUser == null) {
      return;
    }
    _supabase
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('receiverId', currentUser.id)
        .listen(
          (data) {
            if (data.isEmpty) {
              return;
            }
            final notifications = data.map((json) {
              return NotificationModel.fromJson(json);
            }).toList();

            final unreadVoucherNotification = notifications
                .filter((element) =>
                    element.type == NotificationType.COURSE_VOUCHER.name &&
                    !element.isRead)
                .toList();
            if (unreadVoucherNotification.isNotEmpty) {
              emit(
                state.copyWith(
                  realtimeNotification: unreadVoucherNotification.first,
                ),
              );
            }
          },
        );
  }

  Future<void> toggleReadNotification({required String notificationId}) async {
    final res = await _toggleReadNotification.call(notificationId);
    res.fold(
      (l) => null,
      (newNotification) {
        final updatedNotifications = state.notifications.map((notification) {
          if (notification.id == newNotification.id) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList();
        emit(state.copyWith(notifications: updatedNotifications));
      },
    );
  }

  Future<void> fetchNotifications() async {
    final currentUser = state.currentUser;
    if (currentUser == null) {
      return;
    }

    final res = await _fetchNotifications.call(NoPayload());
    res.fold(
      (l) {},
      (notifications) => emit(state.copyWith(notifications: notifications)),
    );
  }

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

  Future<void> fetchUserVouchers() async {
    final res = await _fetchMyVouchers.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          vouchersResult: ApiResultFailure(failure.errorMessage))),
      (vouchers) {
        emit(state.copyWith(vouchersResult: ApiResultSuccess(vouchers)));
      },
    );
  }

  Future<void> signOut({
    VoidCallback? onSuccess,
  }) async {
    await _signOut.call(NoPayload());
    updateUser(null);
    if (onSuccess != null) {
      onSuccess();
    }
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

  void addNewVoucher(UserVoucher voucher) {
    var currentVoucher = [];
    final vouchersResult = state.vouchersResult;
    if (vouchersResult is ApiResultSuccess<List<UserVoucher>>) {
      currentVoucher = vouchersResult.data;
    }
    emit(state.copyWith(
        vouchersResult: ApiResultSuccess([voucher, ...currentVoucher])));
  }

  Future<void> fetchRecentCourseProgress() async {
    final res = await _fetchRecentCourseProgress.call(NoPayload());
    res.fold((failure) => null, (data) {
      emit(state.copyWith(recentCourseProgress: data));
    });
  }

  Future<void> updateRecentCourseProgress(CourseProgress data) async {
    emit(state.copyWith(recentCourseProgress: data));
  }
}
