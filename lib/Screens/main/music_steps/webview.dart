import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/controllers/stepviewcontroller.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../../models/music.dart';

class webviewpage extends GetView<stepViewController> {
  final Music m;
  const webviewpage({Key? key, required this.m}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // global declaration
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    Get.put(stepViewController());

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(() => controller.url.value != ""
          ? controller.websitefields[0].autofill == true
              ? FloatingActionButton(
                  backgroundColor: MyColors.mainblack,
                  onPressed: () {
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].musictitle}').value='${m.Title.toString()}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].emailfield}').value='${controller.userController.userModel.email}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].fnamefield}').value='${controller.userController.userModel.first_name}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].lnamefield}').value='${controller.userController.userModel.last_name}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].middlenamefield}').value='${controller.userController.userModel.middle_name}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].zipfield}').value='${controller.userController.userModel.zip}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].phonenumberfield}').value='${controller.userController.userModel.phone_number.toString()}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].adressfield}').value='${controller.userController.userModel.adress}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].publisheremailfield}').value='${controller.userController.userModel.email}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].publisherfnamefield}').value='${controller.userController.userModel.first_name}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].publisherlnamefield}').value='${controller.userController.userModel.last_name}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].publishermiddlenamefield}').value='${controller.userController.userModel.middle_name}';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].publisherzipfield}').value=${controller.userController.userModel.email};");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].publisherphonenumberfield}').value='555555555';");
                    controller.viewcontroller.runJavascript(
                        "document.getElementById('${controller.websitefields[0].publisheradressfield}').value='${controller.userController.userModel.adress}';");
                  },
                  child: Icon(
                    Icons.add_box,
                    color: MyColors.BordersGrey,
                  ),
                )
              : SizedBox.shrink()
          : SizedBox.shrink()),
      bottomNavigationBar: Obx(() => controller.botomlist.length >= 2
          ? BottomNavigationBar(
              onTap: (Value) async {
                if (controller.progress.value == 100) {
                  controller.indexbotom.value = Value;
                  switch (controller.indexbotom.value) {
                    case 0:
                      controller.url.value =
                          controller.websitefields[0].url['home'].toString();
                      break;
                    case 1:
                      controller.url.value = controller
                          .websitefields[0].url['registre']
                          .toString();
                      break;
                    case 2:
                      controller.url.value =
                          controller.websitefields[0].url['form'].toString();

                      break;
                  }

                  await controller.viewcontroller.loadUrl(controller.url.value);
                }
              },
              currentIndex: controller.indexbotom.value,
              backgroundColor: MyColors.blackbackground1,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: MyColors.MainYellow,
              unselectedItemColor: MyColors.BordersGrey,
              selectedFontSize: 13,
              unselectedFontSize: 13,
              iconSize: 30,
              items: controller.botomlist)
          : SizedBox.shrink()),
      appBar: AppBar(
          foregroundColor: MyColors.BordersGrey,
          title: Text('${Get.arguments["StepTitle"]}'),
          backgroundColor: MyColors.blackbackground1),
      body: Obx(
        () => controller.url.value != ""
            ? WebView(
                initialUrl: controller.url.value,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controller.viewcontroller = webViewController;
                  _controller.complete(webViewController);
                  controller.viewcontroller.loadUrl(controller.url.value);
                },
                onProgress: (int progress) {
                  controller.progress.value = progress;
                },
                onPageStarted: (String url) {
                  controller.progress.value = 0;
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      controller.dialogcontext = context;
                      return Center(
                          child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                strokeWidth: 10,
                              )));
                    },
                  );
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  if (controller.progress.value == 100) {
                    Navigator.pop(controller.dialogcontext);
                  }
                },
                gestureNavigationEnabled: true,
                backgroundColor: const Color(0x00000000),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
