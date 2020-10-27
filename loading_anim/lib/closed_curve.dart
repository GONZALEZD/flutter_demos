import 'dart:math' as math;

import 'package:flutter/animation.dart';


class ClosedCurveTween extends CurveTween {

  ClosedCurveTween({ClosedCurve curve}):super(curve: curve);

  @override
  double transform(double t) {
    if(t == 0.0 || t == 1.0) {
      assert(curve.transform(t).round() == 0.0);
      return 0.0;
    }
    return super.transform(t);
  }
}

class ParabolCurve extends ClosedCurve {

  @override
  double transform(double t) => math.sin(math.pi*t);
}

class ClosedCurve extends Curve {
  @override
  double transformInternal(double t) {
    if(t == 0.0 || t == 1.0) {
      return 0.0;
    }
    return super.transform(t);
  }
}