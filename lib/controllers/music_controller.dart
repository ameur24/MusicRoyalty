import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/music_steps.dart';
import 'package:music_royalty/Screens/main/music_steps/music_title.dart';
import 'package:music_royalty/controllers/sign_up_controller.dart';
import 'package:music_royalty/models/UserMusics.dart';
import 'package:music_royalty/models/music.dart';
import 'package:music_royalty/models/websitesRegistrationfields.dart';

class MusicController extends GetxController {
  var selectedSite = 0.obs;
  late Music mu;
  bool isNew = true;
  var loading = false.obs;
  set SelctSite(value) => selectedSite.value = value;
  get obj => this.selectedSite.value;
  //music details
  List<Music> mymusicList = [];
  var loadingMusicLIst = true.obs;
  var musicTitle = "".obs;
  final fabheight = 0.0.obs;
  final url = "".obs;
  var titlekey = GlobalKey<FormState>();
  var websitefields = [].obs;
  updatewebsitefields(var list) {
    websitefields.add(list);
  }

//updater
  updateUrlName(String link) {
    url(link);
  }

  updateFabHeight(double height) {
    fabheight(height);
  }

  //validators
  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  Future<void> newMusic() async {
    loading.value = true;
    String now = Timestamp.now().toString();
    update();
    bool isvalidate = titlekey.currentState!.validate();
    print(isvalidate);
    if (isvalidate) {
      Music music = Music(
          Title: musicTitle.value,
          currentStep: 0,
          created_at: now,
          updated_at: now);
      print("music $music");

      await FirebaseFirestore.instance
          .collection("Music")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((docSnapshot) => {
                if (docSnapshot.exists)
                  {
                    FirebaseFirestore.instance
                        .collection('Music')
                        .withConverter(
                            fromFirestore: UserMusics.fromFirestore,
                            toFirestore: (UserMusics userMusic, options) =>
                                music.toFirestore())
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                  }
              });
      mu = music;
      /*  if (isNew == true) {
        await MusicCollection.set(userMusics);
      } else { */
      List<Music> m = [];
      FirebaseFirestore.instance
          .collection('Music')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"MusicList": FieldValue.arrayUnion(m)});

      UserMusics userMusics = UserMusics(
          userId: FirebaseAuth.instance.currentUser!.uid, MusicList: m);
      print("List $userMusics");
      print("music $music");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"num_music": FieldValue.increment(1)}).then(
        (res) => Get.to(() => musicSteps(),
            transition: Transition.rightToLeftWithFade,
            arguments: {"title": mu.Title, "currentStep": mu.currentStep}),
        onError: (e) => print("Error completing: $e"),
      );
      loading.value = false;
    }
    loading.value = false;

    update();
  }

  Future<void> getmymusic() async {
    loadingMusicLIst.value = true;
    final MusicCollection = FirebaseFirestore.instance
        .collection('Music')
        .withConverter(
            fromFirestore: UserMusics.fromFirestore,
            toFirestore: (UserMusics userMusic, options) =>
                userMusic.toFirestore())
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final docSnap = await MusicCollection.get();
    final result = docSnap.data();
    if (result != null) {
      mymusicList.addAll(result.MusicList!);
      print("The list : $mymusicList");
    } else {
      print("error");
    }
    loadingMusicLIst.value = false;
  }
}
