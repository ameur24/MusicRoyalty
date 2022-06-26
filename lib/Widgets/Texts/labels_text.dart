import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LabelsText extends StatelessWidget {
  Color? color;
  final String text;
  final double size;
  TextOverflow overflow;
  LabelsText(
      {Key? key,
      this.color,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: 'Exo-SemiBold',
        letterSpacing: 0.03,
      ),
    );
  }
}
