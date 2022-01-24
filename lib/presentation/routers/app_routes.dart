import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/presentation/home/home_page.dart';
import 'package:boilerplate/presentation/routers/routers.dart';

part 'app_routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: Routers.main, page: MyHomePage, initial: true),
  ],
)
class AppRouters extends _$AppRouters {}
