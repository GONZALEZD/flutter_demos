import 'package:flutter/material.dart';

class PokeballWidget extends StatelessWidget {
  final double altitude;
  final double offsetX;
  final double size;
  final double rotationAngle;
  final Color buttonColor;
  final double buttonBlurWidth;

  final _interShellColor = Colors.grey.shade700;

  PokeballWidget(
      {this.altitude,
      this.offsetX,
      this.size,
      this.rotationAngle,
      this.buttonColor,
      this.buttonBlurWidth});

  double get borderWidth => this.size / 8;

  @override
  Widget build(BuildContext context) {
    var shellWidth = this.size / 2;
    return Padding(
      padding: EdgeInsets.only(
        bottom: this.altitude,
        left: this.offsetX >= 0.0 ? this.offsetX : 0.0,
        right: this.offsetX < 0.0 ? -this.offsetX : 0.0,
      ),
      child: Transform.rotate(
        angle: this.rotationAngle,
        child: SizedBox.fromSize(
          size: Size.square(this.size),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTopShell(width: shellWidth),
                  _buildBottomShell(width: shellWidth),
                ],
              ),
              _buildShellSeparator(),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShellSeparator() {
    return Container(
      width: this.size,
      height: this.borderWidth,
      decoration: BoxDecoration(
          color: _interShellColor,
          borderRadius: BorderRadius.all(Radius.elliptical(1, this.borderWidth))),
    );
  }

  Widget buildButton() {
    var buttonSize = this.size * 0.3;
    return Container(
      constraints: BoxConstraints.tight(Size.square(buttonSize + this.borderWidth * 2)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _interShellColor,
          borderRadius: BorderRadius.circular(this.size / 2),
        ),
        child: Container(
          margin: EdgeInsets.all(this.borderWidth),
          decoration: BoxDecoration(
              color: this.buttonColor,
              borderRadius: BorderRadius.circular(this.size / 2),
              boxShadow: [
                BoxShadow(
                  color: this.buttonColor.withOpacity(0.7),
                  blurRadius: this.buttonBlurWidth,
                  spreadRadius: this.buttonBlurWidth,
                ),
              ]),
        ),
      ),
    );
  }

  Widget _buildTopShell({double width}) {
    return Container(
      height: width,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.red.shade700]),
        borderRadius: BorderRadius.vertical(top: Radius.circular(width)),
      ),
    );
  }

  Widget _buildBottomShell({double width}) {
    return Container(
      height: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white, Colors.grey.shade200]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(width)),
      ),
    );
  }
}
