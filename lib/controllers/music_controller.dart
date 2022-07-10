import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/music_title.dart';
import 'package:music_royalty/controllers/sign_up_controller.dart';

class MusicController extends GetxController {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var selectedSite = 0.obs;
  set SelctSite(value) => selectedSite.value = value;
  get obj => this.selectedSite.value;
    CollectionReference MusicCollection = FirebaseFirestore.instance.collection('Music');

  //music details
  var musicTitle = "".obs;
   var titlekey = GlobalKey<FormState>();
  //validators
  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  Future<void> newMusic() async {
    bool isvalidate = titlekey.currentState!.validate();
    print(isvalidate);
    if (isvalidate) {
     var MusicNum = SignUpController().users.doc(uid).get();

      MusicCollection.doc(uid).set({
        "userId" : uid,
        'Musics.' : 
      })

    }
  }
}
