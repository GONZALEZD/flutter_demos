import 'package:flutter/material.dart' show Color, factory, protected;

abstract class InterpolatableObject with InterpolatableObjectMixin {
  final Map<String, dynamic> _data;

  InterpolatableObject({Map<String, dynamic> data}) : _data = data;

  @override
  Map<String, dynamic> getAttributes() => _data;

  @protected
  dynamic get(String key) => _data.containsKey(key)
      ? _data[key]
      : throw "Unknown key '$key' for interpolatable object '$runtimeType'";
}

class InterpolatableColor with InterpolatableObjectMixin {
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

mixin InterpolatableObjectMixin {
  Map<String, dynamic> getAttributes();

  @factory
  InterpolatableObjectMixin instanceWithAttributes(Map<String, dynamic> from);

  operator +(InterpolatableObjectMixin other) {
    return _process((a, b) => a + b, other.getAttributes());
  }

  operator -(InterpolatableObjectMixin other) {
    return _process((a, b) => a - b, other.getAttributes());
  }

  operator *(double factor) {
    var other = Map.fromEntries(getAttributes().keys.map((key) => MapEntry(key, factor)));
    return _process((a, b) => a * b, other);
  }

  InterpolatableObjectMixin _process<T>(T Function(T a, T b) process, Map other) {
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
