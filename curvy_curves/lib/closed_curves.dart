import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClosedCurves {
  static final sinus = SinusCurve();
  static final cosinus = CosinusCurve();
}


class SinusCurve extends Curve {

  @override
  double transformInternal(double t) {
    return 0.5 + math.sin(t*2*math.pi)*0.5;
  }
}

class CosinusCurve extends Curve {

  @override
  double transformInternal(double t) {
    return 0.5 + math.cos(t*2*math.pi)*0.5;
  }

}