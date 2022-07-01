import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_royalty/Widgets/Texts/big_text.dart';

import '../../../Utils/colors.dart';

class musicSteps extends StatelessWidget {
  const musicSteps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.blackbackground1,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: MyColors.blackbackground1,
      ),
      body: Stack(
        children: <Widget>[SongName(screenHeight)],
      ),
    );
  }

  Widget SongName(double screenHeight) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * .05,
        ),
        Text(
          'Music Name',
          textAlign: TextAlign.left,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: MyColors.MainYellow,
              fontFamily: 'Exo-ExtraBold',
              fontSize: 32,
              height: 1.2),
        ),
        SizedBox(
          height: screenHeight * .02,
        ),
        const Expanded(
            child: BigText(
                text:
                    "Now that you have recorded your music , here are the next steps"))
      ],
    );
  }

  Widget Steps() {
    return ListView();
  }

  Widget Item(BuildContext context,
      {required String text,
      final Function? onTap,
      required IconData icon,
      final bool isSelected = false}) {
    final color = Colors.grey[600];
    return Material(
      color: Colors.transparent,
      child: ListTile(
          dense: true,
          textColor: color,
          selected: false,
          leading: Icon(icon),
          title: Text(
            text,
            style: const TextStyle(fontFamily: 'Roboto-Bold', fontSize: 15),
          ),
          onTap: onTap as void Function()?),
    );
  }
}
