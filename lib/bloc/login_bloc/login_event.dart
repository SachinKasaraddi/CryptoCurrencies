import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  List<Object> get proprs => [];
}

class LoginEmailChange extends LoginEvent {
  final String email;

  LoginEmailChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class LoginWithCredentials extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentials({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginConfirmPasswordMatch extends LoginEvent {
  final String password;
  final String reeneterPassword;

  LoginConfirmPasswordMatch(
      {required this.password, required this.reeneterPassword});

  @override
  List<Object?> get props => [password, reeneterPassword];
}

class LoginForgotPassword extends LoginEvent {
  final String password;

  LoginForgotPassword({required this.password});

  @override
  List<Object?> get props => [password];
}
