import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/notification/notification.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

final class AppUserState extends Equatable {
  final UserModel? currentUser;
  final int numOfReceivedUnusedGiftCards;
  final ApiResult<List<UserVoucher>> vouchersResult;
  final List<NotificationModel> notifications;
  final NotificationModel? realtimeNotification;

  const AppUserState._({
    this.currentUser,
    this.numOfReceivedUnusedGiftCards = 0,
    this.vouchersResult = const ApiResultInitial(),
    this.notifications = const [],
    this.realtimeNotification,
  });

  const AppUserState.initial() : this._();

  List<UserVoucher> availableVouchers(String courseId) {
    final vouchersResult = this.vouchersResult;
    if (vouchersResult is ApiResultSuccess<List<UserVoucher>>) {
      final userVouchers = vouchersResult.data;
      final availableVouchers = userVouchers.filter((userVoucher) {
        return (userVoucher.usedAt == null &&
            userVoucher.voucher?.courseId == courseId);
      });
      return availableVouchers.toList();
    }
    return [];
  }

  AppUserState copyWith({
    UserModel? currentUser,
    int? numOfReceivedUnusedGiftCards,
    ApiResult<List<UserVoucher>>? vouchersResult,
    List<NotificationModel>? notifications,
    NotificationModel? realtimeNotification,
  }) {
    return AppUserState._(
      currentUser: currentUser ?? this.currentUser,
      numOfReceivedUnusedGiftCards:
          numOfReceivedUnusedGiftCards ?? this.numOfReceivedUnusedGiftCards,
      vouchersResult: vouchersResult ?? this.vouchersResult,
      notifications: notifications ?? this.notifications,
      realtimeNotification: realtimeNotification ?? this.realtimeNotification,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        numOfReceivedUnusedGiftCards,
        vouchersResult,
        notifications,
        realtimeNotification,
      ];
}
