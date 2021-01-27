import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './MyAppBar.dart';
import './MyBackButton.dart';
import 'package:adobe_xd/page_link.dart';
import './TitleCell.dart';
import './FishCell.dart';

class ListPage extends StatelessWidget {
  ListPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fcff),
      body: Stack(
        children: <Widget>[
          Pinned.fromSize(
            bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 73.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'My App Bar' (component)
                MyAppBar(),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(6.0, 0.0, 60.0, 73.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'My Back Button' (component)
                PageLink(
              links: [
                PageLinkInfo(),
              ],
              child: MyBackButton(),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(1.0, 73.0, 374.0, 83.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Title Cell' (component)
                TitleCell(),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(1.0, 495.0, 374.0, 83.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Title Cell' (component)
                TitleCell(),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(-0.2, 269.0, 375.2, 113.0),
            size: Size(375.0, 812.0),
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Fish Cell' (component)
                FishCell(),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(-0.2, 382.0, 375.2, 113.0),
            size: Size(375.0, 812.0),
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Fish Cell' (component)
                FishCell(),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(-0.2, 578.0, 375.2, 113.0),
            size: Size(375.0, 812.0),
            pinBottom: true,
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Fish Cell' (component)
                FishCell(),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(-0.2, 804.0, 375.2, 113.0),
            size: Size(375.0, 812.0),
            pinBottom: true,
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Fish Cell' (component)
                FishCell(),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(-0.2, 691.0, 375.2, 113.0),
            size: Size(375.0, 812.0),
            pinBottom: true,
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Fish Cell' (component)
                FishCell(),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(-0.2, 156.0, 375.2, 113.0),
            size: Size(375.0, 812.0),
            fixedWidth: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Fish Cell' (component)
                FishCell(),
          ),
        ],
      ),
    );
  }
}
