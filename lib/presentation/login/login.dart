// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:boilerplate/application/login/login_bloc.dart';
import 'package:boilerplate/injection.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>()..add(LoginEvent.started()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final LoginBloc bloc = context.read<LoginBloc>();
          return Scaffold(
            body: SafeArea(
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
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("Email"),
                        border: OutlineInputBorder(),
                        errorText: state.errorMail),
                    onChanged: (value) =>
                        bloc.add(LoginEvent.onChangeEmail(value: value)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    obscureText: !state.showPassword,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(),
                        errorText: state.errorPassword,
                        suffix: InkWell(
                          onTap: () => bloc.add(LoginEvent.onShowPass()),
                          child: Icon(state.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    onChanged: (value) =>
                        bloc.add(LoginEvent.onChangePassword(value: value)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // context.popRoute();
                      bloc.add(LoginEvent.onSubmit(onSuccess: () {
                        context.router.popUntilRoot();
                        context.navigateTo(MyHomeRoute());
                      }));
                    },
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      // context.popRoute();
                      context.navigateTo(const RegisterRoute());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tidak Punya Akun? ",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
