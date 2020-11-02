import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  final List<Offset> curve;
  static final double _paintStrokeWidth = 4.0;
  static final double _paintStrokeHalfWidth = _paintStrokeWidth / 2;
  static final double _currentPointRadius = _paintStrokeWidth*0.75;

  static final Paint _paint = Paint()
    ..color = Colors.lightBlue
    ..style = PaintingStyle.stroke;

  static final Color _axisColor = Colors.grey.shade700;
  static final Paint _paintAxis = Paint()
    ..color = _axisColor
    ..strokeWidth = _paintStrokeHalfWidth
    ..style = PaintingStyle.stroke;

  static final Paint _paintTarget = Paint()
    ..color = Colors.grey.shade300
    ..strokeWidth = _paintStrokeHalfWidth
    ..style = PaintingStyle.stroke;

  static final TextPainter _min = _createTextPainter(text: "0.0", color: _axisColor);
  static final TextPainter _ordText = _createTextPainter(text: "x", color: _axisColor);
  static final TextPainter _maxOrd = _createTextPainter(text: "1.0", color: _axisColor);
  static final TextPainter _absText = _createTextPainter(text: "t", color: _axisColor);
  static final TextPainter _maxAbs = _createTextPainter(text: "1.0s", color: _axisColor);

  GraphPainter({this.curve}) : assert(curve != null && curve.isNotEmpty);

  @override
  void paint(Canvas canvas, Size size) {
    var translateX = math.max(_min.size.width, _maxOrd.size.width);
    var newSize = size + Offset(-translateX, 0.0);
    var currentPoint = Offset(
      this.curve.last.dx * newSize.width,
      this.curve.last.dy * newSize.height,
    );
    canvas.save();
    canvas.translate(translateX, 0.0);
    _drawCurrentPointAxis(canvas, newSize, currentPoint);
    _drawAxis(canvas, newSize);
    _printText(canvas, newSize);
    canvas.save();
    canvas.scale(size.width - translateX, size.height);
    _paint.strokeWidth = _paintStrokeWidth / size.longestSide;
    canvas.drawPoints(PointMode.polygon, this.curve, _paint);
    canvas.restore();
    _drawCurrentPoint(canvas, newSize, currentPoint);
    canvas.restore();
  }

  void _drawCurrentPoint(Canvas canvas, Size size, Offset point) {
    _paint.strokeWidth = _currentPointRadius*2;
    canvas.drawCircle(point, _currentPointRadius, _paint);
  }

  void _drawCurrentPointAxis(Canvas canvas, Size size, Offset point) {
    canvas.drawLine(Offset(point.dx, 0.0), Offset(point.dx, size.height), _paintTarget);
    canvas.drawLine(Offset(0.0, point.dy), Offset(size.width, point.dy), _paintTarget);
  }

  void _drawAxis(Canvas canvas, Size size) {
    canvas.drawLine(Offset.zero, size.bottomLeft(Offset.zero), _paintAxis);
    canvas.drawLine(Offset(-4.0, 0.0), Offset(4.0, 0.0), _paintAxis);
    canvas.drawLine(size.bottomLeft(Offset.zero), size.bottomRight(Offset.zero), _paintAxis);
    canvas.drawLine(
        size.bottomRight(Offset(0.0, -4.0)), size.bottomRight(Offset(0.0, 4.0)), _paintAxis);
    canvas.drawPoints(
        PointMode.points,
        List.generate((size.width.toInt() ~/ 10) + 1, (index) => Offset(index.toDouble() * 10, 0.0))
          ..add(size.topRight(Offset.zero)),
        _paintAxis);
  }

  void _printText(Canvas canvas, Size size) {
    _min.paint(canvas, size.bottomLeft(Offset(-_min.width - 2.0, 0.0)));
    _maxOrd.paint(canvas, size.topLeft(Offset(-_maxOrd.width - 6.0, -_maxOrd.height / 2)));
    _ordText.paint(canvas, size.topLeft(Offset(6.0, 0.0)));
    _absText.paint(canvas, size.bottomRight(Offset(-_absText.width - 2.0, -_absText.height - 2.0)));
    _maxAbs.paint(canvas, size.bottomRight(Offset(-_maxAbs.width / 2, 6.0)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  static TextPainter _createTextPainter({String text, Color color}) {
    var textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: color, fontSize: 14)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter;
  }
}
