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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
          child: SingleChildScrollView(
              child: Form(
            key: controller.SignUpKey,
            autovalidateMode: AutovalidateMode.disabled,
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
                          onChanged: (v) => controller.first_name.value = v,
                          labelText: "Name",
                          what: controller.first_name.value,
                          validate: (v) => controller.validateThese(v!),
                        )),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    SizedBox(
                        width: screenWidth * .44,
                        child: Myinput(
                          what: controller.middle_name.value,
                          onChanged: (v) => controller.middle_name.value = v,
                          labelText: "Middle Name",
                        )),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                Myinput(
                  what: controller.last_name.value,
                  labelText: "Last Name",
                  onChanged: (v) => controller.last_name.value = v,
                  validate: (v) => controller.validateThese(v!),
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                /*    Myinput(
                  what: controller.Date.value,
                  labelText: "Date time",
                  onChanged: (v) => controller.Date.value = v,
                  validate: (v) => controller.validateThese(v!),
                ), */
                GestureDetector(
                  onTap: () async {
                    DateTime? res = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1930),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                                textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                              foregroundColor:
                                  Colors.black, // button text color
                            ))),
                            child: child!,
                          );
                        });
                    controller.initDate = res!;
                    var cx = res.toString().split(" ");
                    print("yo no no yoooo${cx[0]}");
                    print("yo yo yo yoooo${controller.initDate}");
                    if (res == null) {
                      return;
                    } else {
                      controller.Date.value = cx[0];
                    }
                    controller.update();

                    print("yo yo yo xs${controller.Date}");
                  },
                  child: Obx(() => Myinput(
                        enabled: false,
                        validate: (v) => controller.validateThese(v!),
                        controller:
                            TextEditingController(text: controller.Date.value),
                        labelText: "Date of Birth",
                        AutofillHints: [AutofillHints.birthday],
                        keyboardType: TextInputType.datetime,
                      )),
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
                  what: controller.email.value,

                  enabled: false,
                  onChanged: (v) => controller.email.value = v,

                  validate: (v) {
                    controller.validateEmail(v!);
                  },
                  //onChanged: (v) => controller.userx!.email = v,
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                Myinput(
                  what: controller.phone_number.value,
                  onChanged: (v) => controller.phone_number.value = v,
                  validate: (v) => controller.validatePhone(v!),
                  labelText: "Phone number",
                  AutofillHints: [AutofillHints.telephoneNumber],
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),
                Myinput(
                  what: controller.adress.value,
                  onChanged: (v) => controller.adress.value = v,
                  validate: (v) => controller.validateThese(v!),
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
                        child: Obx(() => Myinput(
                              what: controller.state.value,
                              onChanged: (v) => controller.state.value = v,
                              labelText: "State",
                              enabled: true,
                              validate: (v) => controller.validateThese(v!),
                            ))),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    SizedBox(
                        width: screenWidth * .44,
                        child: Myinput(
                          onChanged: (v) => controller.zip.value = v,
                          validate: (v) => controller.validateThese(v!),
                          what: controller.zip.value,
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
                      onPressed: () => controller.addUser(),
                      child: Text(
                        'Sign Up',
                        style:
                            TextStyle(color: MyColors.mainblack, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        primary: MyColors.MainYellow,
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * .026,
                            horizontal: screenWidth * .355),
                      )),
                )
              ],
            ),
          )),
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