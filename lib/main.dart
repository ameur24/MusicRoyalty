import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_royalty/Screens/Authentication/sign_up_google.dart';
import 'package:music_royalty/Screens/main/empty_main.dart';
import 'package:music_royalty/Screens/main/music_steps/splitsheet.dart';

import 'package:music_royalty/Screens/splash.dart';
import 'package:music_royalty/controllers/user_controller.dart';
import 'Screens/main/music_steps/music_steps.dart';
import 'Screens/main/mymusic.dart';
import 'Utils/authservices.dart';
import 'controllers/music_controller.dart';
import 'firebase_options.dart';
import 'Screens/Authentication/landing_page.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init('MyStorage');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    MusicController controller = Get.put(MusicController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Royalty',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      getPages: [
        //   GetPage(name: "/splitsheet", page: () => splitsheet()),
        GetPage(name: "/landing", page: () => landingPage()),
        GetPage(name: "/signup", page: () => const signup_google()),
        GetPage(name: "/emptymain", page: () => EmptyMain()),
        GetPage(name: "/mymusic", page: () => const myMusic()),
      ],
      home: AuthService().handleAuthState(),
    );
  }
}
