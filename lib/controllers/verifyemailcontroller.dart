import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Verifyemailcontroller extends GetxController {
  var isEmailverified = false.obs;
  var canResendemail = false.obs;
  Timer? timer;
  @override
  void onInit() {
    isEmailverified.value = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailverified.value) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }

    super.onInit();
  }

  @override
  void dispose() {
    timer?.cancel(); // TODO: implement dispose
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    isEmailverified.value = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isEmailverified.value) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      canResendemail.value = false;
      await Future.delayed(Duration(seconds: 5));
      canResendemail.value = true;
    } catch (e) {
      print(e);
    }
  }
}
