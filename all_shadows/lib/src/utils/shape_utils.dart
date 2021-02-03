import 'package:flutter/material.dart';

class ShapeUtils {
  
  static /// Coming from https://stackoverflow.com/questions/7007429/how-to-draw-a-triangle-a-star-a-square-or-a-heart-on-the-canvas
  Path createStar(Size size) {

    final min = size.shortestSide;
    final half = min / 2;
    final mid = size.width/2.0 - half;

    final path = Path();
    path.moveTo(mid + half * 0.5, half * 0.84);
    // top right
    path.lineTo(mid + half * 1.5, half * 0.84);
    // bottom left
    path.lineTo(mid + half * 0.68, half * 1.45);
    // top tip
    path.lineTo(mid + half * 1.0, half * 0.5);
    // bottom right
    path.lineTo(mid + half * 1.32, half * 1.45);
    // top left
    path.lineTo(mid + half * 0.5, half * 0.84);

    path.close();
    return path;
  }
}