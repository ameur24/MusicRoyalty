import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/empty_main.dart';
import 'package:music_royalty/models/user.dart';

class SignUpController extends GetxController {
  // will use 1 for google and 2 for email , 0 will be default

  var signupmode = 1.obs;
  // ignore: non_constant_identifier_names
  var SignUpKey = GlobalKey<FormState>();
/*   TextEditingController Cfirst_name = TextEditingController(),
      Cmiddle_name = TextEditingController(),
      Clast_name = TextEditingController(),
      Cemail = TextEditingController(),
      Cadress = TextEditingController(),
      Cstate = TextEditingController(),
      Cphone_number = TextEditingController(),
      Czip = TextEditingController(),
      CDate = TextEditingController(); */
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var middle_name = TextEditingController().obs;
  var last_name = TextEditingController().obs;
  var email = "".obs;
  var emails = TextEditingController().obs;
  var adress = TextEditingController().obs;
  var state = TextEditingController().obs;
  var phone_number = TextEditingController().obs;
  var zip = TextEditingController().obs;
  var Date = TextEditingController().obs;
  late DateTime initDate = DateTime(2005, 05, 27);
  var userId = "".obs;
  var first_name = TextEditingController().obs;
  @override
  void onInit() {
    super.onInit();
/*     Cfirst_name = TextEditingController(text: first_name.value);
    Cmiddle_name = TextEditingController(text: middle_name.value);
    Clast_name = TextEditingController(text: last_name.value);
    Cemail = TextEditingController(text: email.value);
    Cadress = TextEditingController(text: adress.value);
    Cstate = TextEditingController(text: state.value);
    Cphone_number = TextEditingController(text: phone_number.value);
    Czip = TextEditingController(text: zip.value);
    CDate = TextEditingController(text: Date.value); */
    if (FirebaseAuth.instance.currentUser!.displayName != null) {
      final fullName =
          FirebaseAuth.instance.currentUser!.displayName.toString().split(" ");
      first_name.value.text = fullName[0];
      fullName.length == 2
          ? last_name.value.text = fullName[1]
          : last_name.value.text = fullName[2];
    }
    if (FirebaseAuth.instance.currentUser!.email != null) {
      emails.value.text = FirebaseAuth.instance.currentUser!.email.toString();
    }
  }

  // validation ********

  //Name(first/last) / adress / state /zip
  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  String? validatePhone(String c1) {
    if (!c1.isPhoneNumber) {
      return "Incorrect format";
    }
    return null;
  }

  /*  String? validatedate(String c1) {
    if (!c1.isDateTime) {
      return "Date format must be MM/DD/YYYY";
    }
    return null;
  } */

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "invalid Email";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length <= 7) {
      return "password must have more than 7 characters";
    } else {
      return null;
    }
  }

  Future<void> addUser() async {
    bool isvalidate = SignUpKey.currentState!.validate();
    print(isvalidate);
    if (isvalidate) {
      /*    newUser = Userx(
          middle_name: newUser.middle_name,
          last_name: newUser.last_name,
          email: newUser.email,
          adress: newUser.adress,
          state: newUser.state,
          phone_number: newUser.phone_number,
          zip: newUser.zip,
          Date: newUser.Date,
          uid: newUser.uid,
          first_name: newUser.first_name); */
      if (signupmode.value == 1) {
        userId.value = FirebaseAuth.instance.currentUser!.uid;
      } else if (signupmode.value == 2) {}
      users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
            'userId': userId.value,
            'first_name': first_name.value.text,
            'middle_name': middle_name.value.text,
            'last_name': last_name.value.text,
            'email': emails.value.text,
            'adress': adress.value.text,
            'state': state.value.text,
            'num': phone_number.value.text,
            'zip': zip.value.text,
            "birth_date": Date.value.text,
            "num_music": 0
          })
          .then((value) => Get.to(EmptyMain()))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  void GetUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.displayName);
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    }
  }
}
