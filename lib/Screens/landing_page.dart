import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_royalty/Utils/colors.dart';

class landingPage extends StatefulWidget {
  landingPage({Key? key}) : super(key: key);

  @override
  State<landingPage> createState() => _ImageState();
}

class _ImageState extends State<landingPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(children: [
      AnimatedContainer(
        width: screenWidth,
        curve: Curves.easeInOutBack,
        height: screenHeight,
        decoration: BoxDecoration(
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
              height: screenHeight * .13,
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * .1),
              child: Text(
                'Get Paid for your music',
                textAlign: TextAlign.left,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: MyColors.MainYellow,
                    fontFamily: 'Exo',
                    fontSize: 54,
                    height: 1.2),
              ),
            ),
            SizedBox(
              height: screenHeight * .03,
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * .2),
              child: Text(
                'we help and guide artists to launch their masterpiece',
                textAlign: TextAlign.left,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(255, 255, 232, 1),
                    fontFamily: 'Exo-Medium',
                    fontSize: 18,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
            SizedBox(
              height: screenHeight * .3,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/google.png",
                      width: 24,
                      height: 24,
                    ),
                    Text(
                      'Continue with Google',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(70, 68, 68, 1),
                          fontFamily: 'Exo-Bold',
                          fontSize: 18,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    Icon(
                      Icons.arrow_right_outlined,
                      color: MyColors.ButtonIcon,
                      size: 30,
                    ),
                  ],
                )),
            SizedBox(height: screenHeight * .02),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/facebook.png",
                      width: 24,
                      height: 24,
                    ),
                    Text(
                      'Continue with Facebook',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(70, 68, 68, 1),
                          fontFamily: 'Exo-Bold',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    Icon(
                      Icons.arrow_right_outlined,
                      color: MyColors.ButtonIcon,
                      size: 30,
                    ),
                  ],
                )),
          ],
        ),
      )
    ]);
  }
}
