import 'package:flutter/material.dart';

import '../Utils/colors.dart';

class circularMenu extends StatelessWidget {
  const circularMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: MyColors.mainblack,
      onPressed: () {},
      child: Icon(
        Icons.music_note,
        color: MyColors.MainYellow,
      ),
    );
  }
}
