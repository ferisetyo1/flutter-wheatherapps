import 'package:bloc/bloc.dart';
import 'package:boilerplate/domain/form_obj/form_email.dart';
import 'package:boilerplate/domain/form_obj/form_non_empty.dart';
import 'package:boilerplate/domain/form_obj/form_password.dart';
import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/repo/i_profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  IProfileRepository _repo;
  ProfileBloc(this._repo) : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.when(
          started: () async {
            final user = await _repo.getDataUser();
            emit(user.fold(
                (l) => state,
                (r) => state.copyWith(
                    firstName: FormNonEmpty(r.firstName),
                    lastName: FormNonEmpty(r.lastName),
                    email: FormEmail(r.email),
                    alamat: FormNonEmpty(r.alamat),
                    password: FormPassword(r.password))));
          },
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

            final resp = await _repo.updateDataUser(
                user: User(firstName, lastName, alamat, email, password));
            resp.fold((l) => onError(), (r) => onSuccess());
            emit(state);
          },
          onShowPass: () {
            emit(state.copyWith(showpass: !state.showpass));
          },
          onLogout: (onSuccess, onError) async {
            final resp=await _repo.logout();
            resp.fold((l) => onError(), (r) => onSuccess());
            emit(state);
          });
    });
  }
}
