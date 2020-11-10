import 'package:flavors_demo/flavor_interface.dart';
import 'package:flavors_demo/flavor/free/layout.dart' as layoutFree;
import 'package:flavors_demo/flavor/free/free_flavor_data.dart' as dataFree;

import 'package:flavors_demo/flavor/paid/layout.dart' as layoutPaid;
import 'package:flavors_demo/flavor/paid/paid_flavor_data.dart' as dataPaid;

enum Flavor {
  FREE,
  PAID,
}

class F {
  static Flavor appFlavor;

  static FlavorData get data {
    switch (appFlavor) {
      case Flavor.FREE:
        return dataFree.FreeFlavorData();
      case Flavor.PAID:
        return dataPaid.PaidFlavorData();
      default:
        throw "Error while creating flavor data";
    }
  }

  static FlavorLayoutBuilder get layoutBuilder {
    switch (appFlavor) {
      case Flavor.FREE:
        return layoutFree.layout;
      case Flavor.PAID:
        return layoutPaid.layout;
      default:
        throw "Error while getting general layout";
    }
  }

}


