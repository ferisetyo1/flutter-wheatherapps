// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:boilerplate/application/register/register_bloc.dart';
import 'package:boilerplate/injection.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>()..add(RegisterEvent.started()),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          final RegisterBloc bloc = context.read<RegisterBloc>();
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text("Nama Depan"),
                            border: OutlineInputBorder(),
                            errorText: state.email?.value.fold(
                                    (l) => l.maybeWhen(
                                        empty: (_) =>
                                            "Nama depan tidak boleh kosong",
                                        orElse: () => "Nama depan Invalid"),
                                    (r) => null) ??
                                null),
                        onChanged: (value) {
                          bloc.add(
                              RegisterEvent.onChangeFirstName(value: value));
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
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
                          bloc.add(
                              RegisterEvent.onChangeLastName(value: value));
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder(),
                            errorText: state.email?.value.fold(
                                    (l) => l.maybeWhen(
                                        unregisteredEmail: (failedValue) =>
                                            "Email tidak terdaftar",
                                        empty: (_) =>
                                            "Email tidak boleh kosong",
                                        orElse: () => "Email Invalid"),
                                    (r) => null) ??
                                null),
                        onChanged: (value) {
                          bloc.add(RegisterEvent.onChangeEmail(value: value));
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text("Alamat"),
                            border: OutlineInputBorder(),
                            errorText: state.alamat?.value.fold(
                                    (l) => l.maybeWhen(
                                        empty: (_) =>
                                            "Alamat tidak boleh kosong",
                                        orElse: () => "Alamat Invalid"),
                                    (r) => null) ??
                                null),
                        onChanged: (value) {
                          bloc.add(RegisterEvent.onChangeAlamat(value: value));
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
                                        lengthTooShort: (failedValue, min) =>
                                            "Password minimal $min karakter",
                                        orElse: () => "Password Invalid"),
                                    (r) => null) ??
                                null,
                            suffix: InkWell(
                              onTap: () => bloc.add(RegisterEvent.onShowPass()),
                              child: Icon(state.showpass
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                        onChanged: (value) {
                          bloc.add(
                              RegisterEvent.onChangePassword(value: value));
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          bloc.add(RegisterEvent.onSubmit(onSuccess: () {
                            context.router.popUntilRoot();
                            context.navigateTo(MyHomeRoute());
                          }, onError: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Terjadi kesalahan internal")));
                          }));
                        },
                        child: Text("Register"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          // context.popRoute();
                          context.navigateTo(const LoginRoute());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sudah Punya Akun? ",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
