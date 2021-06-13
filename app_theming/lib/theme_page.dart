import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_theming/data_provider.dart';
import 'package:app_theming/preferences_widget.dart';
import 'package:app_theming/theme_provider.dart';

class ThemePage extends StatefulWidget {
  final String title;

  final List<CellData> data;
  final List<ShortcutData> shortcuts;

  ThemePage({this.title, this.data, this.shortcuts});

  @override
  State<StatefulWidget> createState() => ThemePageState();
}

class ThemePageState extends State<ThemePage> {
  CellType currentFilter;
  CellData selected;
  PageController _pageController;

  final _shortcutFilters = [
    CellType.all,
    CellType.articles,
    CellType.events,
    CellType.none
  ];

  @override
  void initState() {
    super.initState();
    currentFilter = CellType.all;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [_changeThemeAction(context)],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _shortcutFilters.length,
              onPageChanged: _selectPage,
              itemBuilder: (_, index) => _buildList(index),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _changeThemeAction(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      onSelected: (theme) => context.read<ThemeProvider>().current = theme,
      itemBuilder: (context) {
        return AppTheme.values.map((appTheme) {
          return PopupMenuItem<AppTheme>(
            child: Text(appTheme.name),
            value: appTheme,
          );
        }).toList();
      },
    );
  }

  Widget _buildList(int index) {
    if(index == widget.shortcuts.length-1) {
      return PreferencesWidget();
    }
    final filter = _shortcutFilters[index];
    final filteredData = widget.data
        .where((cellData) => filter == CellType.all || cellData.type == filter)
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        final value = filteredData[index];
        return ListTile(
          selected: value == selected,
          title: Text(value.title),
          subtitle: Text(value.message),
          leading: Icon(value.icon),
          onTap: () => setState(() => selected = value),
        );
      },
      itemCount: filteredData.length,
    );
  }

  void _selectPage(int index, {bool animate = false}) {
    if (animate) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
    setState(() => currentFilter = _shortcutFilters[index]);
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      currentIndex: max(0, _shortcutFilters.indexOf(currentFilter)),
      onTap: (index) => _selectPage(index, animate: true),
      items: widget.shortcuts
          .map((shortcut) => BottomNavigationBarItem(
                label: shortcut.name,
                icon: Icon(shortcut.icon),
              ))
          .toList(),
    );
  }
}
