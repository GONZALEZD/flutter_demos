import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_theming/theme_page.dart';
import 'package:app_theming/theme_provider.dart';
import 'package:app_theming/data_provider.dart';

void main() {
  runApp(ThemeSelector());
}

class ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = DataProvider();
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Builder(
        builder: (c) => c.read<ThemeProvider>().wrap(
              MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: c.watch<ThemeProvider>().themeData,
                home: ThemePage(
                  title: "Application Theming",
                  data: dataProvider.generateCellData(),
                  shortcuts: dataProvider.generateShortcutsData(),
                ),
              ),
            ),
      ),
    );
  }
}
