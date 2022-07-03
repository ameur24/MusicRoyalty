import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Utils/constants.dart';

import '../../../Utils/colors.dart';
import '../../../Widgets/buttons/button_with_icon.dart';

class StepInfo extends StatelessWidget {
  const StepInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(Get.arguments["StepTitle"]);
    return Scaffold(
        backgroundColor: MyColors.blackbackground2,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: MyColors.blackbackground2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * .05,
                ),
                Text(
                  "Get your Music ${Get.arguments['StepTitle']}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Exo-Black",
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                Text(
                  constants.infos[Get.arguments['id'] - 1],
                  style: TextStyle(
                      fontFamily: "Exo-Medium",
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(
                  height: screenHeight * .05,
                ),
                Text(
                  "What you need to do",
                  style: TextStyle(
                      fontFamily: "Exo-Bold",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                Row(
                  children: [
                    Text(
                      "1.  Create an account in ",
                      style: TextStyle(
                          fontFamily: "Exo-Medium",
                          fontSize: 15,
                          color: Colors.white),
                    ),
                    Text(
                      Get.arguments['id'] == 2
                          ? constants.websites[0]
                          : Get.arguments['id'] == 3
                              ? constants.websites[1]
                              : Get.arguments['id'] == 6
                                  ? constants.websites[15]
                                  : Get.arguments['id'] == 8
                                      ? constants.websites[19]
                                      : "x",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "Exo-Medium",
                          fontSize: 15,
                          color: MyColors.MainYellow),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .006,
                ),
                Text(
                  "2.  Click on the button bellow",
                  style: TextStyle(
                      fontFamily: "Exo-Medium",
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(
                  height: screenHeight * .006,
                ),
                Text(
                  "3.  Carefully fill out all the required fields",
                  maxLines: 2,
                  style: TextStyle(
                      fontFamily: "Exo-Medium",
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(height: screenHeight * .35),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonWithIcon(
                    onPressed: () {},
                    iconCol: MyColors.mainGrey,
                    text: "Get My ${Get.arguments["StepTitle"]}",
                    MainColor: MyColors.MainYellow,
                  ),
                )
              ]),
        ));
  }
}
