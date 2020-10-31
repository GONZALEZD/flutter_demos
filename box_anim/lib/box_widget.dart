import 'package:flutter/material.dart';
import 'package:box_anim/box_shape.dart';

class MyBox extends StatelessWidget {
  final MyBoxShape shape;

  static const __paneThickness = 3.0;

  MyBox({this.shape});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildPane(Alignment.bottomLeft),
              buildPane(Alignment.bottomRight),
            ],
          ),
        ),
        buildBox(),
      ],
    );
  }

  Widget buildBox() {
    return Container(
      constraints: BoxConstraints.tight(this.shape.size + Offset(0.0, -__paneThickness)),
      decoration: BoxDecoration(
        color: this.shape.color,
        borderRadius: const BorderRadius.vertical(bottom: const Radius.circular(4.0)),
      ),
    );
  }

  Widget buildPane(Alignment alignment) {
    return Transform.rotate(
      angle: this.shape.paneRotation * alignment.x,
      alignment: alignment,
      child: Container(
        width: this.shape.size.width / 2,
        height: __paneThickness,
        decoration: BoxDecoration(
          color: this.shape.color,
          borderRadius: const BorderRadius.all(Radius.circular(__paneThickness)),
        ),
      ),
    );
  }
}
