import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/step_info.dart';
import 'package:music_royalty/Utils/itemslistmodel.dart';
import 'dart:ui' show ImageFilter;
import 'package:music_royalty/Widgets/item.dart';
import 'package:music_royalty/controllers/musicstepscontroller.dart';

import 'package:music_royalty/models/music.dart';

import '../../../Utils/colors.dart';

import '../mymusic.dart';

class musicSteps extends GetView<Mymusicstepscontroller> {
  final Music thisMusic;
  musicSteps(this.thisMusic, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("current stepe ====" + thisMusic.currentStep.toString());

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    //int current = 1 + controller.mu.currentStep!;
    Get.put(Mymusicstepscontroller(music: thisMusic));

    return Scaffold(
      backgroundColor: MyColors.blackbackground1,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.offAll(() => myMusic()),
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: MyColors.blackbackground1,
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
              child: SongName(screenHeight)),
          Expanded(
              child: ListView.builder(
                  itemCount: itemmodeldummy.itemmodelslist.length,
                  itemBuilder: (context, index) {
                    return Obx(() => item(
                          text: itemmodeldummy.itemmodelslist[index].text,
                          description:
                              itemmodeldummy.itemmodelslist[index].description,
                          current: controller.musiccurrentstep.value,
                          thisStep:
                              itemmodeldummy.itemmodelslist[index].thisStep,
                          clickme: () {
                            if (itemmodeldummy.itemmodelslist[index].thisStep ==
                                10) {
                              Get.snackbar(
                                "",
                                "",
                                titleText: Text(
                                  "Step${itemmodeldummy.itemmodelslist[index].thisStep} is under construction",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                messageText: Text(
                                  "Please Comback later",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            if (itemmodeldummy.itemmodelslist[index].thisStep <=
                                controller.musiccurrentstep.value) {
                              Get.to(StepInfo(thisMusic), arguments: {
                                "StepTitle":
                                    itemmodeldummy.itemmodelslist[index]!.text,
                                "id": itemmodeldummy
                                    .itemmodelslist[index]!.thisStep
                              })!
                                  .then((_) {
                                if (controller.musiccurrentstep.value ==
                                    itemmodeldummy
                                        .itemmodelslist[index].thisStep)
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        double screenHeight =
                                            MediaQuery.of(context).size.height;
                                        double screenWidth =
                                            MediaQuery.of(context).size.width;
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Dialog(
                                            backgroundColor: Colors.transparent,
                                            insetPadding: EdgeInsets.all(10),
                                            child: Container(
                                              width: screenWidth * 0.8,
                                              height: 180,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: MyColors.mainblack),
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 50, 20, 20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Did you finish this Step?",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.03),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      MaterialButton(
                                                        color:
                                                            MyColors.MainYellow,
                                                        onPressed: () {
                                                          // do something
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: SizedBox(
                                                            child: Center(
                                                                child: Text(
                                                                    "Not Yet"))),
                                                      ),
                                                      MaterialButton(
                                                        color:
                                                            MyColors.MainYellow,
                                                        onPressed: () {
                                                          print("firebase");
                                                          Navigator.pop(
                                                              context);
                                                          try {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Music')
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                                .collection(
                                                                    'MusicList')
                                                                .doc(thisMusic
                                                                    .id)
                                                                .update({
                                                              "CurrentStep":
                                                                  controller
                                                                          .musiccurrentstep
                                                                          .value +
                                                                      1,
                                                            }).then((value) {
                                                              controller
                                                                  .musiccurrentstep
                                                                  .value = controller
                                                                      .musiccurrentstep
                                                                      .value +
                                                                  1;

                                                              thisMusic
                                                                      .currentStep =
                                                                  thisMusic
                                                                          .currentStep! +
                                                                      1;
                                                            }).catchError((e) {
                                                              print(e);
                                                            });
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        },
                                                        child: SizedBox(
                                                            child: Center(
                                                                child: Text(
                                                                    "Done"))),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                              });
                            } else {
                              Get.snackbar(
                                "",
                                "",
                                titleText: Text(
                                  "Step${itemmodeldummy.itemmodelslist[index].thisStep} is Locked",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                messageText: Text(
                                  "Please Finish Step ${controller.musiccurrentstep.value} before",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                        ));
                  })),
        ],
      ),
    );
  }

  Widget SongName(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenHeight * .05,
        ),
        Text(
          "Song Name",
          style: TextStyle(
              fontFamily: "Exo-Medium", color: Colors.white, fontSize: 13),
        ),
        SizedBox(
          height: screenHeight * 0.005,
        ),
        Text(
          thisMusic.Title!.capitalizeFirst!,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: MyColors.MainYellow,
              fontFamily: 'Exo-ExtraBold',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2),
        ),
        SizedBox(
          height: screenHeight * .015,
        ),
        Text(
          "Now that you have recorded your music , here are the next steps",
          style: TextStyle(
              fontFamily: "Exo-Medium", color: Colors.white, fontSize: 14),
        ),
        SizedBox(
          height: screenHeight * .03,
        )
      ],
    );
  }
}
