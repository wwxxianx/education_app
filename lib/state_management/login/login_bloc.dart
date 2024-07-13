import 'package:education_app/domain/usecases/auth/login.dart';
import 'package:education_app/state_management/login/login_event.dart';
import 'package:education_app/state_management/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login _login;
  LoginBloc({
    required Login login,
  })  : 
  _login = login,
        super(LoginInitial()) {
    on<LoginEvent>((event, emit) => emit(LoginInitial()));
    on<OnLogin>(_onLogin);
  }

  Future<void> _onLogin(
    OnLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final res = await _login(LoginPayload(
      email: event.email,
      password: event.password,
    ));
    res.fold(
      (failure) {
        emit(LoginFailure(failure.errorMessage));
      },
      (user) {
        emit(LoginSuccess(user));
        event.onSuccess(user);
      },
    );
  }
}
