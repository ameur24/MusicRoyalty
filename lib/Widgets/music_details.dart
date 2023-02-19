import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:music_royalty/Services/date_time_converter.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/Utils/itemslistmodel.dart';
import 'package:music_royalty/models/music.dart';

class MusicDetails extends StatelessWidget {
  final double screenHeight, screenwidth;
  final Function? onPressed;
  final Music music;

  final Function(dynamic)? menuItemSelected;
  final int? val;
  const MusicDetails({
    Key? key,
    required this.screenHeight,
    required this.screenwidth,
    this.onPressed,
    this.menuItemSelected,
    required this.music,
    this.val,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lastupdate =
        DateFormat("MM/dd/yyyy").format(DateTime.parse(music.created_at!));
    //String Timeago = convertToAgo(Lastupdate);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
          splashColor: MyColors.MainYellow,
          onTap: onPressed as void Function()?,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    offset: Offset(0, 2),
                    blurRadius: 12)
              ],
              color: Color.fromRGBO(18, 18, 18, 1),
              border: Border.all(
                color: Color.fromRGBO(83, 83, 83, 1),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          music.Title!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(226, 226, 33, 1),
                              fontFamily: 'Exo-SemiBold',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        PopupMenuButton<dynamic>(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: MyColors.mainGrey,
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<dynamic>>[
                            PopupMenuItem(
                                child: Text(
                              "Update Name",
                              style: TextStyle(color: Colors.white),
                            )),
                            PopupMenuItem(
                                onTap: () => remove(context),
                                child: Text(
                                  "Remove",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: screenwidth * .75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromRGBO(31, 31, 31, 1),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Text(
                        '${music.currentStep}/${itemmodeldummy.itemmodelslist.length} Steps completed',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(251, 251, 251, 1),
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Last updated on ${lastupdate.toString()}', //$Timeago',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(185, 185, 185, 1),
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ]),
            ),
          )),
    );
  }

  void remove(BuildContext context) {
    Get.back();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Get.dialog(BackdropFilter(
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
                Expanded(
                  child: Text(
                      "Are you sure you want to remove ${music.Title} ?  All your progress will be lost forever",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      color: MyColors.MainYellow,
                      onPressed: () {
                        // do something
                        Navigator.pop(context);
                      },
                      child: SizedBox(child: Center(child: Text("Not Yet"))),
                    ),
                    MaterialButton(
                      color: MyColors.MainYellow,
                      onPressed: () {
                        print("firebase");
                        Navigator.pop(context);
                        try {
                          FirebaseFirestore.instance
                              .collection('Music')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('MusicList')
                              .doc(music.id)
                              .delete()
                              .then((value) {})
                              .catchError((e) {
                            print(e);
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: SizedBox(child: Center(child: Text("Done"))),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
