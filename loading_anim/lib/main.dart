import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loading_anim/closed_curve.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: IndeterminateProgressBar(
          size: 58.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class IndeterminateProgressBar extends StatefulWidget {
  final MaterialColor color;
  final double size;

  IndeterminateProgressBar({this.color, this.size = 48.0});

  @override
  _IndeterminateProgressBarState createState() => _IndeterminateProgressBarState();
}

class _IndeterminateProgressBarState extends State<IndeterminateProgressBar>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _dashesRotation;
  Animation _dashesWidth;

  @override
  void initState() {
    super.initState();
    _resetAnimations();
  }

  @override
  void didUpdateWidget(covariant IndeterminateProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _resetAnimations();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _resetAnimations() {
    _animationController?.dispose();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    _dashesWidth = Tween(begin: 0.1, end: math.pi)
        .chain(ClosedCurveTween(curve: ParabolCurve()))
        .chain(CurveTween(curve: Interval(0.2, 1.0)))
        .animate(_animationController);
    _dashesRotation = Tween(begin: 0.0, end: math.pi * 4)
        .chain(CurveTween(curve: Curves.linear))
        .animate(_animationController);

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size.square(this.widget.size),
              painter: DashedArc(
                color: this.widget.color.shade700,
                startAngle: _dashesRotation.value,
                sweepAngle: _dashesWidth.value,
              ),
            ),
            CustomPaint(
              size: Size.square(this.widget.size) + Offset(-10.0, -10.0),
              painter: DashedArc(
                color: this.widget.color.shade500,
                startAngle: -_dashesRotation.value,
                sweepAngle: -_dashesWidth.value,
              ),
            ),
          ],
        );
      },
    );
  }
}

class DashedArc extends CustomPainter {
  final double sweepAngle;
  final double startAngle;

  final _painter;

  DashedArc({this.sweepAngle, this.startAngle, Color color})
      : _painter = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    var bounds = Rect.fromPoints(size.topLeft(Offset.zero), size.bottomRight(Offset.zero));
    canvas.drawArc(bounds, this.startAngle, this.sweepAngle, false, _painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
