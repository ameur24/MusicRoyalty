import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:ui' show ImageFilter;
import 'package:music_royalty/Screens/Authentication/sign_up.dart';
import 'package:music_royalty/Screens/Authentication/sign_up_google.dart';
import 'package:music_royalty/Screens/main/empty_main.dart';
import 'package:music_royalty/Screens/main/mymusic.dart';
import 'package:music_royalty/Utils/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:music_royalty/Widgets/froms/input_field.dart';
import 'package:music_royalty/controllers/music_controller.dart';

import '../main/music_steps/checker.dart';
import '../main/music_steps/verifypage.dart';
import '../splash.dart';
import 'forgetpasswordscreen.dart';

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
    MusicController muController = Get.find<MusicController>();
    Get.put(MusicController());
    Splash();

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
            Spacer(),
            Platform.isAndroid
                ? ElevatedButton(
                    onPressed: () => signInWithGoogle(muController),
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * .02),
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
                    ))
                : ElevatedButton(
                    onPressed: () => signInWithApple(muController),
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * .02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.apple),
                        Text(
                          'Continue with Apple',
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
                onPressed: () => showDialog(
                      useSafeArea: false,
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) => FittedBox(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            insetPadding: EdgeInsets.all(20),
                            backgroundColor: MyColors.mainblack,
                            child: SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: GestureDetector(
                                onTap: () => FocusManager.instance.primaryFocus
                                    ?.unfocus(),
                                child: Obx(() => Container(
                                    padding: EdgeInsets.all(30),
                                    height: muController.switched.value == false
                                        ? screenHeight * 0.64
                                        : screenHeight * 0.72,
                                    decoration: BoxDecoration(
                                        color: MyColors.mainblack,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    width: screenWidth * 0.9,
                                    child: Obx(
                                      () => Form(
                                        key: muController.SignInupKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              muController.switched.value ==
                                                      false
                                                  ? "Login"
                                                  : "Sign Up",
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.04,
                                            ),
                                            Myinput(
                                              icon: Icon(
                                                Icons.email,
                                                color: MyColors.MainYellow,
                                              ),
                                              controller: muController
                                                  .signinupemailcontroller
                                                  .value,
                                              validate: (v) => v != null &&
                                                      !EmailValidator.validate(
                                                          v)
                                                  ? 'Enter a valid email'
                                                  : null,
                                              onChanged: (value) {
                                                final val = TextSelection.collapsed(
                                                    offset: muController
                                                        .signinupemailcontroller
                                                        .value
                                                        .text
                                                        .length);
                                                muController
                                                    .signinupemailcontroller
                                                    .value
                                                    .selection = val;
                                              },
                                              cursorcolor: MyColors.MainYellow,
                                              labelText: "Email",
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                            SizedBox(
                                              height: screenHeight * .01,
                                            ),
                                            Myinput(
                                              controller: muController
                                                  .signinuppasswordcontroller
                                                  .value,
                                              icon: Icon(
                                                Icons.lock,
                                                color: MyColors.MainYellow,
                                              ),
                                              Suffixicon: Icons.visibility,
                                              validate: (v) => muController
                                                  .validatePasswordlen(muController
                                                      .signinuppasswordcontroller
                                                      .value
                                                      .text),
                                              Suffixiconoff:
                                                  Icons.visibility_off,
                                              obscureText:
                                                  muController.passwtogg1.value,
                                              suffixiconfun: () {
                                                muController.passwtogg1.value =
                                                    !muController
                                                        .passwtogg1.value;
                                              },
                                              cursorcolor: MyColors.MainYellow,
                                              labelText: "Password",
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                            ),
                                            SizedBox(
                                              height: screenHeight * .01,
                                            ),
                                            muController.switched.value == true
                                                ? Myinput(
                                                    controller: muController
                                                        .signinuppasswordconfirmcontroller
                                                        .value,
                                                    icon: Icon(
                                                      Icons.lock,
                                                      color:
                                                          MyColors.MainYellow,
                                                    ),
                                                    Suffixicon:
                                                        Icons.visibility,
                                                    validate: (v) => muController
                                                        .validatePassword(
                                                            muController
                                                                .signinuppasswordcontroller
                                                                .value
                                                                .text,
                                                            muController
                                                                .signinuppasswordconfirmcontroller
                                                                .value
                                                                .text),
                                                    Suffixiconoff:
                                                        Icons.visibility_off,
                                                    obscureText: muController
                                                        .passwtogg2.value,
                                                    suffixiconfun: () {
                                                      muController.passwtogg2
                                                              .value =
                                                          !muController
                                                              .passwtogg2.value;
                                                    },
                                                    cursorcolor:
                                                        MyColors.MainYellow,
                                                    labelText:
                                                        "Confirm Password",
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                  )
                                                : SizedBox.shrink(),
                                            SizedBox(
                                              height: screenHeight * 0.01,
                                            ),
                                            muController.switched.value == false
                                                ? Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "Forgot Password?",
                                                                style:
                                                                    TextStyle(
                                                                  color: MyColors
                                                                      .BordersGrey,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                  recognizer: new TapGestureRecognizer()
                                                                    ..onTap = () =>
                                                                        Get.to(
                                                                            ForgotPasswordScreen()) /*  */,
                                                                  text:
                                                                      ' Reset Password',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ])))
                                                : SizedBox.shrink(),
                                            SizedBox(
                                              height: screenHeight * 0.02,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: screenWidth * 0.12,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          MyColors.MainYellow
                                                              .withOpacity(.8)),
                                                ),
                                                onPressed: () async {
                                                  bool isValidate = muController
                                                      .SignInupKey.currentState!
                                                      .validate();
                                                  if (isValidate) {
                                                    if (muController
                                                            .switched.value ==
                                                        false) {
                                                      await FirebaseAuth
                                                          .instance
                                                          .signInWithEmailAndPassword(
                                                              email: muController
                                                                  .signinupemailcontroller
                                                                  .value
                                                                  .text,
                                                              password: muController
                                                                  .signinuppasswordcontroller
                                                                  .value
                                                                  .text)
                                                          .then((value) {
                                                        Get.offAll(Checker());
                                                      }).onError((error,
                                                              stackTrace) {
                                                        Get.snackbar(
                                                            "Bad Credentials",
                                                            "Incorrect Password given",
                                                            snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM);
                                                      });
                                                    } else {
                                                      try {
                                                        await FirebaseAuth
                                                            .instance
                                                            .createUserWithEmailAndPassword(
                                                                email: muController
                                                                    .signinupemailcontroller
                                                                    .value
                                                                    .text,
                                                                password:
                                                                    muController
                                                                        .signinuppasswordcontroller
                                                                        .value
                                                                        .text);
                                                        Get.offAll(
                                                            VerifyPage());
                                                      } on FirebaseAuthException catch (e) {
                                                        Get.snackbar(
                                                            e.code.toString(),
                                                            e.message
                                                                .toString(),
                                                            snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM);
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  muController.switched.value ==
                                                          false
                                                      ? "Sign in"
                                                      : "Sign up",
                                                  style: TextStyle(
                                                      fontFamily: "Open-Sans",
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.02,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: muController
                                                                      .switched
                                                                      .value ==
                                                                  false
                                                              ? "Don't have an account??"
                                                              : "Already a user?",
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .BordersGrey),
                                                        ),
                                                        TextSpan(
                                                            recognizer:
                                                                new TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    muController
                                                                            .switched
                                                                            .value =
                                                                        !muController
                                                                            .switched
                                                                            .value;

                                                                    muController
                                                                        .signinupemailcontroller
                                                                        .value
                                                                        .text = "";
                                                                    muController
                                                                        .signinuppasswordcontroller
                                                                        .value
                                                                        .text = "";
                                                                    muController
                                                                        .signinuppasswordconfirmcontroller
                                                                        .value
                                                                        .text = "";
                                                                  },
                                                            text: muController
                                                                        .switched
                                                                        .value ==
                                                                    false
                                                                ? 'Sign up'
                                                                : 'Sign in',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ])),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
            SizedBox(
              height: screenHeight * 0.04,
            )
          ],
        ),
      )
    ]);
  }

  Future<UserCredential> signInWithGoogle(muController) async {
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
            .then((docSnapshot) async {
          if (docSnapshot.exists) {
            await muController.checkMusicExist();
            if (muController.Empty.value == false) {
              Get.offAll(myMusic());
            } else {
              Get.offAll(EmptyMain());
              print("azsss $e");
            }
          } else {
            Get.to(signup_google());
          }
        });
      }
    });
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithApple(muController) async {
    final appleProvider = AppleAuthProvider();
    late UserCredential credential;
    if (kIsWeb) {
      credential = await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      credential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }

    await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var Exists = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((docSnapshot) async {
          if (docSnapshot.exists) {
            await muController.checkMusicExist();
            if (muController.Empty.value == false) {
              Get.offAll(myMusic());
            } else {
              Get.offAll(EmptyMain());
              print("azsss $e");
            }
          } else {
            Get.to(signup_google());
          }
        });
      }
    });
    return credential;
  }

/*   Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  } */
}
