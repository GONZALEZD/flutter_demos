import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 73.0),
          size: Size(375.0, 73.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff0093ff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(99.0, 25.0, 177.0, 23.0),
          size: Size(375.0, 73.0),
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'Adobe XD to Flutter',
            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 20,
              color: const Color(0xffffffff),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
