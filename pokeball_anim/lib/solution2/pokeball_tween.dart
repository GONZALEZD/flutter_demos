import 'package:flutter/material.dart' show Tween;
import 'package:pokeball_anim/solution2/pokeball_data.dart';


class PokeballTween extends Tween<PokeballData> {

  PokeballTween({PokeballData begin, PokeballData end}):super(begin: begin, end: end);

  @override
  PokeballData lerp(double t) {
    return PokeballData.lerp(this.begin, this.end, t);
  }
}