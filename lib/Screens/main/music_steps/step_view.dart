import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/step_info.dart';
import 'package:music_royalty/Widgets/buttons/navigationwidget.dart';
import 'package:music_royalty/models/websitesRegistrationfields.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:music_royalty/controllers/music_controller.dart';
import 'dart:async';
import '../../../Utils/colors.dart';
import '../../../Utils/websitesfields.dart';

class stepView extends StatefulWidget {
  const stepView({Key? key}) : super(key: key);

  @override
  State<stepView> createState() => _stepViewState();
}

class _stepViewState extends State<stepView> {
  late WebViewController controller;

  bool show = false;

  final double _initFabHeight = 50.0;

  double _calcul = 0;

  double _panelHeightOpen = 0;

  double _panelHeightClosed = 40.0;

  final List<WebsitesRegistrationFields> fieldslist = [];

  MusicController mucontroller = Get.find<MusicController>();

  @override
  void initState() {
    returnlist(Get.arguments["id"], Get.arguments["ssid"]);
    mucontroller.updateUrlName(fieldslist[0].url['home'].toString());
    mucontroller.updateFabHeight(_initFabHeight);
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  List<WebsitesRegistrationFields> returnlist(int number, String sousstep) {
    var website = WebsitesFieldsConstants.autofilllist
        .where((element) =>
            element.stepid.contains(number.toString()) &&
            element.sousstepid.contains(sousstep))
        .toList();

    if (website != null) {
      for (int index = 0; index < website.length; index++) {
        fieldslist.add(website[index]);
      }
    }

    return fieldslist;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .20;
    return Scaffold(
        backgroundColor: MyColors.blackbackground1,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.to(StepInfo(), arguments: {
                    "StepTitle": Get.arguments["StepTitle"],
                    "id": Get.arguments["id"]
                  }),
              icon: Icon(Icons.arrow_back)),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: MyColors.blackbackground1,
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SlidingUpPanel(
              onPanelSlide: (double pos) {
                _calcul = pos * (_panelHeightOpen - _panelHeightClosed) +
                    _initFabHeight;
                mucontroller.updateFabHeight(_calcul);
              },
              parallaxEnabled: true,
              parallaxOffset: .5,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              collapsed: Container(
                color: MyColors.mainblack,
                child: Icon(
                  Icons.arrow_drop_up,
                  size: 40,
                  color: MyColors.MainYellow,
                ),
              ),
              panel: Container(
                decoration: BoxDecoration(
                  color: MyColors.mainblack,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavigationWidget(
                      iconCol: MyColors.mainblack,
                      text: "Registre",
                      stepName: "Step 0",
                      icon: Icons.app_registration,
                      onPressed: () {
                        mucontroller.updateUrlName(
                            fieldslist[0].url['registre'].toString());
                        controller
                            .loadUrl(fieldslist[0].url['registre'].toString());
                      },
                      MainColor: MyColors.MainYellow,
                      fontSize: 18,
                    ),
                    NavigationWidget(
                      iconCol: MyColors.mainblack,
                      text: "Login",
                      stepName: "Step 1",
                      icon: Icons.account_box,
                      onPressed: () {
                        mucontroller.updateUrlName(
                            fieldslist[0].url['home'].toString());
                        controller
                            .loadUrl(fieldslist[0].url['home'].toString());
                      },
                      MainColor: MyColors.MainYellow,
                      fontSize: 18,
                    ),
                    NavigationWidget(
                      iconCol: MyColors.mainblack,
                      text: "Get your ${Get.arguments["StepTitle"]}",
                      stepName: "Step 2",
                      icon: Icons.checklist,
                      onPressed: () {
                        mucontroller.updateUrlName(
                            fieldslist[0].url['form'].toString());
                        controller
                            .loadUrl(fieldslist[0].url['form'].toString());
                      },
                      MainColor: MyColors.MainYellow,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              body: Obx(() => WebView(
                    initialUrl: mucontroller.url.value,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (controller) {
                      this.controller = controller;
                    },
                  )),
            ),
            Obx(() => Positioned(
                  right: 20.0,
                  bottom: mucontroller.fabheight.value,
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Visibility(
                      visible: Get.arguments['id'].clamp(4, 10) ==
                          Get.arguments['id'],
                      child: FloatingActionButton(
                        onPressed: (() {
                          print(fieldslist[0].emailfield);

                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].emailfield}').value='ddddd@sslg.com';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].fnamefield}').value='ddddd';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].lnamefield}').value='ddddd';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].middlenamefield}').value='ddddd';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].zipfield}').value=5000;");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].phonenumberfield}').value='555555555';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].adressfield}').value='ddddssssssssssssssd';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].publisheremailfield}').value='ddddd@sslg.com';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].publisherfnamefield}').value='ddddd';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].publisherlnamefield}').value='ddddd';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].publishermiddlenamefield}').value='ddddd';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].publisherzipfield}').value=5000;");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].publisherphonenumberfield}').value='555555555';");
                          controller.runJavascript(
                              "document.getElementById('${fieldslist[0].publisheradressfield}').value='ddddssssssssssssssd';");
                        }),
                        backgroundColor: MyColors.MainYellow,
                        child: Center(
                          child: Container(
                            width: 50,
                            height: 55,
                            child: Column(
                              children: [
                                Text(
                                  "Fill",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.check_box_rounded,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }
}

// String url(int number) {
//   String address = "";
//   switch (number) {
//     case 1:
//       address =
//           'https://www.templateroller.com/template/261567/song-publishing-split-sheet-template.html ';
//       break;
//     case 2:
//       address = 'https://eservice.eco.loc.gov/eService_enu?SWECmd=Start';
//       break;
//     case 3:
//       address = 'https://usisrc.org/';
//       break;
//     case 4:
//       address = 'https://applications.bmi.com/security/Login.aspx?loggedout=Y';
//       break;

//     case 5:
//       address = 'https://distrokid.com/ ';
//       break;
//     case 6:
//       address = 'https://sxdirect.soundexchange.com/login/?next=/home/';
//       break;
//     case 7:
//       address = 'https://themlc.com/';
//       break;
//     case 8:
//       address = 'https://publishers.musixmatch.com/search';
//       break;
//     case 9:
//       address = 'https://www.taxi.com/';
//       break;
//     case 10:
//       address =
//           'https://www.bing.com/search?q=twitter&cvid=a5bd213a22b04a4cb53a1c1c00e936f3&aqs=edge.0.0l9.2609j0j9&FORM=ANAB01&PC=U531';
//       break;
//   }
//   return address;
// }

