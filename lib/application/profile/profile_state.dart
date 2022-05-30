part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required FormNonEmpty? firstName,
    required FormNonEmpty? lastName,
    required FormEmail? email,
    required FormNonEmpty? alamat,
    required FormPassword? password,
    required bool showpass,
  }) = _ProfileState;
  factory ProfileState.initial() => ProfileState(
      firstName: null,
      lastName: null,
      email: null,
      alamat: null,
      password: null,
      showpass: false);
}
