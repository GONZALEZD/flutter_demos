import 'package:ball_anim/animated_ball.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ball animation"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wallPadding = 12.0;
    final wallColor = Theme.of(context).primaryColor;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wallPadding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWall(wallColor),
          Expanded(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: Size(size.width - 2 * wallPadding, size.height),
              ),
              child: AnimatedBall(),
            ),
          ),
          _buildWall(wallColor),
        ],
      ),
    );
  }

  Widget _buildWall(Color color) {
    return Container(
      constraints: const BoxConstraints.expand(width: 2.0, height: 160.0),
      color: color,
    );
  }
}
