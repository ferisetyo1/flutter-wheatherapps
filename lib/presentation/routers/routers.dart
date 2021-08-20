import 'package:boilerplate/presentation/home/home_page.dart';

import 'package:get/get.dart';

class Routers {
  static final String main = '/';

  final List<GetPage> routers = [
    GetPage(name: Routers.main, page: () => MyHomePage(title: 'title'))
  ];
}
