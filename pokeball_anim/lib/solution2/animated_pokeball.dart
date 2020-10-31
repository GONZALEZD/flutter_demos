import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pokeball_anim/animated_player.dart';
import 'package:pokeball_anim/pokeball_widget.dart';
import 'package:pokeball_anim/solution2/pokeball_data.dart';
import 'package:pokeball_anim/solution2/pokeball_tween.dart';

class _KeyFrame {
  final double weight;
  final PokeballData begin;
  final PokeballData end;
  final Curve curve;

  _KeyFrame({this.weight = 1.0, this.begin, this.end, this.curve = Curves.linear});
}

class AnimatedPokeball extends StatefulWidget {
  @override
  _AnimatedPokeballState createState() => _AnimatedPokeballState();
}

class _AnimatedPokeballState extends AnimatedPlayerState {
  Animation<PokeballData> _animation;

  _AnimatedPokeballState() : super(resetAnimationsOnUpdate: true);

  @override
  AnimatedBuilder buildAnimatedPokeball(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return PokeballWidget(
            size: _animation.value.size,
            offsetX: _animation.value.offsetX,
            altitude: _animation.value.altitude,
            rotationAngle: _animation.value.rotation,
            buttonColor: _animation.value.buttonColor,
            buttonBlurWidth: _animation.value.buttonBlurWidth,
          );
        });
  }

  @override
  void createAnimations() {
    var animData = _createKeyFrames();
    _animation = TweenSequence(animData.map((frame) {
      return TweenSequenceItem(
        weight: frame.weight,
        tween:
            PokeballTween(begin: frame.begin, end: frame.end).chain(CurveTween(curve: frame.curve)),
      );
    }).toList())
        .animate(this.animationController);
  }

  List<_KeyFrame> _createKeyFrames() {
    var keyPoint1 = PokeballData(
        size: 40.0,
        altitude: 0.0,
        offsetX: 0.0,
        rotation: - math.pi * 6,
        buttonColor: Colors.white,
        buttonBlurWidth: 0.0);
    var keyPoint2 = keyPoint1.copyWith(altitude: 400.0, size: 60.0, rotation: -math.pi * 2);
    var keyPoint3 = keyPoint2.copyWith(altitude: 0.0, size: 120.0, rotation: 0.0);
    var keyPoint4 = keyPoint3.copyWith(
        rotation: math.pi * 0.25,
        buttonColor: Colors.redAccent,
        buttonBlurWidth: 4.0,
        offsetX: math.pi * 0.25 * 120.0);
    var keyPoint4Bis = keyPoint3.copyWith(buttonColor: Colors.red.shade100, buttonBlurWidth: 0.0);

    return [
      _KeyFrame(weight: 1.5, begin: keyPoint1, end: keyPoint2, curve: Curves.easeOut),
      _KeyFrame(weight: 3, begin: keyPoint2, end: keyPoint3, curve: Curves.bounceOut),
      ...List.generate(3, (_) {
        return [
          _KeyFrame(begin: keyPoint4Bis, end: keyPoint4, curve: Curves.decelerate),
          _KeyFrame(begin: keyPoint4, end: keyPoint4Bis, curve: Curves.easeOutQuad),
          _KeyFrame(begin: keyPoint4Bis, end: keyPoint4Bis),
        ];
      }).reduce((list1, list2) => list1 + list2),
      _KeyFrame(begin: keyPoint4Bis, end: keyPoint3, curve: Curves.easeOutCubic),
    ];
  }
}
