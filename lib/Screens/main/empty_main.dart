import 'package:flutter/material.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:music_royalty/Widgets/Texts/big_text.dart';

import '../../Widgets/buttons/button_with_icon.dart';

class EmptyMain extends StatelessWidget {
  const EmptyMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(children: [
      AnimatedContainer(
        width: screenWidth,
        curve: Curves.easeInOutBack,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
              // BlendMode.colorDodge
              image: AssetImage('assets/splash.png'),
              fit: BoxFit.fitWidth),
        ),
        duration: const Duration(seconds: 20),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * .1,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: MyColors.mainblack,
                  child: Icon(
                    Icons.music_note,
                    color: MyColors.MainYellow,
                  ),
                ),
                Text("  Welcome Hamadi",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white70,
                        fontFamily: 'Exo-Black',
                        fontSize: 22)),
              ],
            ),
            SizedBox(
              height: screenHeight * .4,
            ),
            Text(
              'Let’s create your first masterpiece',
              textAlign: TextAlign.left,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: MyColors.MainYellow,
                  fontFamily: 'Exo-Black',
                  fontSize: 54,
                  height: 1.2),
            ),
            SizedBox(
              height: screenHeight * .08,
            ),
            ButtonWithIcon(
              onPressed: () {},
              iconCol: MyColors.mainGrey,
              text: "Get Started",
              MainColor: MyColors.MainYellow,
            )
          ],
        ),
      )
    ]);
  }
}
