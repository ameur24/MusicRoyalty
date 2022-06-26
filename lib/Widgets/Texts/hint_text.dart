import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class hintText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  final TextOverflow overflow;
  hintText(
      {Key? key,
      this.color = const Color(0xff595959),
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size = 12.24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontSize: size,
          letterSpacing: 0.03,
          height: 1.3571428293219325),
    );
  }
}
