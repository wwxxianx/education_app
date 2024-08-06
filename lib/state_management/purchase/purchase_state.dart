import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

final class PurchaseState extends Equatable {
  final ApiResult<Course> courseResult;
  final UserVoucher? selectedVoucher;
  final ApiResult<Unit> purchaseIntentResult;

  const PurchaseState({
    this.selectedVoucher,
    this.purchaseIntentResult = const ApiResultInitial(),
    this.courseResult = const ApiResultInitial(),
  });

  const PurchaseState.initial() : this();

  PurchaseState copyWith({
    UserVoucher? selectedVoucher,
    ApiResult<Unit>? purchaseIntentResult,
    ApiResult<Course>? courseResult,
  }) {
    return PurchaseState(
      selectedVoucher: selectedVoucher ?? this.selectedVoucher,
      purchaseIntentResult: purchaseIntentResult ?? this.purchaseIntentResult,
      courseResult: courseResult ?? this.courseResult,
    );
  }

  PurchaseState removeVoucher() {
    return PurchaseState(
      selectedVoucher: null,
      purchaseIntentResult: purchaseIntentResult,
      courseResult: courseResult,
    );
  }

  @override
  List<Object?> get props => [
        selectedVoucher,
        purchaseIntentResult,
        courseResult,
      ];
}
