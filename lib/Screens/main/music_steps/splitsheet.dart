import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/pdfpreviewscree.dart';

import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/Widgets/Texts/big_text.dart';
import 'package:music_royalty/Widgets/Texts/labels_text.dart';
import 'package:music_royalty/Widgets/froms/input_field.dart';
import 'package:music_royalty/Widgets/froms/text_input.dart';
import 'package:music_royalty/Widgets/writerfields.dart';
import 'package:music_royalty/controllers/splitshitcontroller.dart';
import 'package:music_royalty/models/writer.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class splitsheet extends GetView<SplitshitController> {
  const splitsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pdf = pw.Document();
    List<writer> writers = <writer>[];

    Get.put(SplitshitController());
    Map<String, TextEditingController> _textControllers = new Map();

    Widget Screenview() {
      return PdfPreview(build: (context) => pdf.save());
    }

    writeOnPdf() async {
      final customFont = pw.Font.ttf(
          await rootBundle.load('assets/fonts/OpenSans/OpenSans-Regular.ttf'));
      pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) => <pw.Widget>[
          pw.Container(
            padding: pw.EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                  bottom: pw.BorderSide(width: 2, color: PdfColors.black)),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Song Publishing SplitSheet',
                  style: pw.TextStyle(
                      fontSize: 20, color: PdfColors.black, font: customFont),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
          pw.Text("Song Title:  ",
              style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
          pw.Text("Date:  ${controller.date.value.text}",
              style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Text("Recording Band/Artist:",
                style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
            pw.Text("${controller.bandartist.value.text}",
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.black,
                )),
            pw.SizedBox(width: 4 * PdfPageFormat.cm),
            pw.Text("Label (if any):  ${controller.label.value.text}",
                style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold)),
          ]),
          pw.Header(
              level: 2,
              child: pw.Text(
                "Studio Name:  ${controller.studioname.value.text}",
              )),
          pw.Header(
              level: 2,
              child: pw.Text(
                "Studio Address:  ${controller.studioadress.value.text}",
              )),
          pw.Header(
              level: 2,
              child: pw.Text(
                "Studio Phone Number: ${controller.studiophonenumber.value.text}",
              )),
          pw.Header(
              level: 2,
              child: pw.Text(
                "Samples: YES NO (Circle One) || Album & Artist Sampled:",
              )),
          pw.ListView.builder(
              itemBuilder: (context, index) {
                return pw.Column(children: [
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        "WRITER #${index + 1}:",
                      )),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        "Address: ${controller.textControllers[index].addresscontroller.text}:",
                      )),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        "Phone:  ${controller.textControllers[index].phonenumbercontroller.text}",
                      )),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        "Publishing Company (list any 3rd party publishing companies & their information, if it applies): ",
                      )),
                  pw.ListView.builder(
                      itemBuilder: (context, i) {
                        return pw.Header(
                            level: 2,
                            child: pw.Text(
                              "Publishing Company ${i + 1}:  ${controller.textControllers[index].companies[i].namecontroller.text}",
                            ));
                      },
                      itemCount:
                          controller.textControllers[index].companies.length),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        "Affiliation: ASCAPBMISESAC (Circle one)",
                      )),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        " Lyrics Ownership: ${controller.textControllers[index].lyricsownercontroller.text}",
                      )),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        " Music Ownership: ${controller.textControllers[index].musicOwnercontroller.text} ",
                      )),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        " Writer/Composer Signature: ",
                      )),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        " CAE/Social Security : ${controller.textControllers[index].securitycodecontroller.text}",
                      )),
                  pw.Header(
                      level: 2,
                      child: pw.Text(
                        " Birthdate :  ${controller.textControllers[index].birthdatecontroller.text}",
                      )),
                ]);
              },
              itemCount: controller.textControllers.length)
        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: pw.Text(
              text,
              style: pw.TextStyle(color: PdfColors.black),
            ),
          );
        },
      ));
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/example.pdf');
      await file.writeAsBytes(await pdf.save());
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.mainblack,
      appBar: AppBar(
        backgroundColor: MyColors.mainblack,
        foregroundColor: Colors.white,
        title: Text(
          "SplitSheet",
          style: TextStyle(color: MyColors.MainYellow),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: controller.splitsheetKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * .04,
                  ),
                  Text(
                    "Studio & Artist/Band Details",
                    style: TextStyle(color: MyColors.MainYellow, fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    ontap: () async {
                      DateTime? pickdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1920),
                          lastDate: DateTime.now());
                      if (pickdate != null) {
                        controller.date.value.text =
                            DateFormat("yyyy-MM-dd").format(pickdate);
                      }
                    },
                    icon: Icon(
                      Icons.calendar_today_rounded,
                      color: MyColors.BordersGrey,
                    ),
                    controller: controller.date.value,
                    labelText: "music composed date",
                    validate: (v) => controller.validateThese(v!),
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SizedBox(
                            child: Myinput(
                          controller: controller.bandartist.value,
                          onChanged: (v) {
                            final val = TextSelection.collapsed(
                                offset:
                                    controller.bandartist.value.text.length);
                            controller.bandartist.value.selection = val;
                          },
                          labelText: "Recording Band/Artist",
                          // what: controller.first_name.value,
                          validate: (v) => controller.validateThese(v!),
                        )),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Expanded(
                        child: SizedBox(
                            child: Myinput(
                                controller: controller.label.value,
                                // what: controller.middle_name.value,
                                onChanged: (v) {
                                  final val = TextSelection.collapsed(
                                      offset:
                                          controller.label.value.text.length);
                                  controller.label.value.selection = val;
                                },
                                labelText: "Label (if any)",
                                validate: (v) => controller.validateThese(v!))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    controller: controller.studioname.value,
                    labelText: "Studio Name:",
                    onChanged: (v) {
                      final val = TextSelection.collapsed(
                          offset: controller.studioname.value.text.length);
                      controller.studioname.value.selection = val;
                    },
                    validate: (v) => controller.validateThese(v!),
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    controller: controller.studioadress.value,
                    labelText: "Studio Address:",
                    onChanged: (v) {
                      final val = TextSelection.collapsed(
                          offset: controller.studioadress.value.text.length);
                      controller.studioadress.value.selection = val;
                    },
                    validate: (v) => controller.validateThese(v!),
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    controller: controller.studiophonenumber.value,
                    labelText: "Studio Phone number:",
                    keyboardType: TextInputType.phone,
                    onChanged: (v) {
                      final val = TextSelection.collapsed(
                          offset:
                              controller.studiophonenumber.value.text.length);
                      controller.studiophonenumber.value.selection = val;
                    },
                    validate: (v) => controller.validatePhone(v!),
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Myinput(
                    controller: controller.artistbandsampled.value,
                    labelText: "Album & Artist Sampled:(optional)",
                    onChanged: (v) {
                      final val = TextSelection.collapsed(
                          offset:
                              controller.artistbandsampled.value.text.length);
                      controller.artistbandsampled.value.selection = val;
                    },
                    validate: (v) => controller.validateThese(v!),
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Divider(
                    color: MyColors.BordersGrey, //color of divider
                    height: 5, //height spacing of divider
                    thickness: 3, //thickness of divier line
                    indent: 10, //spacing at the start of divider
                    endIndent: 10, //spacing at the end of divider
                  ),
                  SizedBox(
                    height: screenHeight * .03,
                  ),
                  SizedBox(
                    child: Obx(() => ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: screenHeight * .02,
                                ),
                                Text(
                                  "#${index + 1} Writer :",
                                  style: TextStyle(
                                      color: MyColors.MainYellow, fontSize: 20),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: screenHeight * .02,
                                ),
                                writerWidget(
                                    context, index, controller.textControllers),
                                SizedBox(
                                  height: screenHeight * .02,
                                ),
                                Divider(
                                  color:
                                      MyColors.BordersGrey, //color of divider
                                  height: 5, //height spacing of divider
                                  thickness: 3, //thickness of divier line
                                  indent: 10, //spacing at the start of divider
                                  endIndent: 10, //spacing at the end of divider
                                ),
                              ],
                            );
                          },
                          itemCount: controller.textControllers.length,
                        )),
                  ),
                  Center(
                      child: TextButton(
                    onPressed: () {
                      //writers.forEach((app) => _textControllers[app.] = new TextEditingController());
                      List<company> c = <company>[
                        company(namecontroller: new TextEditingController())
                      ];

                      controller.textControllers.add(textcontroller(
                          namecontroller: new TextEditingController(),
                          addresscontroller: new TextEditingController(),
                          phonenumbercontroller: new TextEditingController(),
                          companies: c.obs,
                          musicOwnercontroller: new TextEditingController(),
                          lyricsownercontroller: new TextEditingController(),
                          securitycodecontroller: new TextEditingController(),
                          birthdatecontroller: new TextEditingController()));
                    },
                    child: Text(
                      "Add one more writer",
                      style:
                          TextStyle(fontSize: 16, color: MyColors.BordersGrey),
                    ),
                  )),
                  SizedBox(
                    height: screenHeight * .03,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          // for (int i = 0; i < controller.writers.length; i++) {
                          //   log(controller.writers[i].name);
                          //   print(controller.writers[i].name);
                          //   log(controller.writers[i].address);
                          //   print(controller.writers[i].lyricsowner);
                          //   print("asba");
                          //   print(controller.name.value);
                          //   print(controller.lyricsowner.value);
                          // }
                          bool isvalidate =
                              controller.splitsheetKey.currentState!.validate();
                          if (isvalidate) {
                            await writeOnPdf();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screenview()));
                          }
                        }, //controller.addUser(),
                        child: Text(
                          'Generate',
                          style: TextStyle(
                              color: MyColors.mainblack, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          backgroundColor: MyColors.MainYellow,
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * .026,
                              horizontal: screenWidth * .355),
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
