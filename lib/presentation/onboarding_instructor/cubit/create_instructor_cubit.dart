import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/instructor_profile_payload.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/domain/usecases/user/create_instructor_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class CreateInstructorProfileState extends Equatable {
  final ApiResult<InstructorProfile> createInstructorProfileResult;

  const CreateInstructorProfileState({
    required this.createInstructorProfileResult,
  });

  const CreateInstructorProfileState.initial()
      : this(createInstructorProfileResult: const ApiResultInitial());

  CreateInstructorProfileState copyWith({
    ApiResult<InstructorProfile>? createInstructorProfileResult,
  }) {
    return CreateInstructorProfileState(
      createInstructorProfileResult:
          createInstructorProfileResult ?? this.createInstructorProfileResult,
    );
  }

  @override
  List<Object?> get props => [createInstructorProfileResult];
}

class CreateInstructorProfileCubit extends Cubit<CreateInstructorProfileState> {
  final CreateInstructorProfile _createInstructorProfile;
  CreateInstructorProfileCubit(
      {required CreateInstructorProfile createInstructorProfile})
      : _createInstructorProfile = createInstructorProfile,
        super(const CreateInstructorProfileState.initial());

  Future<void> onCreateInstructorProfile(
    CreateInstructorProfilePayload payload,
    {required VoidCallback onSuccess}
  ) async {
    emit(state.copyWith(
        createInstructorProfileResult: const ApiResultLoading()));
    final res = await _createInstructorProfile.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(createInstructorProfileResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        emit(state.copyWith(
            createInstructorProfileResult: ApiResultSuccess(data)));
        onSuccess();
      },
    );
  }
}
