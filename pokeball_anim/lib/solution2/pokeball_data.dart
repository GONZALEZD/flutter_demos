import 'package:flutter/painting.dart' show Color;

class PokeballData {
  final double size;
  final double altitude;
  final double offsetX;
  final double rotation;
  final Color buttonColor;
  final double buttonBlurWidth;

  PokeballData({this.size,
    this.altitude,
    this.rotation,
    this.buttonColor,
    this.buttonBlurWidth,
    this.offsetX})
      : assert(size != null && size > 0.0),
        assert(altitude != null),
        assert(rotation != null),
        assert(offsetX != null),
        assert(buttonBlurWidth != null && buttonBlurWidth >= 0.0),
        assert(buttonColor != null);

  @override
  String toString() {
    var attributes = {
      "size": size,
      "offsetX": offsetX,
      "altitude": altitude,
      "rotation": rotation,
      "buttonColor": buttonColor,
      "buttonBlurWidth": buttonBlurWidth,
    };
    return "$runtimeType($attributes)";
  }

  PokeballData copyWith({double size,
    double altitude,
    double offsetX,
    double rotation,
    Color buttonColor,
    double buttonBlurWidth}) {
    return PokeballData(
      size: size ?? this.size,
      altitude: altitude ?? this.altitude,
      offsetX: offsetX ?? this.offsetX,
      rotation: rotation ?? this.rotation,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonBlurWidth: buttonBlurWidth ?? this.buttonBlurWidth,
    );
  }

  static PokeballData lerp(PokeballData a, PokeballData b, double t) {
    if (t == 0.0) {
      return a;
    }
    else if (t == 1.0) {
      return b;
    }

    var lerpDouble = (a, b, t) => a + (b - a) * t;

    return PokeballData(
      size: lerpDouble(a.size, b.size, t),
      rotation: lerpDouble(a.rotation, b.rotation, t),
      altitude: lerpDouble(a.altitude, b.altitude, t),
      offsetX: lerpDouble(a.offsetX, b.offsetX, t),
      buttonBlurWidth: lerpDouble(a.buttonBlurWidth, b.buttonBlurWidth, t),
      buttonColor: Color.lerp(a.buttonColor, b.buttonColor, t),
    );
  }
}