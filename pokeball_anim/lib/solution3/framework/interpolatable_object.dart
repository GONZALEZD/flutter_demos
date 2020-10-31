import 'package:flutter/material.dart' show Color, factory;

class InterpolatableColor with InterpolatableObject {
  double a, r, g, b;

  InterpolatableColor({this.a, this.r, this.b, this.g});

  factory InterpolatableColor.color(Color color) {
    return InterpolatableColor(
      a: color.alpha.toDouble(),
      r: color.red.toDouble(),
      g: color.green.toDouble(),
      b: color.blue.toDouble(),
    );
  }

  Color get color => Color.fromARGB(a.toInt(), r.toInt(), g.toInt(), b.toInt());

  @override
  Map<String, dynamic> getAttributes() => {"a": this.a, "r": this.r, "g": this.g, "b": this.b};

  @override
  InterpolatableColor instanceWithAttributes(Map<String, dynamic> from) {
    return InterpolatableColor(a: from["a"], r: from["r"], g: from["g"], b: from["b"]);
  }

  @override
  String toString() => this.color.toString();
}

mixin InterpolatableObject {
  Map<String, dynamic> getAttributes();

  @factory
  InterpolatableObject instanceWithAttributes(Map<String, dynamic> from);

  operator +(InterpolatableObject other) {
    return _process((a, b) => a + b, other.getAttributes());
  }

  operator -(InterpolatableObject other) {
    return _process((a, b) => a - b, other.getAttributes());
  }

  operator *(double factor) {
    var other = Map.fromEntries(getAttributes().keys.map((key) => MapEntry(key, factor)));
    return _process((a, b) => a * b, other);
  }

  InterpolatableObject _process<T>(T Function(T a, T b) process, Map other) {
    var newAttributes = this.getAttributes().map((key, value) {
      if (value == null || other[key] == null) {
        return MapEntry(key, other[key]);
      }
      return MapEntry(key, process(value, other[key]));
    });
    return instanceWithAttributes(newAttributes);
  }

  @override
  String toString() => "${this.runtimeType}(${getAttributes()})";
}
