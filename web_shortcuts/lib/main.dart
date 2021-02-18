import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:web_shortcuts/src/dev_shortcuts.dart';
import 'package:web_shortcuts/src/my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showPerformanceOverlay;
  bool showDebugBanner;
  bool debugShowMaterialGrid;
  ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    showPerformanceOverlay = false;
    showDebugBanner = true;
    debugShowMaterialGrid = false;
    themeMode = ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      showPerformanceOverlay: showPerformanceOverlay,
      debugShowCheckedModeBanner: showDebugBanner,
      debugShowMaterialGrid: debugShowMaterialGrid,
      actions: {
        DevelopmentIntent: DevelopmentAction(),
        ToggleThemeIntent: ToggleThemeAction(),
        SendDebugDataIntent: SendDebugDataAction(),
      },
      shortcuts: _shortcuts,
      home: MyHomePage(),
    );
    return app;
  }

  Map<LogicalKeySet, Intent> get _shortcuts => {
        LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.f12):
            const SendDebugDataIntent(),
        LogicalKeySet(LogicalKeyboardKey.f12): ToggleThemeIntent(toggle: (brightness) {
          setState(() {
            themeMode = (brightness == Brightness.light)
                ? ThemeMode.dark
                : ThemeMode.light;
          });
        }),
        LogicalKeySet(LogicalKeyboardKey.f10):
            DevelopmentIntent(action: () {
          setState(() => showPerformanceOverlay = !showPerformanceOverlay);
        }),
        LogicalKeySet(LogicalKeyboardKey.f9): DevelopmentIntent(action: () {
          setState(() => showDebugBanner = !showDebugBanner);
        }),
        LogicalKeySet(LogicalKeyboardKey.f8): DevelopmentIntent(action: () {
          setState(() => debugShowMaterialGrid = !debugShowMaterialGrid);
        }),
      };
}
