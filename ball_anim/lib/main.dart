import 'package:ball_anim/closed_curve.dart';
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
    final width = MediaQuery
        .of(context)
        .size
        .width;
    var wallPadding = 12.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wallPadding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWall(),
          Expanded(child: AnimatedBall(width: width - 2 * wallPadding,)),
          _buildWall(),
        ],
      ),
    );
  }

  Widget _buildWall() {
    return Container(
      constraints: BoxConstraints.expand(width: 2.0, height: 160.0),
      color: Colors.grey,
    );
  }
}

class AnimatedBall extends StatefulWidget {
  final double width;

  AnimatedBall({this.width});

  @override
  _AnimatedBallState createState() => _AnimatedBallState();
}

class _AnimatedBallState extends State<AnimatedBall> with TickerProviderStateMixin {
  AnimationController controller;
  Animation ballPositionX;
  Animation ballCompressionX;
  Animation ballCompressionY;
  Animation ballCompressionColor;
  double ballRadius = 32.0;

  @override
  void initState() {
    super.initState();
    this.controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1200));
    var twoPipes = LoopingTween(curve: ClosedCurves.pipe, periods: 2.0);
    this.ballPositionX = LoopingTween(curve: ClosedCurves.cosinus).animate(this.controller);
    this.ballCompressionX = Tween(begin: ballRadius, end: ballRadius - 10.0)
        .chain(CurveTween(curve: Interval(0.7, 1.0)))
        .chain(twoPipes)
        .animate(this.controller);
    this.ballCompressionY = Tween(begin: ballRadius, end: ballRadius + 10.0)
        .chain(CurveTween(curve: Interval(0.7, 1.0)))
        .chain(twoPipes)
        .animate(this.controller);
    this.ballCompressionColor = ColorTween(begin: Colors.redAccent.shade700, end: Colors.redAccent)
        .chain(twoPipes)
        .animate(this.controller);
    this.controller.repeat();
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.controller,
      builder: (context, child) {
        var shiftX = (this.ballPositionX.value *
            (this.widget.width - this.ballCompressionX.value)) / 2.0;

        return Container(
          alignment: Alignment.center,
          transform: Matrix4.translationValues(shiftX, 0.0, 0.0),
          child: SizedBox(
            width: this.ballCompressionX.value,
            height: this.ballCompressionY.value,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: this.ballCompressionColor.value,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(ballRadius),
              ),
            ),
          ),
        );
      },
    );
  }
}
