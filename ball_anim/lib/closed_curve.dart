import 'dart:math' as math;

import 'package:flutter/animation.dart';


class LoopingTween extends CurveTween {
  // peak amplitude
  final double peakAmplitude;
  final double periods;

  LoopingTween({this.peakAmplitude = 1.0, this.periods = 1, ClosedCurve curve})
      : assert(peakAmplitude != null),
        assert(peakAmplitude != 0.0),
        assert(periods != null),
        assert(periods > 0),
        super(curve: curve);

  @override
  double transform(double t) {
    if (t == 0.0 || t == 1.0) {
      assert(curve.transform(t).round() == 0.0);
      return 0.0;
    }
    return this.peakAmplitude * curve.transform((t * this.periods) % 1.0);
  }
}

//Curves where value for t0 and tfinal are equal to 0.0
class ClosedCurves {

  ClosedCurves._();

  static const cosinus = CosinusCurve();

  static const pipe = PipeCurve();
}

class PipeCurve extends ClosedCurve {
  const PipeCurve(): super();

  @override
  double transformInternal(double t) {
    return math.pow(2*t - 1, 2);
  }
}

class CosinusCurve extends ClosedCurve {
  const CosinusCurve() : super();

  @override
  double transformInternal(double t) {
    return math.cos(t * 2 * math.pi);
  }
}

abstract class ClosedCurve extends Curve {
  const ClosedCurve();

  @override
  double transform(double t) {
    if (t == 0.0 || t == 1.0) {
      return 0.0;
    }
    return super.transform(t);
  }
}