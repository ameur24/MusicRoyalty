import 'package:flutter/material.dart';
import 'package:music_royalty/Utils/colors.dart';

import '../../../Widgets/Texts/big_text.dart';
import '../../../Widgets/froms/input_field.dart';

class musicTitle extends StatelessWidget {
  const musicTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          height: screenHeight * .45,
          decoration: BoxDecoration(
              color: MyColors.mainblack,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: screenHeight * .02,
                ),
                Text(
                  'Get Started',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: MyColors.MainYellow,
                      fontFamily: 'Exo-Bold',
                      fontSize: 30,
                      height: 1.2),
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: MyColors.MainYellow,
                    ),
                    SizedBox(
                      width: screenWidth * .05,
                    ),
                    Expanded(
                      child: BigText(
                        color: Colors.white60,
                        overflow: TextOverflow.clip,
                        text:
                            "Now that you have recorded your music , it's time for the next steps.. ",
                        size: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                BigText(
                  overflow: TextOverflow.clip,
                  text: "Let's start by getting your music name",
                  size: 18,
                ),
                SizedBox(
                  height: screenHeight * .015,
                ),
                Myinput(
                    labelText: "Music name",
                    textInputAction: TextInputAction.done),
                SizedBox(
                  height: screenHeight * .03,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: MyColors.mainblack,
                          fontSize: 16,
                          fontFamily: 'Exo-Bold',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        primary: MyColors.MainYellow,
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * .026,
                            horizontal: screenWidth * .37),
                      )),
                )
              ],
            ),
          )),
    ));
  }
}
