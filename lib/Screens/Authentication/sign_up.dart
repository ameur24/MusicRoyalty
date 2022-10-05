import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/Widgets/Texts/big_text.dart';
import 'package:music_royalty/Widgets/Texts/labels_text.dart';
import 'package:music_royalty/Widgets/froms/input_field.dart';
import 'package:music_royalty/Widgets/froms/text_input.dart';

import '../../controllers/sign_up_controller.dart';

class signup extends GetView<SignUpController> {
  const signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Get.put(SignUpController());
    return Scaffold(
      backgroundColor: MyColors.mainblack,
      appBar: AppBar(
        backgroundColor: MyColors.mainblack,
        foregroundColor: Colors.white,
        title: Text(
          "New Account",
          style: TextStyle(color: MyColors.MainYellow),
        ),
        elevation: 0,
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * .05,
                ),
                Text(
                  "Personal Details",
                  style: TextStyle(
                    color: MyColors.MainYellow,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * .44,
                        child: Myinput(labelText: "Name")),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    SizedBox(
                        width: screenWidth * .44,
                        child: Myinput(
                          labelText: "Middle Name",
                        )),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                Myinput(labelText: "Last Name"),
                SizedBox(
                  height: screenHeight * .02,
                ),
                Myinput(
                  labelText: "Date of Birth",
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                Text(
                  "Contact Details",
                  style: TextStyle(
                    color: MyColors.MainYellow,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: screenHeight * .01,
                ),
                Myinput(
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                Myinput(
                  labelText: "Phone number",
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                Myinput(labelText: "Adress"),
                SizedBox(
                  height: screenHeight * .02,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * .44,
                        child: Myinput(labelText: "State")),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    SizedBox(
                        width: screenWidth * .44,
                        child: Myinput(
                          labelText: "ZIP code",
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style:
                            TextStyle(color: MyColors.mainblack, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        backgroundColor: MyColors.MainYellow,
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * .026,
                            horizontal: screenWidth * .355),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* body: Column(
        children: [
          SizedBox(
            height: screenHeight * .1,
          ),
          BigText(
            text: "Profile Details",
            textAlign: TextAlign.center,
          ),
          Container(
              height: screenHeight * .65,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .05, vertical: screenHeight * .03),
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * .1, vertical: screenHeight * .03),
              decoration: BoxDecoration(
                  border: Border.all(color: MyColors.BordersGrey),
                  borderRadius: BorderRadius.circular(20)),
              child: ListView(
                physics: const ScrollPhysics(),
                children: [
                  TextInput(
                    labelText: "First Name",
                    textInputAction: TextInputAction.next,
                  ),
                  TextInput(
                    labelText: "Last Name",
                    textInputAction: TextInputAction.next,
                  ),
                  TextInput(
                    labelText: "Email",
                    textInputAction: TextInputAction.next,
                  ),
                  TextInput(
                    labelText: "Phone Number",
                    textInputAction: TextInputAction.next,
                  ),
                  LabelsText(
                    text: "Date of Birth",
                    color: MyColors.MainYellow,
                  ),
                  TextInput(
                    labelText: "Adress",
                    textInputAction: TextInputAction.next,
                  ),
                  Row(
                    children: [
                      TextInput(
                        labelText: "State",
                        textInputAction: TextInputAction.next,
                      ),
                      TextInput(
                        labelText: "Zip",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  )
                ],
              )),
        ],
      )*/