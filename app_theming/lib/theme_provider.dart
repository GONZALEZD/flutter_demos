import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppTheme { colorfull, androidDark, androidLight, iosLike }

extension AppThemesData on AppTheme {
  double get horizontalGap => _map(values: [28.0, 0.0, 0.0, 12.0]);

  Color get tileSelectedColor =>
      _map(values: [Colors.white12, null, null, CupertinoColors.systemGrey5]);

  Color get tileSelectedTextColor =>
      _map(values: [Colors.white, null, null, Colors.black87]);

  String get name => _map(values: [
        "Colorfull Theme",
        "Android Dark Theme",
        "Android Light Theme",
        "iOS like Theme"
      ]);

  EdgeInsets get tilePadding => _map(values: [
        EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        null,
        null,
        EdgeInsets.all(16.0),
      ]);

  T _map<T>({List<T> values}) {
    assert(AppTheme.values.length == values.length);
    final index = AppTheme.values.indexOf(this);
    return values[index];
  }
}

class ThemeProvider with ChangeNotifier {
  AppTheme _current;

  ThemeData get themeData => allThemes()[_current];

  static Map<AppTheme, ThemeData> allThemes() => {
        AppTheme.colorfull: colorFull(Colors.lightBlueAccent.shade700,
            accentColor: Colors.purple, iconColor: Colors.greenAccent),
        AppTheme.androidDark: androidDark(Colors.deepPurple, Colors.amber),
        AppTheme.androidLight: androidLight(Colors.deepPurple, Colors.amber),
        AppTheme.iosLike: iosLike(),
      };

  ThemeProvider() {
    final allThemes = ThemeProvider.allThemes();
    _current = allThemes.keys.first;
  }

  set current(AppTheme theme) {
    _current = theme;
    notifyListeners();
  }

  AppTheme get current => _current;

  static ThemeData androidDark(Color primary, Color accent) {
    final base = ThemeData.from(
      colorScheme: ColorScheme.dark(
        primary: accent,
        secondary: accent,
        primaryVariant: accent,
        secondaryVariant: accent,
      ),
    );
    return base.copyWith(
      platform: TargetPlatform.android,
      toggleableActiveColor: accent,
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        type: BottomNavigationBarType.fixed,
        backgroundColor: base.primaryColor,
        selectedItemColor: accent,
        unselectedItemColor: Colors.white24,
      ),
    );
  }

  static ThemeData androidLight(Color primary, Color accent) {
    final base = ThemeData.from(
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: accent,
        background: Color.lerp(primary, Colors.white, 0.95),
      ),
    );
    return base.copyWith(
      platform: TargetPlatform.android,
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        type: BottomNavigationBarType.fixed,
        backgroundColor: base.primaryColor,
        selectedItemColor: Colors.white.withOpacity(0.9),
        unselectedItemColor: Colors.white38,
      ),
      appBarTheme: base.appBarTheme?.copyWith(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      cardTheme: base.cardTheme?.copyWith(
        color: Colors.white,
        margin: EdgeInsets.all(4.0),
      ),
    );
  }

  static ThemeData iosLike() {
    final base = ThemeData.from(
      colorScheme: ColorScheme.light(
        primary: CupertinoColors.activeBlue,
        secondary: CupertinoColors.activeGreen,
        background: CupertinoColors.extraLightBackgroundGray,
      ),
      textTheme: Typography.englishLike2018,
    );
    return base.copyWith(
      platform: TargetPlatform.iOS,
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        foregroundColor: CupertinoColors.label,
        backwardsCompatibility: false,
        centerTitle: true,
        titleTextStyle: base.textTheme.headline6.copyWith(
          fontWeight: FontWeight.w700,
          color: CupertinoColors.label,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        backgroundColor: CupertinoColors.systemBackground,
        selectedItemColor: CupertinoColors.activeBlue,
        unselectedItemColor: CupertinoColors.lightBackgroundGray,
      ),
      cupertinoOverrideTheme: base.cupertinoOverrideTheme?.copyWith(
        scaffoldBackgroundColor: base.primaryColor,
        barBackgroundColor: base.primaryColor,
      ),
      cardTheme: base.cardTheme?.copyWith(
        color: CupertinoColors.systemGroupedBackground,
      ),
    );
  }

  static ThemeData colorFull(Color mainColor,
      {Color accentColor = Colors.white, Color iconColor = Colors.white}) {
    final base = ThemeData.dark();
    Color dataColor = Colors.white;
    final textTheme = __createTextTheme();
    return base.copyWith(
      textTheme: textTheme,
      backgroundColor: mainColor,
      splashColor: mainColor,
      iconTheme: base.iconTheme.copyWith(size: 42.0, color: iconColor),
      tooltipTheme: base.tooltipTheme?.copyWith(
          height: 40.0,
          textStyle: TextStyle(color: dataColor, fontWeight: FontWeight.bold),
          decoration: BoxDecoration(
            color: Color.lerp(mainColor, dataColor, 0.15),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: dataColor.withOpacity(0.5), width: 2.0),
          )),
      canvasColor: mainColor,
      scaffoldBackgroundColor: mainColor,
      cardColor: Color.lerp(mainColor, Colors.white, 0.2),
      cardTheme: base.cardTheme?.copyWith(
        color: Color.lerp(mainColor, Colors.black, 0.1),
        margin: EdgeInsets.all(20.0),
        elevation: 0.0,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
            side: BorderSide(color: Colors.white24, width: 1)),
      ),
      toggleableActiveColor: accentColor,
      cupertinoOverrideTheme: CupertinoThemeData(
        scaffoldBackgroundColor: mainColor,
        barBackgroundColor: mainColor,
        primaryColor: accentColor,
      ),
      colorScheme: base.colorScheme?.copyWith(
        background: mainColor,
      ),
      appBarTheme: base.appBarTheme?.copyWith(
        backwardsCompatibility: false,
        backgroundColor: mainColor,
        elevation: 0.0,
        foregroundColor: dataColor,
        titleTextStyle: textTheme.headline5,
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: mainColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: dataColor.withOpacity(0.8),
        unselectedItemColor: dataColor.withOpacity(0.3),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white70,
        selectionColor: Color.lerp(mainColor, Colors.white, 0.25),
        selectionHandleColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: accentColor.withOpacity(0.3),
        contentPadding: EdgeInsets.all(8.0),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none, width: 0.0),
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
      checkboxTheme: CheckboxThemeData(shape: CircleBorder()),
    );
  }

  Widget wrap(Widget child) {
    Widget result = ListTileTheme(
      child: child,
      horizontalTitleGap: _current.horizontalGap,
      selectedColor: _current.tileSelectedTextColor,
      selectedTileColor: _current.tileSelectedColor ??
          themeData.primaryColor.withOpacity(0.15),
      contentPadding: _current.tilePadding,
    );
    return result;
  }

  static TextTheme __createTextTheme(
      {String titleFontFamily = "Sansita", String bodyFontFamily = "Kufam"}) {
    final titleStyle =
        TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w700);
    return Typography.englishLike2018.merge(TextTheme(
      headline1: titleStyle,
      headline2: titleStyle,
      headline3: titleStyle,
      headline4: titleStyle,
      headline5: titleStyle,
      headline6: titleStyle,
      subtitle1: TextStyle(
        fontFamily: bodyFontFamily,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      subtitle2: TextStyle(fontFamily: bodyFontFamily),
      bodyText1: TextStyle(fontFamily: bodyFontFamily, color: Colors.white),
      bodyText2: TextStyle(
          fontFamily: bodyFontFamily, color: Colors.white.withOpacity(0.8)),
    ));
  }
}
