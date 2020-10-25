import 'package:ball_anim/closed_curve.dart';
import 'package:flutter/material.dart';

class AnimatedBall extends StatefulWidget {

  AnimatedBall();

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
        var width = MediaQuery.of(context).size.width;
        var shiftX = (this.ballPositionX.value *
            (width - this.ballCompressionX.value)) / 2.0;

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