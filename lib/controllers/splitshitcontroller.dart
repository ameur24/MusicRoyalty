import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/models/writer.dart';

class SplitshitController extends GetxController {
  var bandartist = new TextEditingController().obs;
  var studioadress = new TextEditingController().obs;
  var studiophonenumber = new TextEditingController().obs;
  var label = new TextEditingController().obs;
  var studioname = new TextEditingController().obs;
  var samples = new TextEditingController().obs;
  var artistbandsampled = new TextEditingController().obs;
  var date = new TextEditingController().obs;
  var takeoff = 1.obs;
  RxList<textcontroller> textControllers = <textcontroller>[].obs;

  RxList<writer> writers = <writer>[].obs;

  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  void onInit() {
    List<company> a = <company>[
      company(namecontroller: new TextEditingController())
    ];

    textControllers.add(textcontroller(
        namecontroller: new TextEditingController(),
        addresscontroller: new TextEditingController(),
        phonenumbercontroller: new TextEditingController(),
        companies: a.obs,
        musicOwnercontroller: new TextEditingController(),
        lyricsownercontroller: new TextEditingController(),
        securitycodecontroller: new TextEditingController(),
        birthdatecontroller: new TextEditingController()));

    super.onInit();
  }

  String? validatePhone(String c1) {
    if (!c1.isPhoneNumber) {
      return "Incorrect format";
    }
    return null;
  }
}
