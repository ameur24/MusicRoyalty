import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../Utils/colors.dart';

class item extends StatelessWidget {
  final String text;
  final String? description;

  final int current;
  final int thisStep;
  final Function() clickme;
  const item(
      {Key? key,
      required this.text,
      this.description,
      required this.current,
      required this.thisStep,
      required this.clickme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: Colors.transparent,
        minVerticalPadding: 20,
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: current == thisStep
                  ? MyColors.MainYellow
                  : current > thisStep
                      ? MyColors.completedLine
                      : MyColors.blackbackground1,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: current > thisStep
                    ? MyColors.completedFill.withOpacity(.4)
                    : MyColors.blackbackground1,
                child: Icon(
                  current > thisStep ? Icons.check : Icons.article_outlined,
                  color: current == thisStep
                      ? MyColors.MainYellow
                      : current > thisStep
                          ? Colors.black
                          : MyColors.NotCompletedStep,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Step $thisStep",
              style: TextStyle(
                  fontFamily: current >= thisStep ? 'Exo-Medium' : 'Exo-Medium',
                  fontSize: 13,
                  color: current == thisStep
                      ? MyColors.MainYellow
                      : current > thisStep
                          ? MyColors.completedFill
                          : MyColors.NotCompletedStepText),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Exo-Medium ', fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              description!,
              style: TextStyle(
                  fontFamily: 'Exo-Bold', fontSize: 15, color: Colors.white),
            ),
          ],
        ),
        onTap: clickme);
  }
}
