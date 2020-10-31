import 'package:flutter/animation.dart';
import 'package:pokeball_anim/solution3/framework/interpolatable_object.dart';

class KeyFrame<T extends InterpolatableObject> {
  final double weight;
  final T begin;
  final T end;
  final Curve curve;

  KeyFrame({this.weight = 1.0, this.begin, this.end, this.curve = Curves.linear});
}

class AnimatableObject<T extends InterpolatableObject> extends TweenSequence<T> {

  AnimatableObject._(List<TweenSequenceItem<T>> items): super(items);

  factory AnimatableObject(List<KeyFrame<T>> keyFrames) {
    var sequenceItems = keyFrames.map((frame) {
      return TweenSequenceItem(
        weight: frame.weight,
        tween: Tween<T>(begin: frame.begin, end: frame.end).chain(CurveTween(curve: frame.curve)),
      );
    }).toList();
    return AnimatableObject._(sequenceItems);
  }
}