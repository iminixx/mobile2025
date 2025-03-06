import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/home/views/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
