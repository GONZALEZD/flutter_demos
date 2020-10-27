import 'dart:math' as math;

import 'package:flutter/animation.dart';

class FallReboundsCurve extends Curve {

  const FallReboundsCurve() : super();

  @override
  double transform(double t) {
    return 1.0 - super.transform(t);
  }

  @override
  double transformInternal(double t) {
    return (2/(math.sqrt(1+3*t))- 1)*math.cos(3*math.pi*math.pow(t, t+1)).abs();
  }
}