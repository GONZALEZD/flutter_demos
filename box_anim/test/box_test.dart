import 'package:box_anim/box_shape.dart';
import 'package:flutter/material.dart' show Color;
import 'package:flutter_test/flutter_test.dart';

const double __doubleTolerance = 0.000001;


void main() {

  group("Box Content Shape", (){
    test('operator +', () async {

      BoxContentShape shape1 = BoxContentShape(scale: 1.0, altitude: 200.0);
      BoxContentShape shape2 = BoxContentShape(scale: 3.33, altitude: 444.4);

      BoxContentShape addedShapes = shape1 + shape2;
      expect(addedShapes.scale, closeTo(4.33, __doubleTolerance));
      expect(addedShapes.altitude, closeTo(644.4, __doubleTolerance));
    });

    test('operator -', () async {

      BoxContentShape shape1 = BoxContentShape(scale: 1.0, altitude: 200.0);
      BoxContentShape shape2 = BoxContentShape(scale: 3.33, altitude: 444.4);

      BoxContentShape addedShapes = shape1 - shape2;
      expect(addedShapes.scale, closeTo(-2.33, __doubleTolerance));
      expect(addedShapes.altitude, closeTo(-244.4, __doubleTolerance));
    });

    test('operator *', () async {

      BoxContentShape shape1 = BoxContentShape(scale: 1.0, altitude: 200.0);

      BoxContentShape addedShapes = shape1 * 4.1;
      expect(addedShapes.scale, closeTo(4.1, __doubleTolerance));
      expect(addedShapes.altitude, closeTo(820, __doubleTolerance));
    });
  });

  group("Testing Box Shape", () {
    test('operator +', () async {

      var shape1 = MyBoxShape(
        color: Color(0xFFFF0000),
        altitude: 100.0,
        height: 22.0,
        width: 33.0,
        paneRotation: 0.0,
        content: BoxContentShape(scale: 1.0, altitude: 100.0),
      );

      var shape2 = MyBoxShape(
        color: Color(0x0000FFFF),
        altitude: 555.5,
        height: 44.4,
        width: 66.6,
        paneRotation: 3.14,
        content: null,
      );

      MyBoxShape sumShapes = shape1 + shape2;

      expect(sumShapes.width, closeTo(99.6, __doubleTolerance));
      expect(sumShapes.height, closeTo(66.4, __doubleTolerance));
      expect(sumShapes.color, Color(0xFFFFFFFF));
      expect(sumShapes.altitude, closeTo(655.5, __doubleTolerance));
      expect(sumShapes.paneRotation, closeTo(3.14, __doubleTolerance));
      expect(sumShapes.content, null);
    });

    test('operator -', () async {

      var contentShape = BoxContentShape(scale: 1.0, altitude: 100.0);
      var shape1 = MyBoxShape(
        color: Color(0xFFFF0000),
        altitude: 100.0,
        height: 22.0,
        width: 33.0,
        paneRotation: 0.0,
        content: null,
      );

      var shape2 = MyBoxShape(
        color: Color(0xFFFF0000),
        altitude: 555.5,
        height: 44.4,
        width: 66.6,
        paneRotation: 3.14,
        content: contentShape,
      );

      MyBoxShape substractedShape = shape1 - shape2;

      expect(substractedShape.width, closeTo(-33.6, __doubleTolerance));
      expect(substractedShape.height, closeTo(-22.4, __doubleTolerance));
      expect(substractedShape.color, Color(0x00000000));
      expect(substractedShape.altitude, closeTo(-455.5, __doubleTolerance));
      expect(substractedShape.paneRotation, closeTo(-3.14, __doubleTolerance));
      expect(substractedShape.content, contentShape);
    });

    test('operator -', () async {

      var shape1 = MyBoxShape(
        color: Color(0x22222222),
        altitude: 100.0,
        height: 22.0,
        width: 33.0,
        paneRotation: 10.0,
        content: BoxContentShape(scale: 1.0, altitude: 100.0),
      );

      MyBoxShape multShapes = shape1 *2.0;

      expect(multShapes.width, closeTo(66.0, __doubleTolerance));
      expect(multShapes.height, closeTo(44.0, __doubleTolerance));
      expect(multShapes.color, Color(0x44444444));
      expect(multShapes.altitude, closeTo(200.0, __doubleTolerance));
      expect(multShapes.paneRotation, closeTo(20.0, __doubleTolerance));
      expect(multShapes.content, BoxContentShape(scale: 2.0, altitude: 200.0));
    });
  });
}
