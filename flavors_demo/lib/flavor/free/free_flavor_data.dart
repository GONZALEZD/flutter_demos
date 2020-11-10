import 'package:flavors_demo/flavor_interface.dart';

class FreeFlavorData implements FlavorData {
  @override
  int applyBonus({int currentCredit}) {
    return currentCredit + 1;
  }

  @override
  String get title => "My App (free)";

}