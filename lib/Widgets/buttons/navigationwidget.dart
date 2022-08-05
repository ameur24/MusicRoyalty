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

  const NavigationWidget(
      {this.text = "",
      this.onPressed,
      this.stepName = "",
      this.icon,
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
        Text(
          stepName,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
        SizedBox(
          height: 10,
        ),
        CircleAvatar(
          radius: 30,
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
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ],
    );
  }
}
