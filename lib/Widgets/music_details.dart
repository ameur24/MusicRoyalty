import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_royalty/Utils/colors.dart';

class MusicDetails extends StatelessWidget {
  final double screenHeight, screenwidth;
  final Function? onPressed;
  final Function(dynamic)? menuItemSelected;
  final int? val;
  const MusicDetails({
    Key? key,
    required this.screenHeight,
    required this.screenwidth,
    this.onPressed,
    this.menuItemSelected,
    this.val,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
          splashColor: MyColors.MainYellow,
          onTap: onPressed as void Function()?,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    offset: Offset(0, 2),
                    blurRadius: 12)
              ],
              color: Color.fromRGBO(18, 18, 18, 1),
              border: Border.all(
                color: Color.fromRGBO(83, 83, 83, 1),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'My heart will go off',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(226, 226, 33, 1),
                              fontFamily: 'Exo-SemiBold',
                              fontSize: 18,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        DropdownButton(
                          items: [
                            DropdownMenuItem(
                                // onTap: menuItemSelected as void Function()?,
                                child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: MyColors.MainYellow,
                                ),
                                Text("Music Details")
                              ],
                            )),
                            DropdownMenuItem(
                                //  onTap: menuItemSelected as void Function()?,
                                child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: MyColors.MainYellow,
                                ),
                                Text("Music Details")
                              ],
                            )),
                          ],
                          icon: IconButton(
                            onPressed: () => {},
                            icon: Icon(Icons.more_vert),
                            color: Colors.white,
                          ),
                          onChanged: (value) => menuItemSelected!(value) as void
                              Function(dynamic)?,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: screenwidth * .75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromRGBO(31, 31, 31, 1),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: const Text(
                        '3/15 Steps completed',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(251, 251, 251, 1),
                            fontFamily: 'Exo',
                            fontSize: 14,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'last update 1 days ago',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(185, 185, 185, 1),
                          fontFamily: 'Exo',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ]),
            ),
          )),
    );
  }
}
