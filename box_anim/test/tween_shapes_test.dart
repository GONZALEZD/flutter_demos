// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:box_anim/lerping_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



const double __doubleTolerance = 0.000001;


void main() {

  test('Testing Color lerping in Tween', () async {

    var colorsList = Colors.primaries.map((e) => e.shade500).toList();
    colorsList.addAll(Colors.accents.map((element) => element.shade200));

    colorsList.forEach((c1) {
      colorsList.forEach((c2) {
        var tween = Tween(begin: LerpingColor.color(c1), end: LerpingColor.color(c2));

        var transformations = [0.0, 0.25, 0.5, 0.75, 1.0];
        transformations.forEach((t) {
          expect(tween.transform(t).color, Color.lerp(c1, c2, t));
        });
      });
    });
  });
}
