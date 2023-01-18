import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
      final cuss = pw.Font.ttf(
          await rootBundle.load('assets/fonts/Exo/Exo-VariableFont_wght.ttf'));
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
                  bottom: pw.BorderSide(width: 1, color: PdfColors.black)),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Song Publishing SplitSheet',
                  style: pw.TextStyle(
                      fontSize: 18,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                      font: customFont),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
          pw.Row(children: [
            pw.Text("Song Title:",
                style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(
              width: PdfPageFormat.cm * 3,
            ),
            pw.Text(controller.date.value.text.toString(),
                style: pw.TextStyle(
                  fontSize: 13,
                  color: PdfColors.black,
                  font: customFont,
                ))
          ]),
          pw.Divider(
              height: 0.5,
              color: PdfColors.black,
              endIndent: 0,
              thickness: 0.5,
              indent: 80),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
          pw.Row(children: [
            pw.Text("Date:",
                style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(
              width: PdfPageFormat.cm * 4,
            ),
            pw.Text(controller.date.value.text.toString(),
                style: pw.TextStyle(
                  fontSize: 13,
                  font: customFont,
                  color: PdfColors.black,
                ))
          ]),
          pw.Divider(
              height: 0.5,
              color: PdfColors.black,
              endIndent: 0,
              thickness: 0.5,
              indent: 80),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
          pw.Row(children: [
            pw.Text("Recording Band/Artist:",
                overflow: pw.TextOverflow.clip,
                style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.normal)),
            pw.SizedBox(width: 1 * PdfPageFormat.cm),
            pw.Text("${controller.bandartist.value.text}",
                style: pw.TextStyle(
                  fontSize: 13,
                  font: customFont,
                  color: PdfColors.black,
                )),
            /*       pw.SizedBox(width: 2.5 * PdfPageFormat.cm),
            pw.Text("Label (if any):  ",
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.black,
                )),
            pw.SizedBox(width: 1 * PdfPageFormat.cm),
            pw.Text("${controller.label.value.text}",
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.black,
                )) */
          ]),
          pw.Divider(
              height: 0.5,
              color: PdfColors.black,
              endIndent: 0,
              thickness: 0.5,
              indent: 130),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
          controller.label.value.text != ""
              ? pw.Row(children: [
                  pw.Text("Label (optional):  ",
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.black,
                      )),
                  pw.SizedBox(width: 2 * PdfPageFormat.cm),
                  pw.Text("${controller.label.value.text}",
                      style: pw.TextStyle(
                        fontSize: 13,
                        font: customFont,
                        color: PdfColors.black,
                      ))
                ])
              : pw.SizedBox.shrink(),
          controller.label.value.text != ""
              ? pw.Divider(
                  height: 0.5,
                  color: PdfColors.black,
                  endIndent: 0,
                  thickness: 0.5,
                  indent: 100)
              : pw.SizedBox.shrink(),
          controller.label.value.text != ""
              ? pw.SizedBox(height: 0.3 * PdfPageFormat.cm)
              : pw.SizedBox.shrink(),
          pw.Row(children: [
            pw.Text("Studio Name:",
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.black,
                )),
            pw.SizedBox(width: 2 * PdfPageFormat.cm),
            pw.Text("${controller.studioname.value.text}",
                style: pw.TextStyle(
                  fontSize: 13,
                  font: customFont,
                  color: PdfColors.black,
                ))
          ]),
          pw.Divider(
              height: 0.5,
              color: PdfColors.black,
              endIndent: 0,
              thickness: 0.5,
              indent: 100),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
          pw.Row(children: [
            pw.Text("Studio Address:",
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.black,
                )),
            pw.SizedBox(width: 2 * PdfPageFormat.cm),
            pw.Text("${controller.studioadress.value.text}",
                style: pw.TextStyle(
                  fontSize: 13,
                  font: customFont,
                  color: PdfColors.black,
                ))
          ]),
          pw.Divider(
              height: 0.5,
              color: PdfColors.black,
              endIndent: 0,
              thickness: 0.5,
              indent: 100),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
          pw.Row(children: [
            pw.Text("Studio Phone Number:",
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.black,
                )),
            pw.SizedBox(width: 1 * PdfPageFormat.cm),
            pw.Text("${controller.studiophonenumber.value.text}",
                style: pw.TextStyle(
                    fontSize: 13, color: PdfColors.black, font: customFont))
          ]),
          pw.Divider(
              height: 0.5,
              color: PdfColors.black,
              endIndent: 0,
              thickness: 0.5,
              indent: 120),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
          pw.Row(children: [
            pw.Text("Samples :",
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.black,
                )),
            pw.SizedBox(width: 3.4 * PdfPageFormat.cm),
            pw.Text("${controller.isOk.value}",
                style: pw.TextStyle(
                  fontSize: 13,
                  font: customFont,
                  color: PdfColors.black,
                ))
          ]),
          pw.Divider(
              height: 0.5,
              color: PdfColors.black,
              endIndent: 0,
              thickness: 0.5,
              indent: 80),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
          controller.artistbandsampled.value.text != ""
              ? pw.Row(children: [
                  pw.Text("Album & Artist Sampled:",
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.black,
                      )),
                  pw.SizedBox(width: 1 * PdfPageFormat.cm),
                  pw.Text("${controller.artistbandsampled.value.text}",
                      style: pw.TextStyle(
                        fontSize: 13,
                        font: customFont,
                        color: PdfColors.black,
                      ))
                ])
              : pw.SizedBox.shrink(),
          controller.artistbandsampled.value.text != ""
              ? pw.Divider(
                  height: 0.5,
                  color: PdfColors.black,
                  endIndent: 0,
                  thickness: 0.5,
                  indent: 140)
              : pw.SizedBox.shrink(),
          pw.SizedBox(height: 2 * PdfPageFormat.cm),
          pw.ListView.builder(
              itemBuilder: (context, index) {
                return pw.Column(children: [
                  pw.Row(children: [
                    pw.Text("Writer #${index + 1}:",
                        style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 3 * PdfPageFormat.cm),
                    pw.Text(
                        "${controller.textControllers[index].namecontroller.text}",
                        style: pw.TextStyle(
                          fontSize: 13,
                          font: customFont,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 80),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.Row(children: [
                    pw.Text("Address:",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        )),
                    pw.SizedBox(width: 3 * PdfPageFormat.cm),
                    pw.Text(
                        "${controller.textControllers[index].addresscontroller.text}",
                        style: pw.TextStyle(
                          fontSize: 13,
                          font: customFont,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 80),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.Row(children: [
                    pw.Text("Phone: ",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        )),
                    pw.SizedBox(width: 3.2 * PdfPageFormat.cm),
                    pw.Text(
                        "${controller.textControllers[index].phonenumbercontroller.text}",
                        style: pw.TextStyle(
                          fontSize: 13,
                          font: customFont,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 80),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.ListView.builder(
                      itemBuilder: (context, i) {
                        return pw.Column(children: [
                          pw.Row(children: [
                            pw.Text("Publishing Company #${i + 1}",
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.black,
                                )),
                            pw.SizedBox(width: 1 * PdfPageFormat.cm),
                            pw.Text(
                                "${controller.textControllers[index].companies[i].namecontroller.text}",
                                style: pw.TextStyle(
                                  fontSize: 13,
                                  font: customFont,
                                  color: PdfColors.black,
                                ))
                          ]),
                          pw.Divider(
                              height: 0.5,
                              color: PdfColors.black,
                              endIndent: 0,
                              thickness: 0.5,
                              indent: 130),
                          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                        ]);
                      },
                      itemCount:
                          controller.textControllers[index].companies.length),
                  pw.Row(children: [
                    pw.Text("Affiliation (ASCAP/BMI/SESAC):",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        )),
                    pw.SizedBox(width: 1 * PdfPageFormat.cm),
                    pw.Text(
                        "${controller.textControllers[index].affiliation.text}",
                        style: pw.TextStyle(
                          fontSize: 13,
                          font: customFont,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 80),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.Row(children: [
                    pw.Text("Lyrics Ownership:",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        )),
                    pw.SizedBox(width: 2 * PdfPageFormat.cm),
                    pw.Text(
                        "${controller.textControllers[index].lyricsownercontroller.text}",
                        style: pw.TextStyle(
                          fontSize: 13,
                          font: customFont,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 120),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.Row(children: [
                    pw.Text("Music Ownership:",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        )),
                    pw.SizedBox(width: 2 * PdfPageFormat.cm),
                    pw.Text(
                        "${controller.textControllers[index].musicOwnercontroller.text}",
                        style: pw.TextStyle(
                          fontSize: 13,
                          font: customFont,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 120),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.Row(children: [
                    pw.Text("CAE/Social Security :",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        )),
                    pw.SizedBox(width: 1 * PdfPageFormat.cm),
                    pw.Text(
                        "${controller.textControllers[index].securitycodecontroller.text}",
                        style: pw.TextStyle(
                          fontSize: 13,
                          font: customFont,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 150),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.Row(children: [
                    pw.Text("Birthdate :",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        )),
                    pw.SizedBox(width: 3 * PdfPageFormat.cm),
                    pw.Text(
                        "${controller.textControllers[index].birthdatecontroller.text}",
                        style: pw.TextStyle(
                          fontSize: 13,
                          font: customFont,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 80),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.Row(children: [
                    pw.Text("Writer/Composer Signature:",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        )),
                    pw.SizedBox(width: 1 * PdfPageFormat.cm),
                    pw.Text("",
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.black,
                        ))
                  ]),
                  pw.Divider(
                      height: 0.5,
                      color: PdfColors.black,
                      endIndent: 0,
                      thickness: 0.5,
                      indent: 150),
                  pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
                  pw.SizedBox(height: 2 * PdfPageFormat.cm),
                ]);
              },
              itemCount: controller.textControllers.length)
        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return pw.Container(
            padding: pw.EdgeInsets.only(top: 3 * PdfPageFormat.mm),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                  top: pw.BorderSide(width: 1, color: PdfColors.black)),
            ),
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
                                offset: controller.label.value.text.length);
                            controller.label.value.selection = val;
                          },
                          labelText: "Label (if any)",
                        )),
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
                    validate: (v) => controller.validateThese(v!),
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Obx(() => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Samples?",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Roboto-Regular",
                                    color: Colors.white70)),
                            ToggleButtons(
                              borderRadius: BorderRadius.circular(12),
                              isSelected: controller.isSelected4,
                              selectedColor: Colors.black,
                              color: Colors.white,
                              fillColor: MyColors.MainYellow,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Center(
                                    child: Text('  Yes ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Roboto-Regular")),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Center(
                                    child: Text('   No   ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Roboto-Regular")),
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                controller.isSelected4[index] = true;
                                if (index == 0) {
                                  controller.isOk.value = "Yes";
                                  print(controller.isOk.value);
                                  controller.isSelected4[1] = false;
                                } else {
                                  controller.isOk.value = "No";
                                  print(controller.isOk.value);
                                  controller.isSelected4[0] = false;
                                }
                              },
                            )
                          ],
                        ),
                      )),
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
                  ),
                  SizedBox(
                    height: screenHeight * .03,
                  ),
                  Obx(() => ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
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
                                color: MyColors.BordersGrey, //color of divider
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
                          birthdatecontroller: new TextEditingController(),
                          affiliation: new TextEditingController()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: MyColors.MainYellow,
                        ),
                        SizedBox(
                          width: screenWidth * 0.01,
                        ),
                        Text(
                          "Add one more writer",
                          style: TextStyle(
                              fontSize: 16, color: MyColors.BordersGrey),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: screenHeight * .03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
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
                            bool isvalidate = controller
                                .splitsheetKey.currentState!
                                .validate();
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
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
