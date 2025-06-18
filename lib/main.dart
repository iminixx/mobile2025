import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/home/views/main_page.dart';
import 'app/modules/home/controllers/api_controller.dart';
import 'app/modules/home/views/webview_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/modules/home/views/register_page.dart';
import 'app/modules/home/views/camera_page.dart';
import 'app/modules/home/views/mic_page.dart';
import 'app/modules/home/views/speaker_page.dart';
import 'app/modules/home/views/login_page.dart';
import 'app/modules/home/controllers/auth_controller.dart';
import 'app/modules/home/services/notification_service.dart';
import 'app/modules/home/views/location_page.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/home/controllers/connectivity_controller.dart';
import 'app/modules/home/controllers/home_controller.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.init();
  await GetStorage.init();
  Get.put(ApiController());
  Get.put(AuthController());
  Get.put(ConnectivityController());
  Get.put(HomeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/main', page: () => MainPage()),
        GetPage(name: '/webview', page: () => WebViewPage()),
        GetPage(name: '/camera', page: () => CameraPage()),
        GetPage(name: '/mic', page: () => MicPage()),
        GetPage(name: '/speaker', page: () => SpeakerPage()),
        GetPage(name: '/location', page: () => LocationPage(),
        )

      ],
    );
  }
}
