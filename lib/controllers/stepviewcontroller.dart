import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/step_view.dart';
import 'package:music_royalty/controllers/user_controller.dart';
import 'package:music_royalty/models/websitesRegistrationfields.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/websitesfields.dart';

class stepViewController extends GetxController {
  var url = "".obs;
  var progress = 0.obs;
  setprogress(prog) {
    progress.value = prog;
  }

  late WebViewController viewcontroller;
  var botomlist = <BottomNavigationBarItem>[].obs;
  var indexbotom = 0.obs;
  late BuildContext dialogcontext;
  var websitefields = <WebsitesRegistrationFields>[].obs;
  UserController userController = Get.find<UserController>();
  @override
  void onClose() {
    websitefields.clear();
    url.value = "";
    super.onClose();
  }

  widgetss() {
    if (websitefields[0].url['home'] != '') {
      botomlist.add(
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
      );
    }
    if (websitefields[0].url['registre'] != '') {
      botomlist.add(BottomNavigationBarItem(
        label: "Registre",
        icon: Icon(Icons.account_circle),
      ));
    }
    if (websitefields[0].url['form'] != '') {
      botomlist.add(BottomNavigationBarItem(
        label: "Form",
        icon: Icon(Icons.checklist),
      ));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    Get.closeAllSnackbars();
    var w = await returnlist(Get.arguments["id"], Get.arguments["ssid"]);

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    if (w.isNotEmpty) {
      websitefields.add(w.first);
      url.value = websitefields[0].url['home'].toString();
    }
    await userController.getUserDeatails();
    await widgetss();
  }

  Future<List<WebsitesRegistrationFields>> returnlist(
      int number, String sousstep) async {
    try {
      var w = WebsitesFieldsConstants.autofilllist
          .where((element) =>
              element.stepid.compareTo(number.toString()) == 0 &&
              element.sousstepid.compareTo(sousstep) == 0)
          .toList();

      return w;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
