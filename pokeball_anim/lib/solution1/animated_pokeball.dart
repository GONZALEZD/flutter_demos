import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pokeball_anim/animated_player.dart';
import 'package:pokeball_anim/pokeball_widget.dart';

class AnimatedPokeball extends StatefulWidget {
  @override
  AnimatedPokeballState createState() => AnimatedPokeballState();
}

class AnimatedPokeballState extends AnimatedPlayerState {
  Animation _altitude;
  Animation _rotation;
  Animation _size;
  Animation _offsetX;
  Animation _buttonColor;
  Animation _buttonBlurWidth;

  AnimatedPokeballState() : super(resetAnimationsOnUpdate: true);

  final double __jumpWeight = 4.5;
  final double __shakeWeight = 13.0;

  Interval get _jumbInterval => Interval(0.0, __jumpWeight / (__jumpWeight + __shakeWeight));

  Interval get _shakeInterval => Interval(__jumpWeight / (__jumpWeight + __shakeWeight), 1.0);

  @override
  AnimatedBuilder buildAnimatedPokeball(BuildContext context) {
    return AnimatedBuilder(
        animation: this.animationController,
        builder: (context, child) {
          return PokeballWidget(
            size: _size.value,
            offsetX: _offsetX.value,
            rotationAngle: _rotation.value,
            altitude: _altitude.value,
            buttonColor: _buttonColor.value,
            buttonBlurWidth: _buttonBlurWidth.value,
          );
        });
  }

  @override
  void createAnimations() {
    _createAltitudeAnimation();
    _createSizeAnimation();
    _createRotationAnimation();
    _createOffsetXAnimation();
    _createButtonColorAnimation();
    _createButtonBlurAnimation();
  }

  void _createSizeAnimation() {
    _size = __createJumpSequence(40.0, 60.0, 120.0)
        .chain(CurveTween(curve: _jumbInterval))
        .animate(this.animationController);
  }

  void _createRotationAnimation() {
    _rotation = TweenSequence([
      TweenSequenceItem(
        weight: __jumpWeight,
        tween: __createJumpSequence(-math.pi * 6, -math.pi * 2, 0.0),
      ),
      TweenSequenceItem(
        weight: __shakeWeight,
        tween: __createShakeSequence(0.0, math.pi / 4, 0.0),
      ),
    ]).animate(this.animationController);
  }

  void _createOffsetXAnimation() {
    _offsetX = __createShakeSequence(0.0, math.pi / 4 * 120.0, 0.0)
        .chain(CurveTween(curve: _shakeInterval))
        .animate(this.animationController);
  }

  void _createButtonColorAnimation() {
    _buttonColor = TweenSequence([
      TweenSequenceItem(
        weight: __jumpWeight,
        tween: ColorTween(begin: Colors.white, end: Colors.white),
      ),
      TweenSequenceItem(
        weight: __shakeWeight,
        tween: __createShakeSequence(
          Colors.red.shade100,
          Colors.redAccent,
          Colors.white,
        ),
      ),
    ]).animate(this.animationController);
  }

  void _createButtonBlurAnimation() {
    _buttonBlurWidth = __createShakeSequence(0.0, 4.0, 0.0)
        .chain(CurveTween(curve: _shakeInterval))
        .animate(this.animationController);
  }

  void _createAltitudeAnimation() {
    _altitude = __createJumpSequence(0.0, 400.0, 0.0)
        .chain(CurveTween(curve: _jumbInterval))
        .animate(this.animationController);
  }

  TweenSequence __createJumpSequence(double begin, double highestPoint, double end) {
    return TweenSequence([
      TweenSequenceItem(
        weight: 1,
        tween: Tween(begin: begin, end: highestPoint).chain(CurveTween(curve: Curves.easeOut)),
      ),
      TweenSequenceItem(
        weight: 2,
        tween: Tween(begin: highestPoint, end: end).chain(CurveTween(curve: Curves.bounceOut)),
      ),
    ]);
  }

  Animatable __createShakeSequence<T>(T begin, T intermediate, T end) {
    var createTween;
    if (begin is Color) {
      createTween = (begin, end) => ColorTween(begin: begin, end: end);
    } else {
      createTween = (begin, end) => Tween(begin: begin, end: end);
    }
    return TweenSequence([
      ...List.generate(3, (index) {
        return [
          TweenSequenceItem(
              weight: 1.0,
              tween: createTween(begin, intermediate).chain(CurveTween(curve: Curves.decelerate))),
          TweenSequenceItem(
              weight: 1.0,
              tween: createTween(intermediate, begin).chain(CurveTween(curve: Curves.easeOutQuad))),
          TweenSequenceItem(weight: 1.0, tween: createTween(begin, begin)),
        ];
      }).reduce((list1, list2) => list1 + list2),
      TweenSequenceItem(weight: 1.0, tween: createTween(begin, end)),
    ]);
  }
}