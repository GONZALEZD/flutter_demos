import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:object_anim/leaf.dart';

class AnimatedLeaf extends StatefulWidget {
  @override
  _AnimatedLeafState createState() => _AnimatedLeafState();
}

class _AnimatedLeafState extends State<AnimatedLeaf> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Leaf> _animation;

  @override
  void initState() {
    super.initState();
    _resetAnimation();
  }

  @override
  void didUpdateWidget(covariant AnimatedLeaf oldWidget) {
    super.didUpdateWidget(oldWidget);
    _resetAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _resetAnimation() {
    _animationController?.dispose();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 10000));
    // building sequence
    List<TweenSequenceItem<Leaf>> items = [];
    var mainFrames = this._mainFrames(
      fallHeight: 500.0,
      velocityHeight: 100.0,
    );
    for (var i = 1; i < mainFrames.length; i++) {
      items.add(
        TweenSequenceItem(
          tween: Tween(begin: mainFrames[i - 1], end: mainFrames[i])
              .chain(CurveTween(curve: Curves.easeInOutCubic)),
          weight: (mainFrames[i - 1].y - mainFrames[i].y).abs(),
        ),
      );
    }
    _animation = TweenSequence<Leaf>(items).animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimation(),
        FlatButton(
          onPressed: () => _animationController.forward(from: 0.0),
          child: Text("Play again!"),
        ),
      ],
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            size: Size(200, 500),
            isComplex: true,
            willChange: true,
            painter: LeafPainter(
              color: Colors.amber,
              size: 20.0,
              pos: _animation.value.pos,
              arc: _animation.value.rotation,
            ),
          );
          // return Transform(
          //   origin: Offset(0.0, -200.0),
          //   alignment: Alignment.topCenter,
          //   transform: Matrix4.translationValues(
          //       0.0,
          //       _animation.value.y,
          //       0.0)
          //     ..rotateZ(_animation.value.rotation)
          //   ,
          //   child: SizedBox.fromSize(
          //     size: Size(20.0, 4.0),
          //     child: ColoredBox(color: Colors.amber),
          //   )
          //   ,
          // );
        });
  }

  List<Leaf> _mainFrames({double fallHeight, double velocityHeight}) {
    double maxAngle = -math.pi / 4;
    double shiftX = 100.0;
    var first = Leaf(x: 50.0, y: 0.0, rotation: 0.0);
    var keyFrames = [first];
    for (var fall = velocityHeight; fall < fallHeight; fall += velocityHeight) {
      keyFrames.add(Leaf(x: shiftX, y: fall, rotation: maxAngle));
      shiftX = -shiftX;
      maxAngle = -maxAngle;
    }
    keyFrames.add(Leaf(x: 0.0, y: fallHeight, rotation: 0.0));
    return keyFrames;
  }
}

class LeafPainter extends CustomPainter {
  final Offset pos;
  final double size;
  final double arc;
  final Paint _painter;

  LeafPainter({this.pos, this.size, this.arc, Color color})
      : _painter = Paint()
          ..color = color
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    Path p = Path();
    p.moveTo(pos.dx, pos.dy);
    Offset endPoint = Offset(pos.dx + this.size, pos.dy + this.size * math.sin(arc));
    Offset x1;
    if (endPoint.dy > pos.dy) {
      x1 = Offset(pos.dx, endPoint.dy);
    }
    else {
      x1 = Offset(endPoint.dx, pos.dy);
    }
    p.quadraticBezierTo(x1.dx, x1.dy, endPoint.dx, endPoint.dy);
    // p.arcToPoint(endPoint, rotation: arc, clockwise:false, radius: Radius.circular(0.05),);
    canvas.drawPath(p, _painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is LeafPainter) {
      return this.pos != oldDelegate.pos ||
          this.size != oldDelegate.size ||
          this.arc != oldDelegate.arc;
    }
    return true;
  }
}
