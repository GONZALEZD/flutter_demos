import 'package:box_anim/lerping_object.dart';
import 'package:flutter/material.dart' show Color, Size;

class MyBoxShape with LerpingObject {
  final double width;
  final double height;
  final double paneRotation;
  final double altitude;
  final BoxContentShape content;
  final LerpingColor _color;

  Size get size => Size(width, height);

  MyBoxShape({this.width, this.height, this.paneRotation, this.altitude, this.content, Color color})
      : _color = LerpingColor.color(color);

  MyBoxShape._({this.width, this.height, this.paneRotation, this.altitude, this.content, LerpingColor color})
      : _color = color;

  @override
  String toString() {
    return "$MyBoxShape(${getAttributes()})";
  }

  Color get color => _color.color;

  @override
  Map getAttributes() {
    return {
      "width": width,
      "height": height,
      "paneRotation": paneRotation,
      "altitude": altitude,
      "content": content,
      "color": _color,
    };
  }

  @override
  MyBoxShape instanceWithAttributes(Map from) {
    return MyBoxShape._(
      width: from["width"],
      height: from["height"],
      paneRotation: from["paneRotation"],
      altitude: from["altitude"],
      content: from["content"],
      color: from["color"],
    );
  }

  MyBoxShape copyWith({double width, double height, double paneRotation, double altitude, BoxContentShape content, Color color}) {
    return MyBoxShape(
      width: width ?? this.width,
      height: height ?? this.height,
      paneRotation: paneRotation ?? this.paneRotation,
      altitude: altitude ?? this.altitude,
      content: content ?? this.content,
      color: color ?? this.color,
    );
  }
}

class BoxContentShape with LerpingObject {
  final double scale;
  final double altitude;

  BoxContentShape({this.scale, this.altitude});

  @override
  String toString() {
    return "$BoxContentShape(${getAttributes()})";
  }

  @override
  Map getAttributes() {
    return {
      "scale": scale,
      "altitude": altitude,
    };
  }

  @override
  BoxContentShape instanceWithAttributes(Map from) {
    return BoxContentShape(
      scale: from["scale"],
      altitude: from["altitude"],
    );
  }

  @override
  bool operator ==(Object other) {
    if(other == null || this == null) {
      return false;
    }
    else if(other is BoxContentShape) {
      return this.altitude == other.altitude && this.scale == other.scale;
    }
    return false;
  }
}