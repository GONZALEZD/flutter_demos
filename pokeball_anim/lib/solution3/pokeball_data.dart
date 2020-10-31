import 'package:collection/collection.dart';
import 'package:flutter/painting.dart' show Color;
import 'package:pokeball_anim/solution3/framework/interpolatable_object.dart';

class PokeballData extends DelegatingMap<String, dynamic> with InterpolatableObject {
  PokeballData(
      {double size,
      double altitude,
      double offsetX,
      double rotation,
      Color buttonColor,
      double buttonBlurWidth})
      : assert(size != null && size > 0.0),
        assert(altitude != null),
        assert(rotation != null),
        assert(offsetX != null),
        assert(buttonBlurWidth != null && buttonBlurWidth >= 0.0),
        assert(buttonColor != null),
        super({
          "size": size,
          "altitude": altitude,
          "offsetX": offsetX,
          "rotation": rotation,
          "color": InterpolatableColor.color(buttonColor),
          "buttonBlurWidth": buttonBlurWidth,
        });

  PokeballData._({Map<String, dynamic> map}):super(map);

  double get size => this["size"];
  double get altitude => this["altitude"];
  double get offsetX => this["offsetX"];
  double get rotation => this["rotation"];
  Color get buttonColor => this["color"].color;
  double get buttonBlurWidth => this["buttonBlurWidth"];

  @override
  Map<String, dynamic> getAttributes() => this;

  @override
  InterpolatableObject instanceWithAttributes(Map<String, dynamic> from) => PokeballData._(map: from);

  PokeballData copyWith(
  {double size,
      double altitude,
      double offsetX,
      double rotation,
      Color buttonColor,
      double buttonBlurWidth}) {
    return PokeballData(
      size: size ?? this.size,
      offsetX: offsetX ?? this.offsetX,
      altitude: altitude ?? this.altitude,
      rotation: rotation ?? this.rotation,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonBlurWidth: buttonBlurWidth ?? this.buttonBlurWidth,
    );
  }
}