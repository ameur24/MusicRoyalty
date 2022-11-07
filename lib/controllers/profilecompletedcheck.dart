import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class checkcompletedController extends GetxController {
  var userisComplete = false.obs;
  var isEmailverified = false.obs;
  var musicExists = false.obs;
  var isDone = false.obs;
  @override
  void onInit() async {
    isEmailverified.value =
        await FirebaseAuth.instance.currentUser!.emailVerified;
    userisComplete.value = await handleCreatedState("users");
    print(userisComplete.value);

    final MusicCollection = await FirebaseFirestore.instance
        .collection('Music')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MusicList');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await MusicCollection.get();

    // Get data from docs and convert map to List

    if (querySnapshot.docs.isNotEmpty) {
      musicExists.value = true;
    }
    print(musicExists.value);
    isDone.value = true;
    super.onInit();
  }
}

handleCreatedState(String url) async {
  print(FirebaseAuth.instance.currentUser!.uid);
  final ref = await FirebaseFirestore.instance
      .collection(url)
      .doc(FirebaseAuth.instance.currentUser!.uid);
  final docSnap = await ref.get();
  final user = docSnap.data();
  print(user);
  if (user != null) {
    return true;
  } else {
    return false;
  }
  /*  final ref = FirebaseDatabase.instance.ref();
  final userid = FirebaseAuth.instance.currentUser!.uid;

  
  final snapshot = await ref.child('users/$userid').get();
  print(userid);
  if (snapshot.exists) {
    print("data");
    return true;
  } else {
    print("no data");
    return false;
  } */
}
