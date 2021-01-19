import 'package:flutter/cupertino.dart';
import 'package:linkageview/linkage_view.dart';

class DataTestGroup {
  final String name;
  final IconData icon;
  final List<DataTest> data;

  DataTestGroup._({this.name, this.icon, this.data});

  DataTest operator [](int index) => data[index];

  int get count => data.length;

  factory DataTestGroup.generate(
      {String name, IconData icon, String dataPrefix, int dataLength}) {
    return DataTestGroup._(
      name: name,
      icon: icon,
      data: List<DataTest>.generate(
          dataLength, (index) => DataTest(name: '$dataPrefix n° ${index + 1}', value: index+1)),
    );
  }

  List<Map<String, dynamic>> flatMap() {
    return data.map((d) {
      return {
        'name': name,
        'icon' : icon,
        'dataName' : d.name,
        'dataValue' : d.value,
      };
    }).toList();
  }

  List<BaseItem> toBaseItems() {
    final header = BaseItem(
      isHeader: true,
      header: name,
      info: icon,
    );
    return [header] + data.map((d) {
      return BaseItem(
        isHeader: false,
        title: '${d.name}',
        info: d.value,
      );
    }).toList();
  }
}

class DataTest {
  final String name;
  final int value;

  DataTest({this.name, this.value});
}
