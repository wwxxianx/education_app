import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/domain/usecases/course/fetch_course_faq.dart';
import 'package:education_app/domain/usecases/course/fetch_course_vouchers.dart';
import 'package:education_app/domain/usecases/user/claim_voucher.dart';
import 'package:education_app/domain/usecases/user/fetch_learning_course.dart';
import 'package:education_app/state_management/course_details/course_details_event.dart';
import 'package:education_app/state_management/course_details/course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsBloc extends Bloc<CourseDetailsEvent, CourseDetailsState> {
  final FetchCourse _fetchCourse;
  final FetchLearningCourse _fetchLearningCourse;
  final FetchCourseFAQ _fetchCourseFAQ;
  final FetchCourseVouchers _fetchCourseVouchers;
  final ClaimVoucher _claimVoucher;

  CourseDetailsBloc({
    required FetchCourse fetchCourse,
    required FetchLearningCourse fetchLearningCourse,
    required FetchCourseFAQ fetchCourseFAQ,
    required FetchCourseVouchers fetchCourseVouchers,
    required ClaimVoucher claimVoucher,
  })  : _fetchCourse = fetchCourse,
        _fetchLearningCourse = fetchLearningCourse,
        _fetchCourseFAQ = fetchCourseFAQ,
        _fetchCourseVouchers = fetchCourseVouchers,
        _claimVoucher = claimVoucher,
        super(const CourseDetailsState.initial()) {
    on<CourseDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CourseDetailsEvent event,
    Emitter<CourseDetailsState> emit,
  ) async {
    return switch (event) {
      final OnTabIndexChanged e => _onTabIndexChanged(e, emit),
      final OnFetchCourse e => _onFetchCourse(e, emit),
      final OnFetchUserCourse e => _onFetchUserCourse(e, emit),
      final OnFetchCourseFAQ e => _onFetchCourseFAQ(e, emit),
      final OnFetchCourseVoucher e => _onFetchCourseVoucher(e, emit),
      final OnClaimVoucher e => _onClaimVoucher(e, emit),
    };
  }

  Future<void> _onClaimVoucher(
    OnClaimVoucher event,
    Emitter emit,
  ) async {
    emit(state.copyWith(claimVoucherResult: const ApiResultLoading()));
    final res = await _claimVoucher.call(event.payload);
    res.fold(
      (l) => emit(state.copyWith(claimVoucherResult: ApiResultFailure(l.errorMessage))),
      (r) {
        emit(state.copyWith(claimVoucherResult: ApiResultSuccess(r)));
        event.onSuccess?.call(r);
      },
    );
  }

  Future<void> _onFetchCourseVoucher(
    OnFetchCourseVoucher event,
    Emitter emit,
  ) async {
    final res = await _fetchCourseVouchers(event.courseId);
    res.fold(
      (l) => emit(state.copyWith(
          courseVoucherResult: ApiResultFailure(l.errorMessage))),
      (r) => emit(state.copyWith(courseVoucherResult: ApiResultSuccess(r))),
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
        state.copyWith(courseFAQResult: ApiResultSuccess(faq)),
      ),
    );
  }

  Future<void> _onFetchUserCourse(
    OnFetchUserCourse event,
    Emitter emit,
  ) async {
    emit(state.copyWith(userCourseResult: const ApiResultLoading()));
    final res = await _fetchLearningCourse.call(event.courseId);
    res.fold(
      (failure) => emit(state.copyWith(
          userCourseResult: ApiResultFailure(failure.errorMessage))),
      (userCourse) =>
          emit(state.copyWith(userCourseResult: ApiResultSuccess(userCourse))),
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
