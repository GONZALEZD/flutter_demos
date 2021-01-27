import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './FishIcon.dart';

class FishCell extends StatelessWidget {
  FishCell({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 113.0),
          size: Size(375.2, 113.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(4.0, 5.0, 366.2, 104.0),
          size: Size(375.2, 113.0),
          pinLeft: true,
          pinTop: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Stack(
            children: <Widget>[
              Pinned.fromSize(
                bounds: Rect.fromLTWH(0.0, 0.0, 366.2, 104.0),
                size: Size(366.2, 104.0),
                pinLeft: true,
                pinRight: true,
                pinTop: true,
                pinBottom: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xffb7e1ff),
                  ),
                ),
              ),
              Pinned.fromSize(
                bounds: Rect.fromLTWH(112.2, 14.0, 247.0, 76.0),
                size: Size(366.2, 104.0),
                pinRight: true,
                fixedWidth: true,
                fixedHeight: true,
                child: Stack(
                  children: <Widget>[
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 27.0, 247.0, 49.0),
                      size: Size(247.0, 76.0),
                      pinLeft: true,
                      pinRight: true,
                      pinTop: true,
                      pinBottom: true,
                      child: Text(
                        'Listview item description Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue',
                          fontSize: 14,
                          color: const Color(0xff727272),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 0.0, 154.0, 23.0),
                      size: Size(247.0, 76.0),
                      pinLeft: true,
                      pinTop: true,
                      fixedWidth: true,
                      fixedHeight: true,
                      child: Text(
                        'Listview item title',
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue',
                          fontSize: 20,
                          color: const Color(0xff5a5a5a),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Pinned.fromSize(
                bounds: Rect.fromLTWH(12.0, 16.0, 70.6, 72.0),
                size: Size(366.2, 104.0),
                pinLeft: true,
                pinTop: true,
                pinBottom: true,
                fixedWidth: true,
                child:
                    // Adobe XD layer: 'Fish Icon' (component)
                    FishIcon(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
