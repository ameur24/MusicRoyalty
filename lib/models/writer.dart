import 'package:flutter/cupertino.dart';

class writer {
  int index;
  String name;
  String address;
  String address2 = '';
  String phonenumber;
  List<company> companies;
  String musicOwner;
  String lyricsowner;
  String securitycode;
  String birthdate;
  writer(
      {required this.index,
      required this.name,
      required this.address,
      required this.phonenumber,
      required this.companies,
      required this.musicOwner,
      required this.lyricsowner,
      required this.securitycode,
      required this.birthdate});
}

class textcontroller {
  TextEditingController namecontroller;
  TextEditingController addresscontroller;
  TextEditingController address2controller;
  TextEditingController phonenumbercontroller;

  TextEditingController musicOwnercontroller;
  TextEditingController lyricsownercontroller;
  TextEditingController securitycodecontroller;
  TextEditingController birthdatecontroller;
  TextEditingController affiliation;
  textcontroller(
      {required this.namecontroller,
      required this.addresscontroller,
      required this.address2controller,
      required this.phonenumbercontroller,
      required this.musicOwnercontroller,
      required this.affiliation,
      required this.lyricsownercontroller,
      required this.securitycodecontroller,
      required this.birthdatecontroller});
}

class company {
  TextEditingController namecontroller;
  TextEditingController lyricscontroller;
  company({required this.namecontroller, required this.lyricscontroller});
}
