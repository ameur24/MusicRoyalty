import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:music_royalty/Screens/Authentication/landing_page.dart';

import 'Authentication/sign_up_google.dart';
import 'main/empty_main.dart';
import 'main/mymusic.dart';

class Splash {
  void check() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
        Get.offAll(landingPage());
      } else {
        print('User is signed in!');
        var Exists = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((docSnapshot) async => {
                  if (docSnapshot.exists)
                    // empty main tetbadel ken user ando  music twali ndhahrolo mymusic()
                    {
                      await FirebaseFirestore.instance
                          .collection("Music")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((docSnapshot) => {
                                if (docSnapshot.exists)
                                  {
                                    Get.off(myMusic()),
                                  }
                                else
                                  {Get.off(EmptyMain()), print("azsss")}
                              }),
                    }
                  else
                    {Get.to(signup_google())}
                });
      }
    });
  }
}
