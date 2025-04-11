import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/home/views/main_page.dart';
import 'app/modules/home/controllers/api_controller.dart';
import 'app/modules/home/views/webview_page.dart';

void main() {
  Get.put(ApiController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MainPage()),
        GetPage(name: '/webview', page: () => WebViewPage()),
      ],
    );
  }
}
