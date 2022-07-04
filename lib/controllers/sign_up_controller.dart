import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // will use 1 for google and 2 for email , 0 will be default
  var signupmode = 0.obs;

  @override
  void onInit() {
    super.onInit();
    GetUser();
  }

  void GetUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.displayName);
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    }
  }
}
