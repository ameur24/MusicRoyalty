import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/Authentication/landing_page.dart';

import '../Utils/colors.dart';

class circularMenu extends StatelessWidget {
  const circularMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: MyColors.mainblack,
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Get.off(landingPage());
      },
      child: Icon(
        Icons.music_note,
        color: MyColors.MainYellow,
      ),
    );
  }
}
