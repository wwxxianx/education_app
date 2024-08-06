import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_faq.dart';
import 'package:education_app/data/network/payload/course/course_payload.dart';
import 'package:education_app/data/network/payload/voucher/voucher_payload.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/domain/usecases/course/craete_course_voucher.dart';
import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/domain/usecases/course/fetch_course_faq.dart';
import 'package:education_app/domain/usecases/course/fetch_course_vouchers.dart';
import 'package:education_app/domain/usecases/course/update_course.dart';
import 'package:education_app/domain/usecases/course/update_course_faq.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class ManageCourseDetailsBloc
    extends Bloc<ManageCourseDetailsEvent, ManageCourseDetailsState> {
  final FetchCourse _fetchCourse;
  final UpdateCourse _updateCourse;
  final FetchCourseFAQ _fetchCourseFAQ;
  final UpdateCourseFAQ _updateCourseFAQ;
  final FetchCourseVouchers _fetchCourseVouchers;
  final CreateCourseVoucher _createCourseVoucher;

  ManageCourseDetailsBloc({
    required FetchCourse fetchCourse,
    required UpdateCourse updateCourse,
    required FetchCourseFAQ fetchCourseFAQ,
    required UpdateCourseFAQ updateCourseFAQ,
    required FetchCourseVouchers fetchCourseVouchers,
    required CreateCourseVoucher createCourseVoucher,
  })  : _fetchCourse = fetchCourse,
        _updateCourse = updateCourse,
        _fetchCourseFAQ = fetchCourseFAQ,
        _updateCourseFAQ = updateCourseFAQ,
        _fetchCourseVouchers = fetchCourseVouchers,
        _createCourseVoucher = createCourseVoucher,
        super(const ManageCourseDetailsState.initial()) {
    on<ManageCourseDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(
    ManageCourseDetailsEvent event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    return switch (event) {
      final OnTabIndexChanged e => _onTabIndexChanged(e, emit),
      final OnFetchCourse e => _onFetchCourse(e, emit),
      final OnUpdateCourseStatus e => _onUpdateCourseStatus(e, emit),
      final OnFetchCourseFAQ e => _onFetchCourseFAQ(e, emit),
      final OnAddFAQ e => _onAddFAQ(e, emit),
      final OnFAQQuestionChanged e => _onFAQQuestionChanged(e, emit),
      final OnFAQAnswerChanged e => _onFAQAnswerChanged(e, emit),
      final OnUpdateCourseFAQ e => _onUpdateCourseFAQ(e, emit),
      final OnCreateCourseVoucher e => _onCreateCourseVoucher(e, emit),
      final OnFetchCourseVouchers e => _onFetchCourseVouchers(e, emit),
      final OnDiscountChanged e => _onDiscountChanged(e, emit),
      final OnVoucherTitleChanged e => _onVoucherTitleChanged(e, emit),
      final OnVoucherExpirationDateChanged e =>
        _onVoucherExpirationDateChanged(e, emit),
      final OnVoucherStockChanged e => _onVoucherStockChanged(e, emit),
    };
  }

  void _onDiscountChanged(
    OnDiscountChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(discountText: event.value));
  }

  void _onVoucherTitleChanged(
    OnVoucherTitleChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(titleText: event.value));
  }

  void _onVoucherExpirationDateChanged(
    OnVoucherExpirationDateChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(voucherExpirationDate: event.value));
  }

  void _onVoucherStockChanged(
    OnVoucherStockChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(voucherStockText: event.value));
  }

  Future<void> _onCreateCourseVoucher(
    OnCreateCourseVoucher event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(createVoucherResult: const ApiResultLoading()));

    final payload = CreateVoucherPayload(
      title: state.voucherTitleText!,
      courseId: event.courseId,
      afterDiscountValue: int.parse(state.discountText!),
      expiredAt: state.voucherExpirationDate,
      stock: state.voucherStockText != null
          ? int.parse(state.voucherStockText!)
          : null,
    );
    final res = await _createCourseVoucher.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          createVoucherResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        emit(state.copyWith(createVoucherResult: ApiResultSuccess(data)));
        _updateCourseVoucherList(data, emit);
        event.onSuccess();
      },
    );
  }

  _updateCourseVoucherList(
    CourseVoucher newVoucher,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    final courseVoucherResult = state.courseVoucherResult;
    if (courseVoucherResult is ApiResultSuccess<List<CourseVoucher>>) {
      final courseVouchers = courseVoucherResult.data;
      final newVoucherList = [newVoucher, ...courseVouchers];
      emit(
        state.copyWith(
          courseVoucherResult: ApiResultSuccess(newVoucherList),
        ),
      );
    }
  }

  Future<void> _onFetchCourseVouchers(
    OnFetchCourseVouchers event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(courseVoucherResult: const ApiResultLoading()));

    final res = await _fetchCourseVouchers.call(event.courseId);
    res.fold(
      (failure) => emit(state.copyWith(
          courseVoucherResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        emit(state.copyWith(courseVoucherResult: ApiResultSuccess(data)));
      },
    );
  }

  Future<void> _onUpdateCourseFAQ(
    OnUpdateCourseFAQ event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(updateCourseFAQResult: const ApiResultLoading()));

    final payload = UpdateCourseFAQPayload(
        courseId: event.courseId, faqList: state.courseFAQList);
    final res = await _updateCourseFAQ.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          updateCourseFAQResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        emit(state.copyWith(updateCourseFAQResult: ApiResultSuccess(data)));
        event.onSuccess();
      },
    );
  }

  void _onFAQQuestionChanged(
    OnFAQQuestionChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(
      courseFAQList: state.courseFAQList
          .mapWithIndex((e, index) =>
              index == event.index ? e.copyWith(question: event.value) : e)
          .toList(),
    ));
  }

  void _onFAQAnswerChanged(
    OnFAQAnswerChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(
      courseFAQList: state.courseFAQList
          .mapWithIndex((e, index) =>
              index == event.index ? e.copyWith(answer: event.value) : e)
          .toList(),
    ));
  }

  void _onAddFAQ(
    OnAddFAQ event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(courseFAQList: [
      ...state.courseFAQList,
      CourseFAQItem(id: '', question: '', answer: ''),
    ]));
  }

  Future<void> _onUpdateCourseStatus(
    OnUpdateCourseStatus event,
    Emitter emit,
  ) async {
    emit(state.copyWith(updateCourseResult: const ApiResultLoading()));
    final payload = UpdateCoursePayload(
      courseId: event.courseId,
      status: event.status,
    );
    final res = await _updateCourse.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          updateCourseResult: ApiResultFailure(failure.errorMessage))),
      (course) {
        emit(state.copyWith(
          updateCourseResult: ApiResultSuccess(course),
          courseResult: ApiResultSuccess(course),
        ));
        event.onSuccess();
      },
    );
  }

  Future<void> _onFetchCourseFAQ(
    OnFetchCourseFAQ event,
    Emitter emit,
  ) async {
    emit(state.copyWith(courseFAQResult: const ApiResultLoading()));
    final res = await _fetchCourseFAQ.call(event.courseId);
    res.fold(
      (failure) => emit(state.copyWith(
          courseFAQResult: ApiResultFailure(failure.errorMessage))),
      (faq) => emit(
        state.copyWith(
          courseFAQResult: ApiResultSuccess(faq),
          courseFAQList: faq.map((e) => e.toCourseFAQItem()).toList(),
        ),
      ),
    );
  }

  Future<void> _onFetchCourse(
    OnFetchCourse event,
    Emitter emit,
  ) async {
    final res = await _fetchCourse.call(event.courseId);
    res.fold(
      (failure) => emit(
          state.copyWith(courseResult: ApiResultFailure(failure.errorMessage))),
      (course) => emit(state.copyWith(courseResult: ApiResultSuccess(course))),
    );
  }

  void _onTabIndexChanged(
    OnTabIndexChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(currentTabIndex: event.index));
  }
}
