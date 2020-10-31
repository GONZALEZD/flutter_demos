import 'package:flutter/material.dart' show Offset;

class Leaf {
  final double x;
  final double y;
  final double rotation;

  Leaf({this.x, this.y, this.rotation});

  Offset get pos => Offset(x, y);

  operator -(Leaf otherBubble) {
    return this._process((d1, d2) => d1 - d2, other: otherBubble);
  }

  operator +(Leaf otherBubble) {
    return this._process((d1, d2) => d1 + d2, other: otherBubble);
  }

  operator *(num number) {
    double factor = number.toDouble();
    return Leaf(
      x: this.x * factor,
      y: this.y * factor,
      rotation: this.rotation * factor,
    );
  }

  Leaf _process(double Function(double d1, double d2) operation, {Leaf other}) {
    return Leaf(
      x: operation(this.x, other.x),
      y: operation(this.y, other.y),
      rotation: operation(this.rotation, other.rotation),
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is Leaf && other != null) {
      return this.x == other.x &&
          this.y == other.y &&
          this.rotation == other.rotation;
    }
    return this == other;
  }

  @override
  String toString() {
    var attributes = {
      "x": x,
      "y": y,
      "rotation": rotation,
    };
    return "$Leaf($attributes)";
  }
}
