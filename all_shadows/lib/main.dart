import 'package:all_shadows/src/custom_paint.dart';
import 'package:all_shadows/src/decorated_box.dart';
import 'package:all_shadows/src/physical_model.dart';
import 'package:all_shadows/src/physical_shape.dart';
import 'package:all_shadows/src/text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ShadowWidgetType _selected;

  @override
  void initState() {
    super.initState();
    _selected = ShadowWidgetType.decoratedBox;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [_buildMenu()],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: _selected.buildWidget(context),
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return PopupMenuButton(
      child: Icon(Icons.menu),
      onSelected: (type) => setState(() => _selected = type),
      itemBuilder: (context) {
        return ShadowWidgetType.values.map((type) {
          return PopupMenuItem(
            value: type,
            child: Text(type.description),
          );
        }).toList();
      },
    );
  }
}

enum ShadowWidgetType {
  decoratedBox,
  physicalModel,
  text,
  customPaint,
  physicalShape,
}

extension ShadowWidgetTypeDescription on ShadowWidgetType {
  String get description {
    switch (this) {
      case ShadowWidgetType.decoratedBox:
        return 'Decorated Box';
      case ShadowWidgetType.physicalModel:
        return 'Physical model';
      case ShadowWidgetType.text:
        return 'Text';
      case ShadowWidgetType.customPaint:
        return 'CustomPaint';
      case ShadowWidgetType.physicalShape:
        return 'Physical Shape';
      default:
        return '???';
    }
  }

  Widget buildWidget(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    switch (this) {
      case ShadowWidgetType.decoratedBox:
        return DecoratedBoxTest();
      case ShadowWidgetType.physicalModel:
        return PhysicalModelTest();
      case ShadowWidgetType.text:
        return TextTest();
      case ShadowWidgetType.customPaint:
        return CustomPaintTest();
      case ShadowWidgetType.physicalShape:
        return PhysicalShapeTest();
      default:
        return Text('???');
    }
  }
}