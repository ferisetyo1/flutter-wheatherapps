import 'package:boilerplate/injection.dart';
import 'package:boilerplate/presentation/core/i10n/l10n.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';

import 'package:boilerplate/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await configureInjection('dev');

  BlocOverrides.runZoned(() => runApp(MyApp()),
      blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouters();
    return MaterialApp.router(
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      localizationsDelegates: [
        I10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: I10n.delegate.supportedLocales,
    );
  }
}
