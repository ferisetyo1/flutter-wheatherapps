// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:boilerplate/application/auth/auth_bloc.dart';
import 'package:boilerplate/injection.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
        create: (context) => getIt<AuthBloc>()..add(const AuthEvent.started()),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () => null,
                unauthenticated: () => context.replaceRoute(LoginRoute()),
                authenticated: () => context.replaceRoute(MyHomeRoute()));
          },
          child: Scaffold(body: Center(child: Text("WeatherApp",style: TextStyle(fontSize: 24),)),),
        ));
  }
}
