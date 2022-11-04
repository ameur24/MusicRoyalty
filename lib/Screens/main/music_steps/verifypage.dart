import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:music_royalty/Screens/Authentication/sign_up_google.dart';

import '../../../controllers/verifyemailcontroller.dart';

class VerifyPage extends GetView<Verifyemailcontroller> {
  @override
  Widget build(BuildContext context) {
    Get.put(Verifyemailcontroller());
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(() => Container(
        child: controller.isEmailverified.value == true
            ? Get.put(signup_google())
            : Scaffold(
                appBar: AppBar(title: Text('Verify Email')),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'A verification email have been sent to your email please check your spam folder',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: ElevatedButton.icon(
                        onPressed: controller.sendVerificationEmail,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                        ),
                        icon: Icon(
                          Icons.email,
                          size: 32,
                        ),
                        label: Text(
                          'Resend Email',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              )));
  }
}
