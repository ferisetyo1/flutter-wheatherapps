part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.onChangeFirstName( {required String value}) = _OnChangeFirstName;
  const factory ProfileEvent.onChangeLastName({required String value}) = _OnChangeLastName;
  const factory ProfileEvent.onChangeEmail({required String value}) = _OnChangeEmail;
  const factory ProfileEvent.onChangeAlamat({required String value}) = _OnChangeAlamat;
  const factory ProfileEvent.onChangePassword({required String value}) = _OnChangePassword;
  const factory ProfileEvent.onSubmit({required Function() onSuccess,required Function() onError}) = _OnSubmit;
  const factory ProfileEvent.onShowPass() = _OnShowPass;
  const factory ProfileEvent.onLogout({required Function() onSuccess,required Function() onError}) = _OnLogout;
}