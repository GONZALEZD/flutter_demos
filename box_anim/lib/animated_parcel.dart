import 'package:box_anim/opened_parcel.dart';
import 'package:box_anim/segment_tween.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  Animation _contentJumpRatio;

  @override
  void initState() {
    super.initState();
    _resetAnimations();
  }

  void _resetAnimations() {
    if (_animationController != null) {
      _animationController.dispose();
    }
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    _boxFall = Tween(begin: 0.0, end: this.widget.fallHeight)
        .chain(CurveTween(curve: Interval(0.0, 0.45, curve: FallReboundsCurve())))
        .animate(_animationController);
    _boxOpen = Tween(begin: 0.03, end: math.pi * 1.25)
        .chain(CurveTween(curve: Interval(0.45, 0.7, curve: Curves.easeOutBack)))
        .animate(_animationController);
    _contentJumpRatio = CurveTween(curve: Interval(0.6, 1.0, curve: Curves.easeOutBack))
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
      animation: _contentJumpRatio,
      builder: (context, child) {
        if (_contentJumpRatio.value == 0.0) {
          return SizedBox();
        }
        var scale = _contentJumpRatio.value;
        var contentAltitude = _contentJumpRatio.value * this.widget.fallHeight / 2;
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
            return Padding(
              padding: EdgeInsets.only(top: _boxFall.value),
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