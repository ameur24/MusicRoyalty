import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/controllers/splitshitcontroller.dart';
import 'package:intl/intl.dart';
import '../models/writer.dart';
import 'froms/input_field.dart';

Widget writerWidget(
    BuildContext context, int index, List<textcontroller> writer) {
  SplitshitController controller = Get.find<SplitshitController>();
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Obx(() => Column(
        children: [
          Myinput(
            controller: writer[index].namecontroller,
            labelText: "Writer Full Name:",
            onChanged: (v) {
              final val = TextSelection.collapsed(
                  offset: writer[index].namecontroller.value.text.length);
              writer[index].namecontroller.selection = val;
            },
            validate: (v) => controller.validateThese(v!),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Myinput(
            controller: writer[index].addresscontroller,
            labelText: "Address:",
            onChanged: (v) {
              final val = TextSelection.collapsed(
                  offset: writer[index].addresscontroller.value.text.length);
              writer[index].addresscontroller.selection = val;
            },
            validate: (v) => controller.validateThese(v!),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Myinput(
            controller: writer[index].phonenumbercontroller,
            labelText: "Phone number:",
            keyboardType: TextInputType.phone,
            onChanged: (v) {
              final val = TextSelection.collapsed(
                  offset:
                      writer[index].phonenumbercontroller.value.text.length);
              writer[index].phonenumbercontroller.selection = val;
            },
            validate: (v) => controller.validateThese(v!),
          ),
          SizedBox(
            height: screenHeight * .02,
          ),
          Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "List any 3rd Party publishing companies",
                    style: TextStyle(color: MyColors.MainYellow, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                Obx(() => Container(
                      padding: const EdgeInsets.fromLTRB(2, 10, 20, 1),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "#${i + 1}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: MyColors.MainYellow,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.01,
                                ),
                                Expanded(
                                  child: Myinput(
                                    // what: controller.last_name.value,
                                    labelText: "Publishing company Name",
                                    controller: writer[index]
                                        .companies[i]
                                        .namecontroller,
                                    onChanged: (v) {
                                      final val = TextSelection.collapsed(
                                          offset: writer[index]
                                              .companies[i]
                                              .namecontroller
                                              .value
                                              .text
                                              .length);
                                      writer[index]
                                          .companies[i]
                                          .namecontroller
                                          .selection = val;
                                    },
                                    validate: (v) =>
                                        controller.validateThese(v!),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: writer[index].companies.length,
                      ),
                    )),
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                writer[index]
                    .companies
                    .add(company(namecontroller: new TextEditingController()));
              },
              child: Text(
                "Add one more Third party publishing company",
                style: TextStyle(fontSize: 16, color: MyColors.BordersGrey),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Row(
            children: [
              SizedBox(
                  width: screenWidth * .45,
                  child: Myinput(
                    controller: writer[index].lyricsownercontroller,
                    onChanged: (v) {
                      final val = TextSelection.collapsed(
                          offset: writer[index]
                              .lyricsownercontroller
                              .value
                              .text
                              .length);
                      writer[index].lyricsownercontroller.selection = val;
                    },
                    labelText: "  Lyrics Ownership:",
                    validate: (v) => controller.validateThese(v!),
                  )),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              SizedBox(
                  width: screenWidth * .45,
                  child: Myinput(
                    controller: writer[index].musicOwnercontroller,
                    onChanged: (v) {
                      final val = TextSelection.collapsed(
                          offset: writer[index]
                              .musicOwnercontroller
                              .value
                              .text
                              .length);
                      writer[index].musicOwnercontroller.selection = val;
                    },
                    labelText: "Music Ownership: ",
                    validate: (v) => controller.validateThese(v!),
                  )),
            ],
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Myinput(
            controller: writer[index].securitycodecontroller,
            labelText: "CAE/Social Security",
            onChanged: (v) {
              final val = TextSelection.collapsed(
                  offset:
                      writer[index].securitycodecontroller.value.text.length);
              writer[index].securitycodecontroller.selection = val;
            },
            validate: (v) => controller.validateThese(v!),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Myinput(
            ontap: () async {
              DateTime? pickdate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now());
              if (pickdate != null) {
                writer[index].birthdatecontroller.text =
                    DateFormat("yyyy-MM-dd").format(pickdate);
              }
            },
            icon: Icon(
              Icons.calendar_today_rounded,
              color: MyColors.BordersGrey,
            ),
            controller: writer[index].birthdatecontroller,
            labelText: "Birthday",
            validate: (v) => controller.validateThese(v!),
          ),
        ],
      ));
}
