import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/controllers/music_controller.dart';

import '../../../Widgets/Texts/big_text.dart';
import '../../../Widgets/froms/input_field.dart';

class musicTitle extends StatelessWidget {
  final bool isEmptyMain;
  musicTitle({Key? key, required this.isEmptyMain}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    MusicController controller = Get.put(MusicController());
    return SingleChildScrollView(
        child: Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          height: screenHeight * .45,
          decoration: BoxDecoration(
              color: MyColors.mainblack,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: screenHeight * .02,
                ),
                Text(
                  'Get Started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: MyColors.MainYellow,
                      fontFamily: 'Exo-Bold',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 1.2),
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: MyColors.MainYellow,
                    ),
                    SizedBox(
                      width: screenWidth * .05,
                    ),
                    Expanded(
                      child: BigText(
                        color: Colors.white60,
                        overflow: TextOverflow.clip,
                        text:
                            "Now that you have recorded your music , it's time for the next steps.. ",
                        size: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                BigText(
                  overflow: TextOverflow.clip,
                  text: "Let's start by getting your music name",
                  size: 18,
                ),
                SizedBox(
                  height: screenHeight * .015,
                ),
                Form(
                  key: controller.titlekey,
                  child: Myinput(
                      onChanged: (v) => controller.musicTitle.value = v,
                      validate: (v) => controller.validateThese(v!),
                      labelText: "Music name",
                      textInputAction: TextInputAction.done),
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                Center(
                  child: Obx(() => ElevatedButton(
                      onPressed: () async => await controller.addMusic(),
                      child: controller.loading == false
                          ? Text(
                              'Next',
                              style: TextStyle(
                                color: MyColors.mainblack,
                                fontSize: 16,
                                fontFamily: 'Exo-Bold',
                              ),
                            )
                          : const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        backgroundColor: MyColors.MainYellow,
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * .026,
                            horizontal: screenWidth * .37),
                      ))),
                )
              ],
            ),
          )),
    ));
  }
}
