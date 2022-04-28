part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required String password,
    required bool showPassword,
    required String? errorMail,
    required String? errorPassword,
    required String? errorUnknown,
  }) = _LoginState;
  factory LoginState.initial() => LoginState(email: "", password: "", showPassword: false, errorMail: null, errorPassword: null,errorUnknown: null);
}
