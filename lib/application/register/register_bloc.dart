import 'package:bloc/bloc.dart';
import 'package:boilerplate/domain/core/failures.dart';
import 'package:boilerplate/domain/form_obj/form_email.dart';
import 'package:boilerplate/domain/form_obj/form_non_empty.dart';
import 'package:boilerplate/domain/form_obj/form_password.dart';
import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/repo/i_register_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  IRegisterRepository _repo;
  RegisterBloc(this._repo) : super(RegisterState.initial()) {
    on<RegisterEvent>((event, emit) async {
      await event.when(
          started: () {},
          onChangeFirstName: (value) {
            emit(state.copyWith(firstName: FormNonEmpty(value)));
          },
          onChangeLastName: (value) {
            emit(state.copyWith(lastName: FormNonEmpty(value)));
          },
          onChangeEmail: (value) {
            emit(state.copyWith(email: FormEmail(value)));
          },
          onChangeAlamat: (value) {
            emit(state.copyWith(alamat: FormNonEmpty(value)));
          },
          onChangePassword: (value) {
            emit(state.copyWith(password: FormPassword(value)));
          },
          onSubmit: (onSuccess, onError) async {
            final firstName =
                state.firstName?.value.fold((l) => "", (r) => r) ?? "";
            if (firstName.isEmpty) return;
            final lastName =
                state.lastName?.value.fold((l) => "", (r) => r) ?? "";
            if (lastName.isEmpty) return;
            final alamat = state.alamat?.value.fold((l) => "", (r) => r) ?? "";
            if (alamat.isEmpty) return;
            final email = state.email?.value.fold((l) => "", (r) => r) ?? "";
            if (email.isEmpty) return;
            final password =
                state.password?.value.fold((l) => "", (r) => r) ?? "";
            if (password.isEmpty) return;

            final resp = await _repo.onRegister(
                user: User(firstName, lastName, alamat, email, password));
            resp.fold((l) {
              l.maybeWhen(
                unregisteredEmail: (a) =>
                    {emit(state.copyWith(email: FormEmail.fromError(l)))},
                orElse: () => {onError()},
              );
            }, (r) {
              emit(state);
              onSuccess();
            });
          },
          onShowPass: () {
            emit(state.copyWith(showpass: !state.showpass));
          });
    });
  }
}
