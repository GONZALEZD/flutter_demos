import 'package:flutter/material.dart';

enum CellType {
  articles,
  events,
  other,
  all,
  none,
}

class CellData {
  final String title;
  final String message;
  final IconData icon;
  final CellType type;

  CellData({this.title, this.message, this.icon, this.type = CellType.other});
}

class ShortcutData {
  final String name;
  final IconData icon;
  final CellType filter;

  ShortcutData({this.name, this.icon, this.filter});
}

class DataProvider {

  List<CellData> generateCellData() {
    final icons = [
      Icons.adaptive.arrow_back,
      Icons.adaptive.flip_camera,
      Icons.adaptive.share,
      Icons.adaptive.arrow_forward,
      Icons.adaptive.more,
    ];
    final types = [CellType.other, CellType.articles, CellType.events];
    return List.generate(
        10,
            (index) => CellData(
          title: "Element n°${index + 1}",
          message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque et ex vel dui facilisis scelerisque in ut sapien.",
          icon: icons[index % (icons.length)],
          type: types[index % types.length],
        ));
  }

  List<ShortcutData> generateShortcutsData() {
    return [
      ShortcutData(name: "home", icon: Icons.home, filter: CellType.all),
      ShortcutData(name: "articles", icon: Icons.article, filter: CellType.articles),
      ShortcutData(name: "events", icon: Icons.event, filter: CellType.events),
      ShortcutData(name: "settings", icon: Icons.settings),
    ];
  }
}