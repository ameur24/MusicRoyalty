import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/Authentication/landing_page.dart';
import 'package:music_royalty/Utils/colors.dart';

import '../../Widgets/froms/input_field.dart';
import '../../controllers/forgotpasscontroller.dart';

class ForgotPasswordScreen extends GetView<ForgotPassController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Get.put(ForgotPassController());
    return Scaffold(
      backgroundColor: MyColors.mainblack,
      appBar: AppBar(
          foregroundColor: MyColors.MainYellow,
          backgroundColor: MyColors.mainblack,
          title: Text('Reset Password')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidht * 0.9,
            child: Text(
              'Receive an email to reset your password.',
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Center(
            child: SizedBox(
                width: screenWidht * 0.90,
                child: Myinput(
                  labelText: "Email",
                  controller: controller.email.value,
                  validate: (v) => v != null && !EmailValidator.validate(v)
                      ? 'Enter a valid email'
                      : null,
                  onChanged: (value) {
                    final val = TextSelection.collapsed(
                        offset: controller.email.value.text.length);
                    controller.email.value.selection = val;
                  },
                )),
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            width: screenWidht * 0.90,
            child: ElevatedButton.icon(
              onPressed: () {
                verifyemail(controller.email.value.text);
              },
              style: ElevatedButton.styleFrom(
                primary: MyColors.MainYellow,
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.email,
                size: 32,
                color: Colors.white,
              ),
              label: Text(
                'Reset Password',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future verifyemail(mail) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
    Get.snackbar("", "",
        titleText: Text(
          "Password Reset link Sent to ${mail}. ",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        snackPosition: SnackPosition.BOTTOM);
    Get.to(landingPage());
  } on FirebaseAuthException catch (e) {
    Get.snackbar("", e.message.toString(),
        colorText: Colors.white,
        backgroundColor: MyColors.MainYellow,
        snackPosition: SnackPosition.BOTTOM);
  }
}
