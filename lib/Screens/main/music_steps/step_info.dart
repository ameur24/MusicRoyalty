import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/music_steps.dart';
import 'package:music_royalty/Screens/main/music_steps/splitsheet.dart';
import 'dart:ui' show ImageFilter;
import 'package:music_royalty/Screens/main/music_steps/webview.dart';
import 'package:music_royalty/Utils/constants.dart';
import 'package:music_royalty/controllers/stepinfocontroller.dart';

import '../../../Utils/colors.dart';
import '../../../Widgets/buttons/button_with_icon.dart';

import '../../../controllers/musicstepscontroller.dart';
import '../../../models/music.dart';

class StepInfo extends GetView<stepinfocontroller> {
  final Music m;
  const StepInfo(this.m, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(Get.arguments["StepTitle"]);

    Get.put(stepinfocontroller());
    Mymusicstepscontroller mcontroller = Get.find<Mymusicstepscontroller>();
    Get.put(Mymusicstepscontroller(music: m));
    controller.setselectedSite(0);
    return Scaffold(
        backgroundColor: MyColors.blackbackground2,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                print(Get.arguments['id']);
                if (Get.arguments['id'] != m.currentStep) {
                  Get.to(() => musicSteps(m));
                } else {
                  Get.to(() => musicSteps(m));

                  showDialog(
                      context: context,
                      builder: (ctx) {
                        double screenHeight =
                            MediaQuery.of(context).size.height;
                        double screenWidth = MediaQuery.of(context).size.width;
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.all(10),
                            child: Container(
                              width: screenWidth * 0.8,
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: MyColors.mainblack),
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Did you finish this Step?",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                      textAlign: TextAlign.center),
                                  SizedBox(height: screenHeight * 0.03),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MaterialButton(
                                        color: MyColors.MainYellow,
                                        onPressed: () {
                                          // do something
                                          Navigator.pop(context);
                                        },
                                        child: SizedBox(
                                            child:
                                                Center(child: Text("Not Yet"))),
                                      ),
                                      MaterialButton(
                                        color: MyColors.MainYellow,
                                        onPressed: () {
                                          print("firebase");
                                          Navigator.pop(context);
                                          try {
                                            FirebaseFirestore.instance
                                                .collection('Music')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .collection('MusicList')
                                                .doc(m.id)
                                                .update({
                                              "CurrentStep": mcontroller
                                                      .musiccurrentstep.value +
                                                  1,
                                            }).then((value) {
                                              mcontroller.musiccurrentstep
                                                  .value = mcontroller
                                                      .musiccurrentstep.value +
                                                  1;
                                              m.currentStep =
                                                  m.currentStep! + 1;
                                            }).catchError((e) {
                                              print(e);
                                            });
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        child: SizedBox(
                                            child: Center(child: Text("Done"))),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
              icon: Icon(Icons.arrow_back)),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: MyColors.blackbackground2,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              screenWidth * .05, 0, screenWidth * .05, screenWidth * .02),
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
                          : Get.arguments['id'] == 1
                              ? SizedBox.shrink()
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
                      Get.arguments['id'] == 1
                          ? SizedBox.shrink()
                          : Get.arguments['id'] == 4 ||
                                  Get.arguments['id'] == 5 ||
                                  Get.arguments['id'] == 7 ||
                                  Get.arguments['id'] == 9
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * .2),
                                  child: DropdownButtonFormField<dynamic>(
                                      value: controller.selectedSite.value,
                                      decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColors.MainYellow,
                                            width: 2.0),
                                      )),
                                      dropdownColor: MyColors.blackbackground2,
                                      items: options(),
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
                                                          ? constants
                                                              .websites[19]
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ButtonWithIcon(
                    onPressed: () {
                      if (Get.arguments["id"] == 2 ||
                          Get.arguments["id"] == 3 ||
                          Get.arguments["id"] == 6 ||
                          Get.arguments["id"] == 8) {
                        Get.to(
                            () => webviewpage(
                                  m: m,
                                ),
                            arguments: {
                              "StepTitle": Get.arguments["StepTitle"],
                              "id": Get.arguments["id"],
                              "ssid": "",
                            });
                      }
                      if (Get.arguments["id"] == 1) {
                        Get.to(() => splitsheet(), arguments: {
                          "StepTitle": Get.arguments["StepTitle"],
                          "id": Get.arguments["id"],
                          "ssid": "",
                        });
                      } else {
                        if (controller.selectedSite.value == 0) {
                          Get.snackbar(
                            "",
                            "",
                            titleText: Text(
                              "Select a Website please",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            messageText: Text(
                              "Cant be empty select a site",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            snackPosition: SnackPosition.TOP,
                          );
                        } else {
                          var sousstep =
                              controller.selectedSite.value.toString();
                          Get.to(
                              () => webviewpage(
                                    m: m,
                                  ),
                              arguments: {
                                "StepTitle": Get.arguments["StepTitle"],
                                "id": Get.arguments["id"],
                                "ssid": sousstep,
                              });
                        }
                      }
                    },
                    iconCol: MyColors.mainGrey,
                    text: "Get My ${Get.arguments["StepTitle"]}",
                    MainColor: MyColors.MainYellow,
                  ),
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
                "Select a Site Please",
                style: TextStyle(color: Colors.white70),
              ),
              value: 0),
          DropdownMenuItem(
              child: Text(
                constants.websites[2],
                style: TextStyle(color: Colors.white70),
              ),
              value: 1),
          DropdownMenuItem(
              child: Text(
                constants.websites[3],
                style: TextStyle(color: Colors.white70),
              ),
              value: 2),
          DropdownMenuItem(
              child: Text(
                constants.websites[4],
                style: TextStyle(color: Colors.white70),
              ),
              value: 3)
        ].toList();
        break;
      case 5:
        WhatOptions = [
          DropdownMenuItem(
              child: Text(
                "Select a Site Please",
                style: TextStyle(color: Colors.white70),
              ),
              value: 0),
          DropdownMenuItem(
              child: Text(
                constants.websites[5],
                style: TextStyle(color: Colors.white70),
              ),
              value: 1),
          DropdownMenuItem(
              child: Text(
                constants.websites[6],
                style: TextStyle(color: Colors.white70),
              ),
              value: 2),
          DropdownMenuItem(
              child: Text(
                constants.websites[7],
                style: TextStyle(color: Colors.white70),
              ),
              value: 3),
          DropdownMenuItem(
              child: Text(
                constants.websites[8],
                style: TextStyle(color: Colors.white70),
              ),
              value: 4),
          DropdownMenuItem(
              child: Text(
                constants.websites[9],
                style: TextStyle(color: Colors.white70),
              ),
              value: 5),
          DropdownMenuItem(
              child: Text(
                constants.websites[10],
                style: TextStyle(color: Colors.white70),
              ),
              value: 6),
          DropdownMenuItem(
              child: Text(
                constants.websites[11],
                style: TextStyle(color: Colors.white70),
              ),
              value: 7),
          DropdownMenuItem(
              child: Text(
                constants.websites[12],
                style: TextStyle(color: Colors.white70),
              ),
              value: 8),
          DropdownMenuItem(
              child: Text(
                constants.websites[13],
                style: TextStyle(color: Colors.white70),
              ),
              value: 9),
          DropdownMenuItem(
              child: Text(
                constants.websites[14],
                style: TextStyle(color: Colors.white70),
              ),
              value: 10),
          DropdownMenuItem(
              child: Text(
                constants.websites[15],
                style: TextStyle(color: Colors.white70),
              ),
              value: 11),
        ].toList();
        break;
      case 7:
        WhatOptions = [
          DropdownMenuItem(
              child: Text(
                "Select a Site Please",
                style: TextStyle(color: Colors.white70),
              ),
              value: 0),
          DropdownMenuItem(
              child: Text(
                constants.websites[17],
                style: TextStyle(color: Colors.white70),
              ),
              value: 1),
          DropdownMenuItem(
              child: Text(
                constants.websites[18],
                style: TextStyle(color: Colors.white70),
              ),
              value: 2),
          DropdownMenuItem(
              child: Text(
                constants.websites[19],
                style: TextStyle(color: Colors.white70),
              ),
              value: 3),
        ].toList();
        break;
      case 9:
        WhatOptions = [
          DropdownMenuItem(
              child: Text(
                "Select a Site Please",
                style: TextStyle(color: Colors.white70),
              ),
              value: 0),
          DropdownMenuItem(
              child: Text(
                constants.websites[21],
                style: TextStyle(color: Colors.white70),
              ),
              value: 1),
          DropdownMenuItem(
              child: Text(
                constants.websites[22],
                style: TextStyle(color: Colors.white70),
              ),
              value: 2),
          DropdownMenuItem(
              child: Text(
                constants.websites[23],
                style: TextStyle(color: Colors.white70),
              ),
              value: 3),
          DropdownMenuItem(
              child: Text(
                constants.websites[24],
                style: TextStyle(color: Colors.white70),
              ),
              value: 4),
          DropdownMenuItem(
              child: Text(
                constants.websites[25],
                style: TextStyle(color: Colors.white70),
              ),
              value: 5),
          DropdownMenuItem(
              child: Text(
                constants.websites[26],
                style: TextStyle(color: Colors.white70),
              ),
              value: 6),
        ].toList();
        break;
    }
    return WhatOptions;
  }
}
