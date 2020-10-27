import 'dart:math' as math;

import 'package:flutter/animation.dart';


class ClosedCurveTween extends CurveTween {

  final double amplitude;

  ClosedCurveTween({ClosedCurve curve, this.amplitude = 1.0}): super(curve: curve);

  @override
  double transform(double t) {
    if (t == 0.0 || t == 1.0) {
      return 0.0;
    }
    return this.amplitude*curve.transform(t);
  }
}

class ShakeCurve extends ClosedCurve {

  final int occurences;

  const ShakeCurve({this.occurences}): super();

  @override
  double transform(double t) {
    if (t == 0.0 || t == 1.0) {
      return 0.0;
    }
    return super.transform(t);
  }

  @override
  double transformInternal(double t) {
    return math.sin(this.occurences*t*2*math.pi);
  }
}


abstract class ClosedCurve extends Curve {

  const ClosedCurve():super();

  @override
  double transform(double t) {
    if(t == 0.0 || t == 1.0) {
      return 0.0;
    }
    return super.transform(t);
  }
}