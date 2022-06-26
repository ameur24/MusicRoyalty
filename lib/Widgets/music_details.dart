import 'package:flutter/cupertino.dart';

class MusicDetails extends StatelessWidget {
  const MusicDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'My heart will go off',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(226, 226, 33, 1),
                            fontFamily: 'Exo',
                            fontSize: 18,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      SizedBox(width: 8),
                      Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Stack(children: <Widget>[
                            Positioned(
                                top: 2,
                                left: 10,
                                child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(4, 4)),
                                    ))),
                            Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(4, 4)),
                                    ))),
                            Positioned(
                                top: 18,
                                left: 10,
                                child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(4, 4)),
                                    ))),
                          ])),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Color.fromRGBO(31, 31, 31, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '3/15 to launch your masterpiece',
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
                    ],
                  ),
                ),
              ],
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
        ],
      ),
    );
  }
}
