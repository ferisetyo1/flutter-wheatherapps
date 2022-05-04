part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState(
      {required FormNonEmpty? firstName,
      required FormNonEmpty? lastName,
      required FormEmail? email,
      required FormNonEmpty? alamat,
      required FormPassword? password,
      required bool showpass,
      }) = _RegisterState;
  factory RegisterState.initial() => RegisterState(
      firstName: null, lastName: null, email: null, alamat: null, password: null, showpass: false);
}
