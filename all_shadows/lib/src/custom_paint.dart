import 'dart:math';

import 'package:all_shadows/src/utils/shape_utils.dart';
import 'package:flutter/material.dart';

class CustomPaintTest extends StatelessWidget {
  CustomPaintTest();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        example1(),
        neumorphism(),
      ]
          .map((w) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: w,
              ))
          .toList(),
    );
  }

  Widget example1() {
    return CustomPaint(
      size: Size.square(100.0),
      willChange: false,
      isComplex: true,
      painter: ShadowedShapePainter(
          shape: ShapeUtils.createStar(Size.square(100.0)),
          shapeColor: Colors.amber,
          shadows: [
            Shadow(
              offset: Offset(2.5, 2.5),
              blurRadius: 6.0,
              color: Colors.deepOrange.withOpacity(0.5),
            )
          ]),
    );
  }

  Widget neumorphism() {
    return CustomPaint(
      size: Size.square(100.0),
      willChange: false,
      isComplex: true,
      painter: ShadowedShapePainter(
        shape: ShapeUtils.createStar(Size.square(100.0)),
        shapeColor: Colors.grey.shade50,
        shadows: [
          Shadow(
            offset: Offset(3, 3),
            blurRadius: 3.0,
            color: Colors.grey.shade300,
          ),
          // Not working, shadow is still grey
          Shadow(
            offset: Offset(-3.0, -3.0),
            blurRadius: 3.0,
            color: Colors.white.withOpacity(0.9),
          ),
        ],
      ),
    );
  }
}

class ShadowedShapePainter extends CustomPainter {
  final Path shape;
  final Color shapeColor;
  final List<Shadow> shadows;
  final Paint _paint;
  final Paint _shadowPaint;

  ShadowedShapePainter({this.shape, this.shapeColor, this.shadows})
      : _paint = Paint()
          ..color = shapeColor
          ..style = PaintingStyle.fill
          ..isAntiAlias = true,
        _shadowPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    shadows.forEach((s) {
      _shadowPaint
        ..color = s.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, sqrt(s.blurRadius));
      canvas.save();
      canvas.translate(s.offset.dx, s.offset.dy);
      canvas.drawPath(shape, _shadowPaint);
      canvas.restore();
      // We want to avoid Canvas.drawShadow for neumorphism design,
      // as it draws a greyed shadow !
      //canvas.drawShadow(shape, s.color, sqrt(s.blurRadius), false);
    });
    canvas.drawPath(shape, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
