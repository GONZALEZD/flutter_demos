import 'package:flutter/animation.dart';
import 'package:curvy_curves/closed_curves.dart';

class NamedCurves {
  static final all  = _getCurves();
  static final names = _getCurves().keys.toList();

  static Map<String, Curve> _getCurves() {
    return {
      "linear": Curves.linear,
      "decelerate": Curves.decelerate,
      "fastLinearToSlowEaseIn": Curves.fastLinearToSlowEaseIn,
      "ease": Curves.ease,
      "easeIn": Curves.easeIn,
      "easeInToLinear": Curves.easeInToLinear,
      "easeInSine": Curves.easeInSine,
      "easeInQuad": Curves.easeInQuad,
      "easeInCubic": Curves.easeInCubic,
      "easeInQuart": Curves.easeInQuart,
      "easeInQuint": Curves.easeInQuint,
      "easeInExpo": Curves.easeInExpo,
      "easeInCirc": Curves.easeInCirc,
      "easeInBack": Curves.easeInBack,
      "easeOut": Curves.easeOut,
      "linearToEaseOut": Curves.linearToEaseOut,
      "easeOutSine": Curves.easeOutSine,
      "easeOutQuad": Curves.easeOutQuad,
      "easeOutCubic": Curves.easeOutCubic,
      "easeOutQuart": Curves.easeOutQuart,
      "easeOutQuint": Curves.easeOutQuint,
      "easeOutExpo": Curves.easeOutExpo,
      "easeOutCirc": Curves.easeOutCirc,
      "easeOutBack": Curves.easeOutBack,
      "easeInOut": Curves.easeInOut,
      "easeInOutSine": Curves.easeInOutSine,
      "easeInOutQuad": Curves.easeInOutQuad,
      "easeInOutCubic": Curves.easeInOutCubic,
      "easeInOutQuart": Curves.easeInOutQuart,
      "easeInOutQuint": Curves.easeInOutQuint,
      "easeInOutExpo": Curves.easeInOutExpo,
      "easeInOutCirc": Curves.easeInOutCirc,
      "easeInOutBack": Curves.easeInOutBack,
      "fastOutSlowIn": Curves.fastOutSlowIn,
      "bounceIn": Curves.bounceIn,
      "bounceOut": Curves.bounceOut,
      "bounceInOut": Curves.bounceInOut,
      "elasticIn": Curves.elasticIn,
      "elasticOut": Curves.elasticOut,
      "elasticInOut": Curves.elasticInOut,
      "Interval(0.0, 0.5)": Interval(0.0, 0.5),
      "Interval(0.5, 1.0)": Interval(0.5, 1.0),
      "Interval(0.25, 0.75)": Interval(0.25, 0.75),
      "SawTooth(3)": SawTooth(3),
      "Threshold(0.66)": Threshold(0.66),
      "Sinus": ClosedCurves.sinus,
      "Cosinus": ClosedCurves.cosinus,
    };
  }
}