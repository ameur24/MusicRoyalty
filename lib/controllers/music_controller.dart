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
  var step = 0.obs;
  var switched = false.obs;
  var keyboardup = false.obs;
  //music details
  List<Music> mymusicList = [];
  var loadingMusicLIst = true.obs;
  var musicTitle = "".obs;
  final fabheight = 0.0.obs;
  var SignInupKey = GlobalKey<FormState>();
  var signinupemailcontroller = TextEditingController().obs;
  var signinuppasswordcontroller = TextEditingController().obs;
  var signinuppasswordconfirmcontroller = TextEditingController().obs;
  final url = "".obs;
  var titlekey = GlobalKey<FormState>();
  var websitefields = [].obs;
  var Empty = false.obs;
  var passwtogg1 = true.obs;
  var passwtogg2 = true.obs;
  updatewebsitefields(var list) {
    websitefields.add(list);
  }

  String? validatePasswordlen(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    } else if (c1.length < 6) {
      return "Minimum length is 6";
    }
    return null;
  }

  String? validatePassword(String c1, c2) {
    if (c2.isEmpty || c2 == null) {
      return "This field can't be empty";
    } else if (c1 != c2) {
      return "Password are not the same";
    }
    return null;
  }

  checkMusicExist() async {
    final MusicCollection = await FirebaseFirestore.instance
        .collection('Music')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MusicList');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await MusicCollection.get();
    Empty.value = querySnapshot.docs.isEmpty;
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

  Future<void> brandnewMusic() async {
    loading.value = true;
    String now = DateTime.now().toString();
    update();
    bool isvalidate = titlekey.currentState!.validate();
    print(isvalidate);
    if (isvalidate) {
      Music music = Music(
        Title: musicTitle.value,
        currentStep: 0,
        /*     created_at: now,
          updated_at: now */
      );
      print("music $music");

      /*  if (isNew == true) {
        await MusicCollection.set(userMusics);
      } else { */
      List<Music> m = [];
      m.add(music);
      RxDouble fabhieght = 20.0.obs;
      UserMusics userMusics = UserMusics(
          userId: FirebaseAuth.instance.currentUser!.uid, MusicList: m);

      FirebaseFirestore.instance
          .collection('Music')
          .withConverter(
              fromFirestore: UserMusics.fromFirestore,
              toFirestore: (UserMusics userMusic, options) =>
                  userMusic.toFirestore())
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userMusics);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(await FirebaseAuth.instance.currentUser!.uid)
          .update({"num_music": FieldValue.increment(1)}).then(
        (res) => Get.to(() => musicSteps(music),
            transition: Transition.rightToLeftWithFade, arguments: {music}),
        onError: (e) => print("Error completing: $e"),
      );
    }
    loading.value = false;
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
        /*    created_at: now,
          updated_at: now */
      );
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
        (res) => Get.to(() => musicSteps(music),
            transition: Transition.rightToLeftWithFade,
            arguments: {"title": mu.Title, "currentStep": mu.currentStep}),
        onError: (e) => print("Error completing: $e"),
      );
      loading.value = false;
    }
    loading.value = false;

    update();
  }

  Future<void> addMusic() async {
    loading.value = true;
    var now = DateTime.now().toString();

    bool isvalidate = titlekey.currentState!.validate();
    if (isvalidate) {
      print(isvalidate);

      final DocumentReference ref = FirebaseFirestore.instance
          .collection("Music")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("MusicList")
          .doc();
      print(ref.id);
      Music music = Music(
          Title: musicTitle.value,
          currentStep: 1,
          created_at: now,
          updated_at: now,
          id: ref.id.toString());
      mu = music;
      ref.set(music.toFirestore()).then((value) {
        Get.off(() => musicSteps(music),
            transition: Transition.rightToLeftWithFade,
            arguments: {"title": mu.Title, "currentStep": mu.currentStep});
      }).catchError((e) {
        print("errreur " + e);
      });
    }
    loading.value = false;
  }

  Future<void> getmymusic() async {
    mymusicList = [];
    loadingMusicLIst.value = true;
    final MusicCollection = await FirebaseFirestore.instance
        .collection('Music')
        .withConverter(
            fromFirestore: UserMusics.fromFirestore,
            toFirestore: (UserMusics userMusic, options) =>
                userMusic.toFirestore())
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final docSnap = await MusicCollection.get();
    final result = docSnap.data();
    if (result != null) {
      print("The list : $result");
      result.MusicList!.forEach((element) {
        mymusicList.add(element);
      });
    } else {
      print("error");
    }
    loadingMusicLIst.value = false;
  }
}
