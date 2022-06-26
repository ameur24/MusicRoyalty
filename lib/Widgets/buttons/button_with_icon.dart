import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final Color MainColor;
  final Color? iconCol;
  final Function? onPressed;
  const ButtonWithIcon(
      {this.text = "",
      this.onPressed,
      this.MainColor = const Color(0xff5669FF),
      required this.iconCol,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        elevation: 8,
        primary: MainColor,
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.add_box,
            color: iconCol,
            size: 20.0,
          ),
          Text(
            text,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 18,
              color: iconCol,
              fontFamily: 'Exo-Black',
            ),
          ),
        ]),
      ),
    );
  }
}
