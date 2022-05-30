import 'package:boilerplate/presentation/cariKota/cari_kota_page.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/presentation/register/register.dart';
import 'package:boilerplate/presentation/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/presentation/home/home_page.dart';
import 'package:boilerplate/presentation/routers/routers.dart';

part 'app_routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: Routers.splash, page: SplashPage, initial: true),
    AutoRoute(path: Routers.main, page: MyHomePage),
    AutoRoute(path: Routers.login, page: LoginPage),
    AutoRoute(path: Routers.register, page: RegisterPage),
    AutoRoute(path: Routers.profile, page: ProfilePage),
    AutoRoute(path: Routers.carikota, page: CariKotaPage),
  ],
)
class AppRouters extends _$AppRouters {}
