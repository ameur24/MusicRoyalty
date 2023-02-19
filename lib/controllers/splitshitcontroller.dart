import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  var isOk = "Yes".obs;
  var takeoff = 1.obs;
  RxList<bool> isSelected4 = <bool>[true, false].obs;
  GetStorage box = GetStorage('MyStorage');

  var selectedVal = true.obs;
  RxList<textcontroller> textControllers = <textcontroller>[].obs;
  RxList<company> companylist = <company>[].obs;
  //  List<company> a = <company>[
  //     company(namecontroller: new TextEditingController())
  //   ];
  RxList<writer> writers = <writer>[].obs;
  var splitsheetKey = GlobalKey<FormState>();
  String? validateThese(String c1) {
    if (c1.isEmpty || c1 == null) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  void onInit() {
    print(box.read("writerList"));
    if (box.getValues() != null) {
      box.read("musicDate") != null
          ? date.value.text = box.read("musicDate")
          : date.value = new TextEditingController();
      box.read("bandArtist") != null
          ? bandartist.value.text = box.read("bandArtist")
          : bandartist.value = new TextEditingController();
      box.read("studioName") != null
          ? studioname.value.text = box.read("studioName")
          : studioname.value = new TextEditingController();
      ;
      box.read("label") != null
          ? label.value.text = box.read("label")
          : label.value = new TextEditingController();
      box.read("studioAd") != null
          ? studioadress.value.text = box.read("studioAd")
          : studioadress.value = new TextEditingController();
      box.read("studioPh") != null
          ? studiophonenumber.value.text = box.read("studioPh")
          : studiophonenumber.value = new TextEditingController();
      ;
      box.read("sample") != null
          ? isOk.value = box.read("sample")
          : isOk.value = "No";
      if (isOk.value == "Yes") {
        box.read("artistsampled") != null
            ? artistbandsampled.value.text = box.read("artistsampled")
            : artistbandsampled.value = new TextEditingController();
      }
      if (box.read("writerList") != null) {
        textControllers.value = box.read("writerList");
      } else {
        textControllers.add(textcontroller(
            namecontroller: new TextEditingController(),
            addresscontroller: new TextEditingController(),
            address2controller: new TextEditingController(),
            phonenumbercontroller: new TextEditingController(),
            musicOwnercontroller: new TextEditingController(),
            lyricsownercontroller: new TextEditingController(),
            securitycodecontroller: new TextEditingController(),
            birthdatecontroller: new TextEditingController(),
            affiliation: new TextEditingController()));
      }
      if (box.read("compList") != null) {
        companylist.value = box.read("compList");
      } else {
        companylist.add(company(
            namecontroller: new TextEditingController(),
            lyricscontroller: new TextEditingController()));
      }
    }
    super.onInit();
  }

  String? validatePhone(String c1) {
    if (!c1.isPhoneNumber) {
      return "Incorrect format";
    }
    return null;
  }
}
