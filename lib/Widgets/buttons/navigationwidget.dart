import 'package:flutter/material.dart';
import 'package:music_royalty/Utils/colors.dart';

class NavigationWidget extends StatelessWidget {
  final String text;
  final Color MainColor;
  final Color? iconCol;
  final IconData? icon;
  final double? fontSize;
  final Function? onPressed;
  final String stepName;
  final double? hight;
  final double? widht;
  const NavigationWidget(
      {this.text = "",
      this.onPressed,
      this.stepName = "",
      this.icon,
      this.widht,
      this.hight,
      this.MainColor = const Color(0xff5669FF),
      required this.iconCol,
      Key? key,
      this.fontSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: widht,
          backgroundColor: MainColor,
          child: Center(
              child: IconButton(
            onPressed: onPressed as void Function()?,
            icon: Icon(
              icon,
              color: iconCol,
            ),
          )),
        ),
        SizedBox(
          height: hight,
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontFamily: "Exo-Medium"),
        ),
      ],
    );
  }
}
