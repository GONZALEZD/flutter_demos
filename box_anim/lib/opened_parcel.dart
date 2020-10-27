import 'package:flutter/material.dart';

class OpenedParcel extends StatelessWidget {
  final double openedRadian;
  final Size size;
  final Color color;

  static const __paneThickness = 3.0;

  OpenedParcel({this.openedRadian, this.size, this.color});

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
      constraints: BoxConstraints.tight(this.size + Offset(0.0, -__paneThickness)),
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: const BorderRadius.vertical(bottom: const Radius.circular(4.0)),
      ),
    );
  }

  Widget buildPane(Alignment alignment) {
    return Transform.rotate(
      angle: this.openedRadian * alignment.x,
      alignment: alignment,
      child: Container(
        width: this.size.width / 2,
        height: __paneThickness,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: const BorderRadius.all(Radius.circular(__paneThickness)),
        ),
      ),
    );
  }
}
