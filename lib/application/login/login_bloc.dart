import 'package:bloc/bloc.dart';
import 'package:boilerplate/domain/repo/i_login_repository.dart';
import 'package:boilerplate/infrastructure/login/error_login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ILoginRepository _repo;
  LoginBloc(this._repo) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) {
      event.when(
          started: () {},
          onChangeEmail: (value) {
            String? errorMsg;
            if (value.isEmpty) {
              errorMsg = "Email tidak boleh kosong";
            }
            if (!EmailValidator.validate(value)) {
              errorMsg = "Email tidak valid";
            }

            emit(state.copyWith(email: value, errorMail: errorMsg));
          },
          onChangePassword: (value) {
            String? errorMsg;
            if (value.isEmpty) {
              errorMsg = "Password tidak boleh kosong";
            }
            if (value.length < 6) {
              errorMsg = "Password minimal 6 karakter";
            }
            emit(state.copyWith(password: value, errorPassword: errorMsg));
          },
          onSubmit: (onSuccess) async {
            if (state.email.isEmpty) {
              emit(state.copyWith(errorMail: "Email tidak boleh kosong"));
              return;
            }
            if (!EmailValidator.validate(state.email)) {
              emit(state.copyWith(errorMail: "Email tidak valid"));
              return;
            }
            if (state.password.isEmpty) {
              emit(
                  state.copyWith(errorPassword: "Password tidak boleh kosong"));
              return;
            }
            if (state.password.length < 6) {
              emit(
                  state.copyWith(errorPassword: "Password minimal 6 karakter"));
              return;
            }
            final resp = await _repo.onLogin(
                email: state.email, password: state.password);
            emit(resp.fold((l) {
              switch (l) {
                case ErrorLogin.NOT_REGISTERED_EMAIL:
                  return state.copyWith(errorMail: "Email tidak terdaftar");
                case ErrorLogin.WRONG_PASSWORD:
                  return state.copyWith(errorPassword: "Password salah");
                case ErrorLogin.UNKNOWN_ERROR:
                  return state.copyWith(
                      errorUnknown: "Terjadi kesalahan internal");
                default:
                  return state;
              }
            }, (r) {
              if (emit.isDone) {
                onSuccess();
              }
              return state;
            }));
          },
          onShowPass: () {
            emit(state.copyWith(showPassword: !state.showPassword));
          });
    });
  }
}
