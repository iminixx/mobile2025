import 'package:get/get.dart';
import 'package:mobile25/app/modules/home/views/webview_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'app/modules/home/views/home_page.dart';
import 'app/modules/home/views/account_page.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/bindings/account_binding.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/account',
      page: () => AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
        name: '/webview',
        page: () => WebViewPage()),

  ];
}
