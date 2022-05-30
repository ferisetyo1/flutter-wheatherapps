// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:boilerplate/application/profile/profile_bloc.dart';
import 'package:boilerplate/injection.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(ProfileEvent.started()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final ProfileBloc bloc = context.read<ProfileBloc>();
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                       controller: TextEditingController()
                        ..text =
                            state.firstName?.value.fold((l) => "", (r) => r) ??
                                ""
                        ..selection = TextSelection.collapsed(
                            offset: state.firstName?.value
                                    .fold((l) => 0, (r) => r.length) ??
                                0),
                      decoration: InputDecoration(
                          label: Text("Nama Depan"),
                          border: OutlineInputBorder(),
                          errorText: state.firstName?.value.fold(
                                  (l) => l.maybeWhen(
                                      empty: (_) =>
                                          "Nama depan tidak boleh kosong",
                                      orElse: () => "Nama depan Invalid"),
                                  (r) => null) ??
                              null),
                      onChanged: (value) {
                        bloc.add(ProfileEvent.onChangeFirstName(value: value));
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: TextEditingController()
                        ..text =
                            state.lastName?.value.fold((l) => "", (r) => r) ??
                                ""
                        ..selection = TextSelection.collapsed(
                            offset: state.lastName?.value
                                    .fold((l) => 0, (r) => r.length) ??
                                0),
                      decoration: InputDecoration(
                          label: Text("Nama Belakang"),
                          border: OutlineInputBorder(),
                          errorText: state.lastName?.value.fold(
                                  (l) => l.maybeWhen(
                                      empty: (_) =>
                                          "Nama belakang tidak boleh kosong",
                                      orElse: () => "Nama belakang Invalid"),
                                  (r) => null) ??
                              null),
                      onChanged: (value) {
                        bloc.add(ProfileEvent.onChangeLastName(value: value));
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                       controller: TextEditingController()
                        ..text =
                            state.email?.value.fold((l) => "", (r) => r) ??
                                ""
                        ..selection = TextSelection.collapsed(
                            offset: state.email?.value
                                    .fold((l) => 0, (r) => r.length) ??
                                0),
                      decoration: InputDecoration(
                          label: Text("Email"), border: OutlineInputBorder()),
                      enabled: false,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                       controller: TextEditingController()
                        ..text =
                            state.alamat?.value.fold((l) => "", (r) => r) ??
                                ""
                        ..selection = TextSelection.collapsed(
                            offset: state.alamat?.value
                                    .fold((l) => 0, (r) => r.length) ??
                                0),
                      decoration: InputDecoration(
                          label: Text("Alamat"),
                          border: OutlineInputBorder(),
                          errorText: state.alamat?.value.fold(
                                  (l) => l.maybeWhen(
                                      empty: (_) => "Alamat tidak boleh kosong",
                                      orElse: () => "Alamat Invalid"),
                                  (r) => null) ??
                              null),
                      onChanged: (value) {
                        bloc.add(ProfileEvent.onChangeAlamat(value: value));
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      obscureText: !state.showpass,
                      decoration: InputDecoration(
                          label: Text("Password"),
                          border: OutlineInputBorder(),
                          errorText: state.password?.value.fold(
                                  (l) => l.maybeWhen(
                                      empty: (_) =>
                                          "Password tidak boleh kosong",
                                      lengthTooShort: (failedValue, min) =>
                                          "Password minimal $min karakter",
                                      orElse: () => "Password Invalid"),
                                  (r) => null) ??
                              null,
                          suffix: InkWell(
                            onTap: () => bloc.add(ProfileEvent.onShowPass()),
                            child: Icon(state.showpass
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      onChanged: (value) {
                        bloc.add(ProfileEvent.onChangePassword(value: value));
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        bloc.add(ProfileEvent.onSubmit(onSuccess: (){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Berhasil mengupdate profile!")));
                         }, onError: (){
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Gagal mengupdate profile")));
                         }));
                      },
                      child: Text("Simpan"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40)),
                    ),
                    OutlinedButton(
                        onPressed: () {
                          bloc.add(ProfileEvent.onSubmit(onSuccess: (){
                          context.router.stack.clear();
                          context.replaceRoute(LoginRoute());
                         }, onError: (){
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Gagal logout!")));
                         }));
                        },
                        child: Text("Keluar"),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor),
                            minimumSize: Size.fromHeight(40))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
