import 'package:flutter/cupertino.dart';

class writer {
  int index;
  String name;
  String address;
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
  TextEditingController phonenumbercontroller;
  List<company> companies;
  TextEditingController musicOwnercontroller;
  TextEditingController lyricsownercontroller;
  TextEditingController securitycodecontroller;
  TextEditingController birthdatecontroller;

  textcontroller(
      {required this.namecontroller,
      required this.addresscontroller,
      required this.phonenumbercontroller,
      required this.companies,
      required this.musicOwnercontroller,
      required this.lyricsownercontroller,
      required this.securitycodecontroller,
      required this.birthdatecontroller});
}

class company {
  TextEditingController namecontroller;
  company({required this.namecontroller});
}