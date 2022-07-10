import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/Utils/constants.dart';
import 'package:music_royalty/Widgets/Texts/big_text.dart';
import 'package:music_royalty/Widgets/Texts/labels_text.dart';
import 'package:music_royalty/Widgets/froms/autp_complete.dart';
import 'package:music_royalty/Widgets/froms/input_field.dart';
import 'package:music_royalty/Widgets/froms/text_input.dart';
import 'package:music_royalty/models/user.dart';

import '../../controllers/sign_up_controller.dart';

class signup_google extends GetView<SignUpController> {
  const signup_google({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fullName =
        FirebaseAuth.instance.currentUser!.displayName.toString().split(" ");
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
      body: SafeArea(
        child: Form(
          key: controller.SignUpKey,
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
                          child: Myinput(
                            onChanged: (v) => controller.userx.first_name = v,
                            labelText: "Name",
                            what: fullName[0],
                            validate: (v) {
                              controller.validateThese(v!);
                            },
                          )),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      SizedBox(
                          width: screenWidth * .44,
                          child: Myinput(
                            onChanged: (v) => controller.userx.middle_name = v,
                            labelText: "Middle Name",
                          )),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    labelText: "Last Name",
                    onChanged: (v) => controller.userx.last_name = v,
                    what: fullName.length == 2 ? fullName[1] : fullName[2],
                    validate: (v) {
                      controller.validateThese(v!);
                    },
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    onChanged: (v) => controller.userx.Date = v,
                    labelText: "Date of Birth",
                    AutofillHints: [AutofillHints.birthday],
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
                    what: FirebaseAuth.instance.currentUser!.email.toString(),
                    enabled: false,
                    onChanged: (v) => controller.userx.email = v,

                    validate: (v) {
                      controller.validateThese(v!);
                    },
                    //onChanged: (v) => controller.userx!.email = v,
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    onChanged: (v) => controller.userx.phone_number = v,
                    validate: (v) {
                      controller.validateThese(v!);
                    },
                    what: FirebaseAuth.instance.currentUser!.phoneNumber,
                    labelText: "Phone number",
                    AutofillHints: [AutofillHints.telephoneNumber],
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    onChanged: (v) => controller.userx.adress = v,
                    validate: (v) {
                      controller.validateThese(v!);
                    },
                    labelText: "Adress",
                    AutofillHints: [AutofillHints.postalAddress],
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: screenWidth * .44,
                          child: Obx(() => AutoCompleteWidget(
                                what: controller.state.value,
                                onSelected: (v) => controller.userx.state = v,
                                labelText: "State",
                                enabled: true,
                                validator: (v) {
                                  controller.validateThese(v!);
                                },
                              ))),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      SizedBox(
                          width: screenWidth * .44,
                          child: Myinput(
                            onChanged: (v) => controller.userx.zip = v,
                            validate: (v) {
                              controller.validateThese(v!);
                            },
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
                        onPressed: () => controller.addUser(controller.userx),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: MyColors.mainblack, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          primary: MyColors.MainYellow,
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * .026,
                              horizontal: screenWidth * .37),
                        )),
                  )
                ],
              ),
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