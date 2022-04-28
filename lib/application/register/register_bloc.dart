import 'package:bloc/bloc.dart';
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
            String? errorMsg;
            if (value.isEmpty) {
              errorMsg = "Nama depan tidak boleh kosong";
            }
            emit(state.copyWith(firstName: value, errorFirstName: errorMsg));
          },
          onChangeLastName: (value) {
            String? errorMsg;
            if (value.isEmpty) {
              errorMsg = "Nama belakang tidak boleh kosong";
            }
            emit(state.copyWith(lastName: value, errorLastName: errorMsg));
          },
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
          onChangeAlamat: (value) {
            String? errorMsg;
            if (value.isEmpty) {
              errorMsg = "Alamat tidak boleh kosong";
            }
            emit(state.copyWith(alamat: value, errorAlamat: errorMsg));
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
            if (state.firstName.isEmpty) {
              emit(state.copyWith(
                  errorFirstName: "Nama depan tidak boleh kosong"));
              return;
            }
            if (state.lastName.isEmpty) {
              emit(state.copyWith(
                  errorLastName: "Nama belakang tidak boleh kosong"));
              return;
            }
            if (state.email.isEmpty) {
              emit(state.copyWith(errorMail: "Email tidak boleh kosong"));
              return;
            }
            if (!EmailValidator.validate(state.email)) {
              emit(state.copyWith(errorMail: "Email tidak valid"));
              return;
            }
            if (state.alamat.isEmpty) {
              emit(state.copyWith(errorAlamat: "Alamat tidak boleh kosong"));
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

            final resp = await _repo.onRegister(
                user: User(state.firstName, state.lastName, state.alamat,
                    state.email, state.password));
            resp.fold((l) => emit(state.copyWith(errorMail: l)), (r) {
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
