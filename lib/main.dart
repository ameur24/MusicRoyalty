import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_royalty/Screens/Authentication/sign_up.dart';
import 'package:music_royalty/Screens/main/empty_main.dart';
import 'firebase_options.dart';
import 'Screens/Authentication/landing_page.dart';

void main() async {
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Royalty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: "/landing", page: () => landingPage()),
        GetPage(name: "/signup", page: () => signup()),
        GetPage(name: "/emptymain", page: () => EmptyMain()),
      ],
      initialRoute: "/emptymain",
    );
  }
}
