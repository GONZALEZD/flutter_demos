import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math' as math;

import 'package:object_anim/leaf.dart';

void main() {
  test('Testing operator +', () async {
    var b1 = Leaf(
      y: 100.0,
      x: 200.0,
      rotation: 1.0,
    );
    var b2 = Leaf(
      y: 66.0,
      x: 44.0,
      rotation: 3.33,
    );

    Leaf addedBubbles = b1 + b2;

    expect(addedBubbles.y, 166.0);
    expect(addedBubbles.x, 244.0);
    expect(addedBubbles.rotation, 4.33);
  });

  test('Testing operator -', () async {
    var b1 = Leaf(
      y: 66.0,
      x: 44.0,
      rotation: 3.33,
    );
    var b2 = Leaf(
      y: 100.0,
      x: 200.0,
      rotation: 1.0,
    );

    Leaf addedBubbles = b1 - b2;

    expect(addedBubbles.y,  -34.0);
    expect(addedBubbles.x,  -156.0);
    expect(addedBubbles.rotation,  2.33);
  });

  test('Testing operator *', () async {
    var b1 = Leaf(
      y: 66.0,
      x: 44.0,
      rotation: 3.33,
    );
    var coef = 2.5;

    Leaf addedBubbles = b1 * coef;

    expect(addedBubbles.y, 165.0);
    expect(addedBubbles.x, 110.0);
    expect(addedBubbles.rotation, 8.325);
  });

  test('Testing Tween of a Bubble', () async {
    var from = Leaf(
      y: 60.0,
      x: 40.0,
      rotation: 0.0,
    );

    var to = Leaf(
      y: 100.0,
      x: 44.0,
      rotation: math.pi,
    );

    var tween = Tween(begin: from, end: to);

    expect(tween.lerp(0.5), Leaf(
      y: 80.0,
      x: 42.0,
      rotation: math.pi/2,
    ));

    expect(tween.lerp(0.25), Leaf(
      y: 70.0,
      x: 41.0,
      rotation: math.pi/4,
    ));
    expect(tween.lerp(0.75), Leaf(
      y: 90.0,
      x: 43.0,
      rotation: math.pi*0.75,
    ));

  });
}
