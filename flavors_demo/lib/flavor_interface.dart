import 'package:flutter/cupertino.dart';

abstract class FlavorData {
  String get title;

  int applyBonus({int currentCredit});
}

typedef FlavorLayoutBuilder = Widget Function(BuildContext, Widget child);