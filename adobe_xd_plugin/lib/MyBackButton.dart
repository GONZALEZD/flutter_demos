import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBackButton extends StatelessWidget {
  MyBackButton({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 60.0, 73.0),
          size: Size(60.0, 73.0),
          pinTop: true,
          pinBottom: true,
          fixedWidth: true,
          child: Container(
            decoration: BoxDecoration(),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(2.0, 20.5, 11.5, 31.1),
          size: Size(60.0, 73.0),
          pinLeft: true,
          pinBottom: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_cq9tx7,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(18.8, 26.0, 41.0, 21.0),
          size: Size(60.0, 73.0),
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          fixedWidth: true,
          child: Text(
            'Back',
            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 18,
              color: const Color(0xffffffff),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

const String _svg_cq9tx7 =
    '<svg viewBox="2.0 20.5 11.5 31.1" ><path transform="translate(-637.22, 2.76)" d="M 650.6934814453125 17.74215316772461 L 639.2177734375 33.04694747924805 L 650.6934814453125 48.83821487426758" fill="none" stroke="#ffffff" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
