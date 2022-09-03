import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/Authentication/sign_up.dart';
import 'package:music_royalty/Screens/Authentication/sign_up_google.dart';
import 'package:music_royalty/Screens/main/empty_main.dart';
import 'package:music_royalty/Screens/main/mymusic.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:music_royalty/Widgets/froms/input_field.dart';

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
                    fontFamily: 'Exo-Black',
                    fontSize: 54,
                    height: 1.2),
              ),
            ),
            SizedBox(
              height: screenHeight * .03,
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * .2),
              child: const Text(
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
                onPressed: () => signInWithGoogle(),
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
                onPressed: () => Get.defaultDialog(
                    confirmTextColor: MyColors.mainblack,
                    title: "Welcome Back",
                    buttonColor: MyColors.MainYellow,
                    textConfirm: "Login",
                    backgroundColor: MyColors.mainblack,
                    titleStyle:
                        TextStyle(color: MyColors.MainYellow, fontSize: 24),
                    content: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * .02),
                      child: Column(
                        children: [
                          Myinput(
                            labelText: "Email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          Myinput(
                            labelText: "Password",
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot Password?",
                                style:
                                    TextStyle(color: const Color(0xffE2E221)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onConfirm: () => print("Login"),
                    middleText: "Dialog made in 3 lines of code"),
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
                    Icon(
                      Icons.email_outlined,
                      color: Color.fromRGBO(70, 68, 68, 1),
                    ),
                    Text(
                      'Continue with Email',
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
            TextButton(
                onPressed: () => Get.to(signup()),
                child: Text(
                  'Sign up ',
                  style: TextStyle(color: MyColors.ButtonIcon),
                ))
          ],
        ),
      )
    ]);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var Exists = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((docSnapshot) async => {
                  if (docSnapshot.exists)
                    // empty main tetbadel ken user ando  music twali ndhahrolo mymusic()
                    {
                      await FirebaseFirestore.instance
                          .collection("Music")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((docSnapshot) => {
                                if (docSnapshot.exists)
                                  {
                                    Get.off(myMusic()),
                                  }
                                else
                                  {Get.off(EmptyMain()), print("azsss $e")}
                              }),
                    }
                  else
                    {Get.to(signup_google())}
                });
      }
    });
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
