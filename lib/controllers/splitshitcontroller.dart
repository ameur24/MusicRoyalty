import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_royalty/models/writer.dart';

class SplitshitController extends GetxController {
  String? musicId;
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
  GetStorage box = GetStorage();

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
  void onClose() {
    saveProgress();
    super.onClose();
  }

  @override
  void onReady() {
    loaddata();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  String? validatePhone(String c1) {
    if (!c1.isPhoneNumber) {
      return "Incorrect format";
    }
    return null;
  }

  void loaddata() {
    print("music id : $musicId");
    if (musicId != null) {
      var savedData = GetStorage().read(musicId!);

      if (savedData != null) {
        savedData["musicDate"] != null
            ? date.value.text = savedData["musicDate"]
            : date.value = new TextEditingController();
        savedData["bandArtist"] != null
            ? bandartist.value.text = savedData["bandArtist"]
            : bandartist.value = new TextEditingController();
        savedData["studioName"] != null
            ? studioname.value.text = savedData["studioName"]
            : studioname.value = new TextEditingController();
        ;
        savedData["label"] != null
            ? label.value.text = savedData["label"]
            : label.value = new TextEditingController();
        savedData["studioAd"] != null
            ? studioadress.value.text = savedData["studioAd"]
            : studioadress.value = new TextEditingController();
        savedData["studioPh"] != null
            ? studiophonenumber.value.text = savedData["studioPh"]
            : studiophonenumber.value = new TextEditingController();
        ;
        savedData["sample"] != null
            ? isOk.value = savedData["sample"]
            : isOk.value = "No";
        if (isOk.value == "Yes") {
          savedData["artistsampled"] != null
              ? artistbandsampled.value.text = savedData["artistsampled"]
              : artistbandsampled.value = new TextEditingController();
        }
        if (savedData["writerList"] != null &&
            savedData["writerList"].isNotEmpty) {
          print(savedData["writerList"]);
          textControllers.value = savedData["writerList"];
        } else {
          print('esle');
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
        if (savedData["compList"] != null) {
          companylist.value = savedData["compList"];
        } else {
          companylist.add(company(
              namecontroller: new TextEditingController(),
              lyricscontroller: new TextEditingController()));
        }
      } else {
        date.value = new TextEditingController();
        bandartist.value = new TextEditingController();
        studioname.value = new TextEditingController();
        label.value = new TextEditingController();
        studioadress.value = new TextEditingController();
        studiophonenumber.value = new TextEditingController();
        isOk.value = "No";

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
        companylist.add(company(
            namecontroller: new TextEditingController(),
            lyricscontroller: new TextEditingController()));
      }
    }
  }

  void saveProgress() {
    Map<String, dynamic> data = {};
    if (musicId != null) {
      if (box.read(musicId!) != null) box.remove(musicId!);
    }
    data.addIf(date.value.text.isNotEmpty, "musicDate", date.value.text);
    data.addIf(
        bandartist.value.text.isNotEmpty, "bandArtist", bandartist.value.text);
    data.addIf(
        studioname.value.text.isNotEmpty, "studioName", studioname.value.text);
    data.addIf(label.value.text.isNotEmpty, "label", label.value.text);
    data.addIf(studioadress.value.text.isNotEmpty, "studioAd",
        studioadress.value.text);
    data.addIf(studiophonenumber.value.text.isNotEmpty, "studioPh",
        studiophonenumber.value.text);
    data.addIf(isOk.value.isNotEmpty, "sample", isOk.value);
    data.addIf(
        isOk.value == "Yes", "artistsampled", artistbandsampled.value.text);
    data.addIf(textControllers.isNotEmpty, "writerList", textControllers);
    data.addIf(companylist.isNotEmpty, "compList", companylist);
    data.addIf(date.value.text.isNotEmpty, "musicDate", date.value.text);
    data.addIf(date.value.text.isNotEmpty, "musicDate", date.value.text);
    data.addIf(date.value.text.isNotEmpty, "musicDate", date.value.text);
    if (musicId != null) {
      box.write(musicId!, data);
    }
  }
}
