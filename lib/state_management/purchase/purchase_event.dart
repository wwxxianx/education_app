import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:flutter/material.dart';

@immutable
sealed class PurchaseEvent {
  const PurchaseEvent();
}

final class OnFetchCourse extends PurchaseEvent {
  final String courseId;

  const OnFetchCourse({required this.courseId});
}

final class OnPurchaseCourse extends PurchaseEvent {
  final String? userVoucherId;
  final String courseId;
  final VoidCallback onSuccess;

  const OnPurchaseCourse({
    this.userVoucherId,
    required this.courseId,
    required this.onSuccess,
  });
}

final class OnSelectVoucher extends PurchaseEvent {
  final UserVoucher userVoucher;

  const OnSelectVoucher({required this.userVoucher});
}
