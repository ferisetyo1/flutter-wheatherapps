part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.started() = _Started;
  const factory RegisterEvent.onChangeFirstName( {required String value}) = _OnChangeFirstName;
  const factory RegisterEvent.onChangeLastName({required String value}) = _OnChangeLastName;
  const factory RegisterEvent.onChangeEmail({required String value}) = _OnChangeEmail;
  const factory RegisterEvent.onChangeAlamat({required String value}) = _OnChangeAlamat;
  const factory RegisterEvent.onChangePassword({required String value}) = _OnChangePassword;
  const factory RegisterEvent.onSubmit({required Function() onSuccess,required Function() onError}) = _OnSubmit;
  const factory RegisterEvent.onShowPass() = _OnShowPass;
}
