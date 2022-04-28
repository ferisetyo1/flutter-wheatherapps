part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState(
      {required String firstName,
      required String lastName,
      required String email,
      required String alamat,
      required String password,
      required bool showpass,
      required String? errorFirstName,
      required String? errorLastName,
      required String? errorMail,
      required String? errorAlamat,
      required String? errorPassword,
      }) = _RegisterState;
  factory RegisterState.initial() => RegisterState(
      firstName: '', lastName: '', email: '', alamat: '', password: '',errorFirstName: null,errorLastName: null,errorMail: null,errorAlamat: null,errorPassword: null, showpass: false);
}
