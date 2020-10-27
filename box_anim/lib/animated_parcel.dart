import 'dart:math' as math;

import 'package:box_anim/opened_parcel.dart';
import 'package:box_anim/segment_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnimatedParcel extends StatefulWidget {
  final Widget content;
  final Size boxSize;
  final double fallHeight;

  AnimatedParcel({this.content, this.boxSize, this.fallHeight});

  @override
  _AnimatedParcelState createState() => _AnimatedParcelState();
}

class _AnimatedParcelState extends State<AnimatedParcel> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _boxFall;
  Animation _boxOpen;
  Animation _contentJump;

  @override
  void initState() {
    super.initState();
    _resetAnimations();
  }

  @override
  void didUpdateWidget(covariant AnimatedParcel oldWidget) {
    super.didUpdateWidget(oldWidget);
    this._resetAnimations();
  }

  void _resetAnimations() {
    _animationController?.dispose();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _boxFall = Tween(begin: 0.0, end: this.widget.fallHeight)
        .chain(CurveTween(curve: Interval(0.0, 0.4, curve: Curves.bounceOut)))
        .animate(_animationController);
    _boxOpen = Tween(begin: 0.03, end: math.pi * 1.15)
        .chain(CurveTween(curve: Interval(0.58, 0.75, curve: Curves.easeOutBack)))
        .animate(_animationController);
    _contentJump = CurveTween(curve: Interval(0.60, 1.0, curve: Curves.easeOutBack))
        .animate(_animationController);

    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildParcelContent(),
        _buildParcel(),
      ],
    );
  }

  Widget _buildParcelContent() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        if (_contentJump.value == 0.0) {
          return SizedBox();
        }
        var scale = _contentJump.value;
        var contentAltitude = _contentJump.value * this.widget.fallHeight / 2;
        return Padding(
          padding: EdgeInsets.only(bottom: contentAltitude),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity().scaled(scale, scale),
            child: child,
          ),
        );
      },
      child: this.widget.content,
    );
  }

  Widget _buildParcel() {
    return SizedBox(
      height: this.widget.fallHeight + this.widget.boxSize.height,
      child: GestureDetector(
        onTap: () => _animationController.forward(from: 0.0),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform(
              origin: Offset(0.0, this.widget.boxSize.height/2),
              alignment: Alignment.topCenter,
              transform: Matrix4.translationValues(0.0, _boxFall.value, 0.0),
              child: OpenedParcel(
                color: Colors.amber,
                size: this.widget.boxSize,
                openedRadian: _boxOpen.value,
              ),
            );
          },
        ),
      ),
    );
  }
}
