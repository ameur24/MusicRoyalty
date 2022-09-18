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
            onChanged: (v) => writer[index].namecontroller.text = v,
            validate: (v) => controller.validateThese(v!),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Myinput(
            controller: writer[index].addresscontroller,
            labelText: "Address:",
            onChanged: (v) => writer[index].addresscontroller.text = v,
            validate: (v) => controller.validateThese(v!),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Myinput(
            controller: writer[index].phonenumbercontroller,
            labelText: "Phone number:",
            keyboardType: TextInputType.phone,
            onChanged: (v) => writer[index].phonenumbercontroller.text = v,
            validate: (v) => controller.validateThese(v!),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Text(
            "List any 3rd Party publishing companies",
            style: TextStyle(
              color: MyColors.MainYellow,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            child: Obx(() => ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Myinput(
                      // what: controller.last_name.value,
                      labelText: "Publishing company Name",
                      controller: writer[index].companies[i].namecontroller,
                      onChanged: (v) =>
                          writer[index].companies[i].namecontroller.text = v,
                      // validate: (v) => controller.validateThese(v!),
                    );
                  },
                  itemCount: writer[index].companies.length,
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  writer[index].companies.add(
                      company(namecontroller: new TextEditingController()));
                },
                child: Text(
                  "Add one more Third party publishing company",
                  style: TextStyle(fontSize: 16, color: MyColors.BordersGrey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Row(
            children: [
              SizedBox(
                  width: screenWidth * .44,
                  child: Myinput(
                    controller: writer[index].lyricsownercontroller,
                    onChanged: (v) =>
                        writer[index].lyricsownercontroller.text = v,
                    labelText: "  Lyrics Ownership:",
                    validate: (v) => controller.validateThese(v!),
                  )),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              SizedBox(
                  width: screenWidth * .44,
                  child: Myinput(
                    controller: writer[index].musicOwnercontroller,
                    onChanged: (v) =>
                        writer[index].musicOwnercontroller.text = v,
                    labelText: "Music Ownership: ",
                  )),
            ],
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Myinput(
            controller: writer[index].securitycodecontroller,
            labelText: "CAE/Social Security",
            onChanged: (v) => writer[index].securitycodecontroller.text = v,
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
