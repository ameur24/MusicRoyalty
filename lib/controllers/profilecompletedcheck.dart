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
    musicExists.value = await handleCreatedState("Music");
    isDone.value = true;
    super.onInit();
  }
}

handleCreatedState(String url) async {
  final ref = await FirebaseFirestore.instance
      .collection(url)
      .doc(FirebaseAuth.instance.currentUser!.uid);
  final docSnap = await ref.get();
  final user = docSnap.data();
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
