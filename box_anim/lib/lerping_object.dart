import 'package:flutter/material.dart' show Color, factory;

class LerpingColor with LerpingObject {
  double a, r, g, b;

  LerpingColor({this.a, this.r, this.b, this.g});

  factory LerpingColor.color(Color color) {
    return LerpingColor(
      a: color.alpha.toDouble(),
      r: color.red.toDouble(),
      g: color.green.toDouble(),
      b: color.blue.toDouble(),
    );
  }

  Color get color => Color.fromARGB(a.toInt(), r.toInt(), g.toInt(), b.toInt());

  @override
  Map getAttributes() {
    return {
      "a": this.a,
      "r": this.r,
      "g": this.g,
      "b": this.b,
    };
  }

  @override
  LerpingColor instanceWithAttributes(Map from) {
    return LerpingColor(a: from["a"], r: from["r"], g: from["g"], b: from["b"]);
  }

  @override
  String toString() {
    return this.color.toString();
  }
}

mixin LerpingObject {
  Map getAttributes();

  @factory
  LerpingObject instanceWithAttributes(Map from);

  operator +(LerpingObject other) {
    return _process((a, b) => a + b, other.getAttributes());
  }

  operator -(LerpingObject other) {
    return _process((a, b) => a - b, other.getAttributes());
  }

  operator *(double factor) {
    var other = Map.fromEntries(getAttributes().keys.map((key) => MapEntry(key, factor)));
    return _process((a, b) => a * b, other);
  }

  LerpingObject _process<T>(T Function(T a, T b) process, Map other) {
    var newAttributes = this.getAttributes().map((key, value) {
      if (value == null || other[key] == null) {
        return MapEntry(key, other[key]);
      }
      return MapEntry(key, process(value, other[key]));
    });
    return instanceWithAttributes(newAttributes);
  }
}