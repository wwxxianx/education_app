import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:education_app/domain/usecases/auth/sign_out.dart';
import 'package:education_app/domain/usecases/auth/sign_up.dart';
import 'package:education_app/state_management/sign_up/sign_up_event.dart';
import 'package:education_app/state_management/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUp _signUp;
  final SignOut _signOut;
  SignUpBloc({
    required SignUp signUp,
    required SignOut signOut,
  })  : _signUp = signUp,
        _signOut = signOut,
        super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) => emit(SignUpInitial()));
    on<OnSignUp>(_onSignUp);
    on<OnSignOut>(_onSignOut);
  }

  Future<void> _onSignUp(
    OnSignUp event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    final res = await _signUp(AuthPayload(
      email: event.email,
      password: event.password,
    ));
    res.fold(
      (failure) => emit(SignUpFailure(failure.errorMessage)),
      (user) => _emitSignUpSuccess(user, emit, event.onSuccess),
    );
  }

  void _onSignOut(
    OnSignOut event,
    Emitter<SignUpState> emit,
  ) async {
    await _signOut(NoPayload());
  }

  void _emitSignUpSuccess(
    UserModel user,
    Emitter<SignUpState> emit,
    void Function(UserModel user) onSuccess,
  ) {
    emit(SignUpSuccess(user));
    onSuccess(user);
  }
}
