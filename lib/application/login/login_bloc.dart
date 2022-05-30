import 'package:bloc/bloc.dart';
import 'package:boilerplate/domain/core/failures.dart';
import 'package:boilerplate/domain/form_obj/form_email.dart';
import 'package:boilerplate/domain/form_obj/form_password.dart';
import 'package:boilerplate/domain/repo/i_home_repository.dart';
import 'package:boilerplate/domain/repo/i_login_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ILoginRepository _repo;
  IHomeRepository _homerepo;
  LoginBloc(this._repo,this._homerepo) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      await event.when(
          started: () async {
            var resp=await _homerepo.getDataWeather();
            print(resp.fold((l) => "failed", (r) => "sukses"));
          },
          onChangeEmail: (value) {
            emit(state.copyWith(email: FormEmail(value)));
          },
          onChangePassword: (value) {
            emit(state.copyWith(password: FormPassword(value)));
          },
          onSubmit: (onSuccess) async {
            final email = state.email?.value.fold((l) => "", (r) => r) ?? "";
            if (email.isEmpty) return;
            final password =
                state.password?.value.fold((l) => "", (r) => r) ?? "";
            if (password.isEmpty) return;
            final resp = await _repo.onLogin(email: email, password: password);
            emit(resp.fold((l) {
              return l.maybeWhen(
                  unregisteredEmail: (_email) => state.copyWith(
                      email: FormEmail.fromError(
                          ValueFailure.unregisteredEmail(failedValue: _email))),
                  objectNotMatch: (fail, match) => state.copyWith(
                      password: FormPassword.fromError(
                          ValueFailure.objectNotMatch(
                              failedValue: fail, matchValue: match))),
                  orElse: () => state.copyWith(
                      errorUnknown: "Terjadi kesalahan internal"));
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
