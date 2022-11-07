import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:music_royalty/Screens/Authentication/landing_page.dart';

import '../Screens/main/music_steps/checker.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Checker();
          } else {
            return landingPage();
          }
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
