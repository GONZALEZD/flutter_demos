import 'dart:math' as math;

import 'package:box_anim/box_shape.dart';
import 'package:box_anim/box_widget.dart';
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
  Animation<MyBoxShape> _boxAnimation;

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
    var firstKeyFrame = MyBoxShape(
      altitude: this.widget.fallHeight,
      paneRotation: 0.03,
      width: 105.0,
      height: 55.0,
      color: Colors.amber,
      content: BoxContentShape(scale: 0.0, altitude: 0.0),
    );
    var secondKeyFrame = firstKeyFrame.copyWith(
      color: Colors.amber,
      altitude: 0.0,
      width: 100.0,
      height: 60.0,
    );
    var secondShrinkKeyFrame = secondKeyFrame.copyWith(
      color: Colors.amber.shade400,
      width: 110.0,
      height: 50.0,
    );
    var thirdKeyFrame = secondKeyFrame.copyWith(
      paneRotation: math.pi * 1.15,
      content: BoxContentShape(altitude: 0.0, scale: 0.25),
    );
    var fourthKeyFrame = thirdKeyFrame.copyWith(
      content: BoxContentShape(altitude: this.widget.fallHeight / 2, scale: 1.0),
    );
    _boxAnimation = TweenSequence([
      TweenSequenceItem(
          weight: 0.4,
          tween: Tween(begin: firstKeyFrame, end: secondKeyFrame)
              .chain(CurveTween(curve: Curves.bounceOut))),
      // Bouncing box
      TweenSequenceItem(
        weight: 0.25,
        tween: TweenSequence(
          List.generate(4, (index) => [
            TweenSequenceItem(
                tween: Tween(begin: secondKeyFrame, end: secondShrinkKeyFrame), weight: 1.0),
            TweenSequenceItem(
                tween: Tween(begin: secondShrinkKeyFrame, end: secondKeyFrame), weight: 1.0),
          ]).toList().reduce((l1, l2) => l1 + l2)
        )
      ),
      TweenSequenceItem(
          weight: 0.15,
          tween: Tween(begin: secondKeyFrame, end: thirdKeyFrame)
              .chain(CurveTween(curve: Curves.easeOutBack))),
      TweenSequenceItem(
          weight: 0.25,
          tween: Tween(begin: thirdKeyFrame, end: fourthKeyFrame)
              .chain(CurveTween(curve: Curves.easeOutBack))),
    ]).animate(_animationController);

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
      animation: _boxAnimation,
      builder: (context, child) {
        if (_boxAnimation.value.content == null || _boxAnimation.value.content.scale == 0.0) {
          return SizedBox();
        }
        var scale = _boxAnimation.value.content.scale;
        var contentAltitude = _boxAnimation.value.content.altitude;
        return Padding(
          padding: EdgeInsets.only(bottom: contentAltitude),
          child: Transform(
            alignment: Alignment.bottomCenter,
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
          animation: _boxAnimation,
          builder: (context, child) {
            return Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: _boxAnimation.value.altitude),
              child: MyBox(
                shape: _boxAnimation.value,
              ),
            );
          },
        ),
      ),
    );
  }
}
