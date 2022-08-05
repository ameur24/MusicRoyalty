import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/music_steps.dart';
import 'package:music_royalty/Screens/main/music_steps/step_view.dart';
import 'package:music_royalty/Utils/constants.dart';

import '../../../Utils/colors.dart';
import '../../../Widgets/buttons/button_with_icon.dart';
import '../../../controllers/music_controller.dart';

class StepInfo extends GetView<MusicController> {
  const StepInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MusicController());
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(Get.arguments["StepTitle"]);
    return Scaffold(
        backgroundColor: MyColors.blackbackground2,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.to(() => const musicSteps()),
              icon: Icon(Icons.arrow_back)),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: MyColors.blackbackground2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
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
                      Get.arguments['id'] == 4 ||
                              Get.arguments['id'] == 5 ||
                              Get.arguments['id'] == 7 ||
                              Get.arguments['id'] == 9
                          ? Text(
                              "Select a Music ${Get.arguments['StepTitle']} Service",
                              style: TextStyle(
                                  fontFamily: "Exo-Bold",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          : Text(
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
                      Get.arguments['id'] == 4 ||
                              Get.arguments['id'] == 5 ||
                              Get.arguments['id'] == 7 ||
                              Get.arguments['id'] == 9
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * .2),
                              child: DropdownButtonFormField<dynamic>(
                                  decoration: InputDecoration(
                                      hoverColor: MyColors.MainYellow,
                                      focusColor: MyColors.MainYellow,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColors.MainYellow,
                                            width: 2.0),
                                      )),
                                  dropdownColor: MyColors.blackbackground2,
                                  items: options(),
                                  focusColor: MyColors.MainYellow,
                                  onChanged: (val) =>
                                      controller.selectedSite.value = val),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                              ],
                            )
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * .35),
                ButtonWithIcon(
                  onPressed: () {
                    Get.to(() => stepView(), arguments: {
                      "StepTitle": Get.arguments["StepTitle"],
                      "id": Get.arguments["id"]
                    });
                  },
                  iconCol: MyColors.mainGrey,
                  text: "Get My ${Get.arguments["StepTitle"]}",
                  MainColor: MyColors.MainYellow,
                ),
                SizedBox()
              ]),
        ));
  }

  List<DropdownMenuItem<dynamic>> options() {
    List<DropdownMenuItem<dynamic>> WhatOptions = [];
    switch (Get.arguments["id"]) {
      case 4:
        WhatOptions = [
          DropdownMenuItem(
              child: Text(
                constants.websites[2],
                style: TextStyle(color: Colors.white70),
              ),
              value: 2),
          DropdownMenuItem(
              child: Text(
                constants.websites[3],
                style: TextStyle(color: Colors.white70),
              ),
              value: 3),
          DropdownMenuItem(
              child: Text(
                constants.websites[4],
                style: TextStyle(color: Colors.white70),
              ),
              value: 4)
        ].toList();
        break;
      case 5:
        WhatOptions = [
          DropdownMenuItem(
              child: Text(
                constants.websites[5],
                style: TextStyle(color: Colors.white70),
              ),
              value: 5),
          DropdownMenuItem(
              child: Text(
                constants.websites[6],
                style: TextStyle(color: Colors.white70),
              ),
              value: 6),
          DropdownMenuItem(
              child: Text(
                constants.websites[7],
                style: TextStyle(color: Colors.white70),
              ),
              value: 7),
          DropdownMenuItem(
              child: Text(
                constants.websites[8],
                style: TextStyle(color: Colors.white70),
              ),
              value: 8),
          DropdownMenuItem(
              child: Text(
                constants.websites[9],
                style: TextStyle(color: Colors.white70),
              ),
              value: 9),
          DropdownMenuItem(
              child: Text(
                constants.websites[10],
                style: TextStyle(color: Colors.white70),
              ),
              value: 10),
          DropdownMenuItem(
              child: Text(
                constants.websites[11],
                style: TextStyle(color: Colors.white70),
              ),
              value: 11),
          DropdownMenuItem(
              child: Text(
                constants.websites[12],
                style: TextStyle(color: Colors.white70),
              ),
              value: 12),
          DropdownMenuItem(
              child: Text(
                constants.websites[13],
                style: TextStyle(color: Colors.white70),
              ),
              value: 13),
          DropdownMenuItem(
              child: Text(
                constants.websites[14],
                style: TextStyle(color: Colors.white70),
              ),
              value: 14),
        ].toList();
        break;
      case 7:
        WhatOptions = [
          DropdownMenuItem(
              child: Text(
                constants.websites[16],
                style: TextStyle(color: Colors.white70),
              ),
              value: 16),
          DropdownMenuItem(
              child: Text(
                constants.websites[17],
                style: TextStyle(color: Colors.white70),
              ),
              value: 17),
          DropdownMenuItem(
              child: Text(
                constants.websites[18],
                style: TextStyle(color: Colors.white70),
              ),
              value: 18),
        ].toList();
        break;
      case 9:
        WhatOptions = [
          DropdownMenuItem(
              child: Text(
                constants.websites[20],
                style: TextStyle(color: Colors.white70),
              ),
              value: 20),
          DropdownMenuItem(
              child: Text(
                constants.websites[21],
                style: TextStyle(color: Colors.white70),
              ),
              value: 21),
          DropdownMenuItem(
              child: Text(
                constants.websites[22],
                style: TextStyle(color: Colors.white70),
              ),
              value: 22),
          DropdownMenuItem(
              child: Text(
                constants.websites[23],
                style: TextStyle(color: Colors.white70),
              ),
              value: 23),
          DropdownMenuItem(
              child: Text(
                constants.websites[24],
                style: TextStyle(color: Colors.white70),
              ),
              value: 24),
          DropdownMenuItem(
              child: Text(
                constants.websites[25],
                style: TextStyle(color: Colors.white70),
              ),
              value: 25),
        ].toList();
        break;
    }
    return WhatOptions;
  }
}
