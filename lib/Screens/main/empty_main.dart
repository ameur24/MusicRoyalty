import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/Widgets/Texts/big_text.dart';
import 'package:music_royalty/Widgets/Texts/hint_text.dart';
import 'package:music_royalty/Widgets/froms/input_field.dart';
import 'package:music_royalty/Widgets/menu.dart';

import '../../Widgets/buttons/button_with_icon.dart';
import '../../controllers/user_controller.dart';
import 'music_steps/music_title.dart';

class EmptyMain extends StatelessWidget {
  EmptyMain({Key? key}) : super(key: key);

  final fullName =
      FirebaseAuth.instance.currentUser!.displayName.toString().split(" ");
  @override
  Widget build(BuildContext context) {
    UserController controller = Get.find<UserController>();
    Get.put(UserController());

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(children: [
      AnimatedContainer(
        width: screenWidth,
        curve: Curves.easeInOutBack,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
              // BlendMode.colorDodge
              image: AssetImage('assets/splash.png'),
              fit: BoxFit.fitWidth),
        ),
        duration: const Duration(seconds: 20),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * .1,
            ),
            Row(
              children: [
                circularMenu(),
                /*   CircleAvatar(
                  backgroundColor: MyColors.mainblack,
                  child: Icon(
                    Icons.music_note,
                    color: MyColors.MainYellow,
                  ),
                ), */
                Obx(() => Text(
                    FirebaseAuth.instance.currentUser!.displayName != null
                        ? "  Welcome ${fullName[0]}"
                        : controller.loading.value
                            ? ""
                            : "  Welcome ${controller.userModel.first_name.toString()}",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white70,
                        fontFamily: 'Exo-Black',
                        fontSize: 22))),
              ],
            ),
            Spacer(),
            Text(
              "Let’s create your first masterpiece",
              textAlign: TextAlign.left,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: MyColors.MainYellow,
                  fontFamily: 'Exo-Black',
                  fontSize: 46,
                  height: 1.2),
            ),
            SizedBox(
              height: screenHeight * .08,
            ),
            ButtonWithIcon(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    barrierColor: Colors.black38,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return musicTitle(
                        isEmptyMain: true,
                      );
                    },
                    context: context);
              },
              iconCol: MyColors.mainGrey,
              text: "Get Started",
              MainColor: MyColors.MainYellow,
            ),
            SizedBox(
              height: screenHeight * .04,
            ),
          ],
        ),
      )
    ]);
  }
}
