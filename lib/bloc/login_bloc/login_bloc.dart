import 'package:cryptoapp/bloc/login_bloc/login_state.dart';
import 'package:cryptoapp/services/repositories/user_repository.dart';
import 'package:cryptoapp/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if (event is LoginWithCredentials) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    } else if (event is LoginForgotPassword) {
      yield* _mapForgotPasswordPressedToState(password: event.password);
    } else if (event is LoginConfirmPasswordMatch) {
      yield* _mapConfirmPasswordPressedToState(
          password: event.password, reenterPassword: event.reeneterPassword);
    }
  }

  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(
        isEmailValid: Validators.isValidEmail(email), isPasswordValid: true);
  }

  Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(password),
        isEmailValid: true);
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapForgotPasswordPressedToState(
      {required String password}) async* {
    yield LoginState.loading();
    try {
      if (await _userRepository.updatePassword(password) == true)
        yield LoginState.success();
      else
        yield LoginState.failure();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapConfirmPasswordPressedToState(
      {required String password, required String reenterPassword}) async* {
    yield state.updatePassword(
        isPasswordValid: true,
        isReenterPasswordValid:
            Validators.isSamePassword(password, reenterPassword));
  }
}
