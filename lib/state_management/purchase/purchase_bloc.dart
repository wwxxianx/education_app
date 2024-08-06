import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/payment/course_payment_intent_payload.dart';
import 'package:education_app/data/service/payment/payment_service.dart';
import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/state_management/purchase/purchase_event.dart';
import 'package:education_app/state_management/purchase/purchase_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final PaymentService _paymentService;
  final FetchCourse _fetchCourse;
  PurchaseBloc({
    required PaymentService paymentService,
    required FetchCourse fetchCourse,
  })  : _paymentService = paymentService,
        _fetchCourse = fetchCourse,
        super(const PurchaseState.initial()) {
    on<PurchaseEvent>(_onEvent);
  }

  Future<void> _onEvent(
    PurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    return switch (event) {
      final OnPurchaseCourse e => _onPurchaseCourse(e, emit),
      final OnSelectVoucher e => _onSelectVoucher(e, emit),
      final OnFetchCourse e => _onFetchCourse(e, emit),
    };
  }

  Future<void> _onFetchCourse(
    OnFetchCourse event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(courseResult: const ApiResultLoading()));
    final res = await _fetchCourse.call(event.courseId);
    res.fold(
      (l) => null,
      (data) {
        emit(state.copyWith(courseResult: ApiResultSuccess(data)));
      },
    );
  }

  Future<void> _onPurchaseCourse(
    OnPurchaseCourse event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(purchaseIntentResult: const ApiResultLoading()));
    final payload = CoursePaymentIntentPayload(
      courseId: event.courseId,
      appliedVoucherId: state.selectedVoucher?.voucherId,
    );
    final paymentIntentRes =
        await _paymentService.initCampaignDonationPaymentSheet(payload);
    paymentIntentRes.fold(
      (failure) {
        emit(state.copyWith(
            purchaseIntentResult: ApiResultFailure(failure.errorMessage)));
      },
      (_) async {
        final paymentRes = await _paymentService.presentPaymentSheet();
        paymentRes.fold(
          (failure) {
            if (emit.isDone) return;
            emit(state.copyWith(
                purchaseIntentResult: ApiResultFailure(failure.errorMessage)));
          },
          (_) {
            if (emit.isDone) return;
            emit(state.copyWith(purchaseIntentResult: ApiResultSuccess(_)));
          },
        );
        event.onSuccess();
      },
    );
    // final purchaseIntentResult = await _paymentService.purchaseCourse(
    //   userVoucherId: event.userVoucherId,
    //   courseId: event.courseId,
    // );
    // emit(state.copyWith(purchaseIntentResult: purchaseIntentResult));
  }

  void _onSelectVoucher(
    OnSelectVoucher event,
    Emitter<PurchaseState> emit,
  ) {
    if (state.selectedVoucher == event.userVoucher) {
      return emit(state.removeVoucher());
    }
    emit(state.copyWith(selectedVoucher: event.userVoucher));
  }
}
