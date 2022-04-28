part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.started() = _Started;
  const factory LoginEvent.onChangeEmail({required String value}) = _OnChangeEmail;
  const factory LoginEvent.onChangePassword({required String value}) = _OnChangePassword;
  const factory LoginEvent.onSubmit({required Function() onSuccess}) = _OnSubmit;
  const factory LoginEvent.onShowPass() = _OnShowPass;
}