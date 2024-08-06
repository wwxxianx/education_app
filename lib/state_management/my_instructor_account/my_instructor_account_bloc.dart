import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/usecases/user/fetch_instructor_profile.dart';
import 'package:education_app/state_management/my_instructor_account/my_instructor_account_event.dart';
import 'package:education_app/state_management/my_instructor_account/my_instructor_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class MyInstructorAccountBloc
    extends Bloc<MyInstructorAccountEvent, MyInstructorAccountState> {
  final FetchInstructorProfile _fetchInstructorProfile;
  MyInstructorAccountBloc({
    required FetchInstructorProfile fetchInstructorProfile,
  })  : _fetchInstructorProfile = fetchInstructorProfile,
        super(const MyInstructorAccountState.initial()) {
    on<MyInstructorAccountEvent>(_onEvent);
  }

  Future<void> _onEvent(MyInstructorAccountEvent event,
      Emitter<MyInstructorAccountState> emit) async {
    return switch (event) {
      final OnFetchInstructorProfile e => _onFetchInstructorProfile(e, emit),
    };
  }

  Future<void> _onFetchInstructorProfile(
    OnFetchInstructorProfile e,
    Emitter<MyInstructorAccountState> emit,
  ) async {
    var logger = Logger();
    emit(state.copyWith(instructorProfileResult: const ApiResultLoading()));
    final res = await _fetchInstructorProfile.call(e.userId);
    res.fold(
      (failure) {
        logger.d('data received: ${failure}');
        emit(state.copyWith(
            instructorProfileResult: ApiResultFailure(failure.errorMessage)));
      },
      (data) {
        logger.d('data received: ${data}');
        if (data == null) {
          return emit(state.copyWith(
            isInstructorProfileNull: true,
            instructorProfileResult: const ApiResultInitial(),
          ));
        }
        emit(state.copyWith(instructorProfileResult: ApiResultSuccess(data)));
      },
    );
  }
}
