
import 'package:flavors_demo/flavor_interface.dart';

class PaidFlavorData implements FlavorData {
  @override
  int applyBonus({int currentCredit}) {
    var extra = (currentCredit*0.1).round();
    return currentCredit + (extra < 1 ? 1 : extra);
  }

  @override
  String get title => "My App";

}