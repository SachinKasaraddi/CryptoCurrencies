class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isReenterPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState(
      {required this.isEmailValid,
      required this.isPasswordValid,
      required this.isReenterPasswordValid,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure});

  factory LoginState.initial() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isReenterPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isReenterPasswordValid: false,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isReenterPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isReenterPasswordValid: false,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState update({
    required bool isEmailValid,
    required bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isReenterPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState updatePassword({
    required bool isPasswordValid,
    required bool isReenterPasswordValid,
  }) {
    return copyWith(
        isEmailValid: true,
        isPasswordValid: isPasswordValid,
        isReenterPasswordValid: isReenterPasswordValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }

  LoginState copyWith({
    required bool isEmailValid,
    required bool isPasswordValid,
    required bool isReenterPasswordValid,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return LoginState(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isReenterPasswordValid: isReenterPasswordValid,
        isSubmitting: isSubmitting,
        isSuccess: isSuccess,
        isFailure: isFailure);
  }
}
