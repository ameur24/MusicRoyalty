import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final Color MainColor;
  final Color? iconCol;
  final double? fontSize;
  final Function? onPressed;
  const ButtonWithIcon(
      {this.text = "",
      this.onPressed,
      this.MainColor = const Color(0xff5669FF),
      required this.iconCol,
      Key? key,
      this.fontSize = 18})
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
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(167, 167, 18, 0.6100000143051147),
                offset: Offset(0, 4),
                blurRadius: 16)
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.add_box,
            color: iconCol,
            size: 20.0,
          ),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: fontSize,
                color: iconCol,
                fontFamily: 'Exo-Black',
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
