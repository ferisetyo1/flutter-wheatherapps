// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:boilerplate/application/register/register_bloc.dart';
import 'package:boilerplate/injection.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';
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
                            errorText: state.errorFirstName),
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
                            errorText: state.errorLastName),
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
                            label: Text("Email"), border: OutlineInputBorder(),errorText: state.errorMail),
                        onChanged: (value) {
                          bloc.add(
                              RegisterEvent.onChangeEmail(value: value));
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text("Alamat"),
                            border: OutlineInputBorder(),
                            errorText: state.errorAlamat),
                        onChanged: (value) {
                          bloc.add(
                              RegisterEvent.onChangeAlamat(value: value));
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
                            errorText: state.errorPassword,
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
                          bloc.add(RegisterEvent.onSubmit(onSuccess: (){
                            context.router.popUntilRoot();
                          context.navigateTo(MyHomeRoute());
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
