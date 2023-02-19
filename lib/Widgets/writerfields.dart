import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
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
        mainAxisSize: MainAxisSize.min,
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
            labelText: "Address 1",
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
            controller: writer[index].address2controller,
            labelText: "Address 2 (optional)",
            onChanged: (v) {
              final val = TextSelection.collapsed(
                  offset: writer[index].address2controller.value.text.length);
              writer[index].address2controller.selection = val;
            },
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
          SizedBox(
            height: screenHeight * .01,
          ),
          Myinput(
            controller: writer[index].affiliation,
            labelText: "PRO Affiliation:(Ascap/Bmi/Sesac)",
            onChanged: (v) {
              final val = TextSelection.collapsed(
                  offset: writer[index].affiliation.value.text.length);
              writer[index].affiliation.selection = val;
            },
            validate: (v) => controller.validateThese(v!),
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                    child: Myinput(
                  keyboardType: TextInputType.number,
                  Suffixiconoff: Icons.percent,
                  Suffixicon: Icons.percent,
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
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
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
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * .01,
          ),
          GestureDetector(
            onTap: () async {
              var datePicked = await DatePicker.showSimpleDatePicker(
                context,
                backgroundColor: MyColors.mainblack,
                itemTextStyle: TextStyle(color: Colors.white),
                textColor: MyColors.MainYellow,
                initialDate: DateTime(1994),
                firstDate: DateTime(1960),
                lastDate: DateTime(2012),
                dateFormat: "MMMM-dd-yyyy",
                locale: DateTimePickerLocale.en_us,
                looping: true,
              );
              writer[index].birthdatecontroller.text =
                  DateFormat("MM-dd-yyyy").format(datePicked!);
              final snackBar = SnackBar(
                  content: Text("Date Picked " +
                      writer[index].birthdatecontroller.value.text));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              ;
            },
            child: Myinput(
              enabled: false,
              icon: Icon(
                Icons.calendar_today_rounded,
                color: MyColors.BordersGrey,
              ),
              controller: writer[index].birthdatecontroller,
              labelText: "Birthday",
              validate: (v) => controller.validateThese(v!),
            ),
          ),
        ],
      ));
}
