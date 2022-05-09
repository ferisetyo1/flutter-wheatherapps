part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required FormEmail? email,
    required FormPassword? password,
    required bool showPassword,
    required String? errorUnknown,
  }) = _LoginState;
  factory LoginState.initial() => LoginState(email: null, password: null, showPassword: false,errorUnknown: null);
}
