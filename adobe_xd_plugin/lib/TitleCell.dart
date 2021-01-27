import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class TitleCell extends StatelessWidget {
  TitleCell({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 374.0, 83.0),
          size: Size(374.0, 83.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(4.0, 5.0, 365.0, 75.0),
          size: Size(374.0, 83.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [const Color(0xff77c6ff), const Color(0xff0092ff)],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(21.0, 28.0, 230.0, 28.0),
          size: Size(374.0, 83.0),
          pinLeft: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'Listview title example',
            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 24,
              color: const Color(0xffffffff),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
