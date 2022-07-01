import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/Widgets/Texts/big_text.dart';
import 'package:music_royalty/Widgets/music_details.dart';

import '../../Widgets/buttons/button_with_icon.dart';
import '../../Widgets/menu.dart';
import 'music_steps/music_steps.dart';
import 'music_steps/music_title.dart';

class myMusic extends StatelessWidget {
  const myMusic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.blackbackground1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: circularMenu(),
        elevation: 0,
        toolbarHeight: screenHeight * .1,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * .022, horizontal: screenWidth * .09),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                primary: MyColors.MainYellow,
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * .01,
                    horizontal: screenWidth * .05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(167, 167, 18, 0.6100000143051147),
                        offset: Offset(0, 4),
                        blurRadius: 16)
                  ],
                ),
                child: Text(
                  "Add Music",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    color: MyColors.mainGrey,
                    fontFamily: 'Exo-Black',
                  ),
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    barrierColor: Colors.black38,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return musicTitle();
                    },
                    context: context);
              },
            ),
          )
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(children: [
            SizedBox(
              height: screenHeight * .03,
            ),
            BigText(text: "My Music"),
            SizedBox(
              height: screenHeight * .02,
            ),
            MusicDetails(
              screenHeight: screenHeight,
              screenwidth: screenWidth,
            ),
            MusicDetails(
              onPressed: () =>
                  Get.to(musicSteps(), transition: Transition.downToUp),
              screenHeight: screenHeight,
              screenwidth: screenWidth,
            ),
            MusicDetails(
              screenHeight: screenHeight,
              screenwidth: screenWidth,
            ),
            MusicDetails(
              screenHeight: screenHeight,
              screenwidth: screenWidth,
            ),
            MusicDetails(
              screenHeight: screenHeight,
              screenwidth: screenWidth,
            ),
            MusicDetails(
              screenHeight: screenHeight,
              screenwidth: screenWidth,
            ),
          ]),
        ),
        Positioned(
            bottom: screenHeight * .1,
            right: screenWidth * .1,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: MyColors.MainYellow,
              child: Icon(
                Icons.question_mark,
                color: MyColors.mainGrey,
              ),
            ))
      ]),
    );
  }
}
