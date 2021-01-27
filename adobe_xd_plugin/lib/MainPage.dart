import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './ListPage.dart';
import 'package:adobe_xd/page_link.dart';
import './MyAppBar.dart';

class MainPage extends StatelessWidget {
  MainPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fcff),
      body: Stack(
        children: <Widget>[
          Pinned.fromSize(
            bounds: Rect.fromLTWH(202.0, 739.0, 149.0, 48.0),
            size: Size(375.0, 812.0),
            pinRight: true,
            pinBottom: true,
            fixedWidth: true,
            fixedHeight: true,
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.SlideLeft,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => ListPage(),
                ),
              ],
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 149.0, 48.0),
                    size: Size(149.0, 48.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: const Color(0xff0093ff),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 13.0, 149.0, 23.0),
                    size: Size(149.0, 48.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: Text(
                      'continue',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
            bounds: Rect.fromLTWH(88.0, 233.0, 200.0, 346.0),
            size: Size(375.0, 812.0),
            fixedWidth: true,
            fixedHeight: true,
            child: Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 200.0, 200.0, 146.0),
                  size: Size(200.0, 346.0),
                  pinLeft: true,
                  pinRight: true,
                  pinBottom: true,
                  fixedHeight: true,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 64.0, 200.0, 82.0),
                        size: Size(200.0, 146.0),
                        pinLeft: true,
                        pinRight: true,
                        pinBottom: true,
                        fixedHeight: true,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'Helvetica Neue',
                              fontSize: 20,
                              color: const Color(0xff646464),
                            ),
                            children: [
                              TextSpan(
                                text: 'To ',
                              ),
                              TextSpan(
                                text: 'Adobe XD to Flutter',
                                style: TextStyle(
                                  color: const Color(0xff0093ff),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: ' plugin experiments !',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 200.0, 56.0),
                        size: Size(200.0, 146.0),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontFamily: 'Helvetica Neue',
                            fontSize: 48,
                            color: const Color(0xff000000),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 200.0, 200.0),
                  size: Size(200.0, 346.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'image' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(400.0),
                      image: DecorationImage(
                        image: const AssetImage('assets/image_test.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
