import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/step_info.dart';
import 'package:music_royalty/Utils/itemslistmodel.dart';

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
            onPressed: () => Get.to(() => const myMusic()),
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
                            if (itemmodeldummy.itemmodelslist[index].thisStep <=
                                controller.musiccurrentstep.value) {
                              Get.to(StepInfo(thisMusic), arguments: {
                                "StepTitle":
                                    itemmodeldummy.itemmodelslist[index].text,
                                "id": itemmodeldummy
                                    .itemmodelslist[index].thisStep
                              })!
                                  .then((_) {
                                print("hhh");
                                if (controller.musiccurrentstep.value ==
                                    itemmodeldummy
                                        .itemmodelslist[index].thisStep)
                                  return showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        double screenHeight =
                                            MediaQuery.of(context).size.height;
                                        double screenWidth =
                                            MediaQuery.of(context).size.width;
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          insetPadding: EdgeInsets.all(10),
                                          child: Container(
                                            width: screenWidth * 0.9,
                                            height: screenHeight * 0.28,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: MyColors.mainblack),
                                            padding: EdgeInsets.fromLTRB(
                                                20, 50, 20, 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "Did you finish this Step?",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                    textAlign:
                                                        TextAlign.center),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    MaterialButton(
                                                      color: Colors
                                                          .deepPurple[200],
                                                      onPressed: () {
                                                        // do something
                                                        Navigator.pop(context);
                                                      },
                                                      child: SizedBox(
                                                          width: screenWidth *
                                                              0.12,
                                                          child: Center(
                                                              child: Text(
                                                                  "Not Yet"))),
                                                    ),
                                                    MaterialButton(
                                                      color: Colors
                                                          .deepPurple[200],
                                                      onPressed: () async {
                                                        print("firebase");
                                                        try {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Music')
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection(
                                                                  'MusicList')
                                                              .doc(thisMusic.id)
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
                                                            Navigator.pop(
                                                                context);
                                                          }).catchError((e) {
                                                            print(e);
                                                          });
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      },
                                                      child: SizedBox(
                                                          width: screenWidth *
                                                              0.12,
                                                          child: Center(
                                                              child: Text(
                                                                  "Done"))),
                                                    )
                                                  ],
                                                )
                                              ],
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.deepPurple[400]),
                                ),
                                messageText: Text(
                                  "Please Finish Step ${controller.musiccurrentstep.value} before",
                                  style: TextStyle(
                                      fontSize: 16,
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
          "Music name",
          style: TextStyle(
              fontFamily: "Exo-Medium", color: Colors.white, fontSize: 13),
        ),
        SizedBox(
          height: screenHeight * 0.005,
        ),
        Text(
          thisMusic.Title!,
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
