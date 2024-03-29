import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:music_royalty/Screens/Authentication/sign_up_google.dart';
import 'package:music_royalty/Screens/main/empty_main.dart';
import 'package:music_royalty/Screens/main/music_steps/verifypage.dart';
import 'package:music_royalty/Screens/main/mymusic.dart';

import '../../../controllers/profilecompletedcheck.dart';

class Checker extends GetView<checkcompletedController> {
  @override
  Widget build(BuildContext context) {
    Get.put(checkcompletedController());

    return Obx(() => controller.isDone == true
        ? controller.userisComplete.value == true &&
                controller.musicExists.value == true
            ? myMusic()
            : controller.userisComplete.value == true &&
                    controller.musicExists.value == false
                ? EmptyMain()
                : controller.userisComplete.value == false &&
                        controller.isEmailverified.value == true
                    ? signup_google()
                    : controller.userisComplete.value == false &&
                            controller.isEmailverified.value == false
                        ? VerifyPage()
                        : SizedBox.shrink()
        : Dialog(
            backgroundColor: Colors.black.withOpacity(0.3),
            child: Center(child: CircularProgressIndicator())));

/*         ? controller.userisComplete.value == true
            ? controller.musicExists.value == false
                ? EmptyMain()
                : myMusic()
            : controller.isEmailverified.value == true
                ? signup_google()
                : VerifyPage()
        : Dialog(
            backgroundColor: Colors.black.withOpacity(0.3),
            child: Center(child: CircularProgressIndicator()),
          ));
  } */
  }
}
