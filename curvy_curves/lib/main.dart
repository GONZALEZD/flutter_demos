import 'dart:math';

import 'package:curvy_curves/curve_presenter.dart';
import 'package:curvy_curves/curve_tile.dart';
import 'package:curvy_curves/named_curves.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(title: 'Curvy Curves'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _selectedCurves;
  List<bool> _flipped;

  @override
  void initState() {
    super.initState();
    _selectedCurves = [NamedCurves.names.first];
    _flipped = [false];
  }

  Animatable buildCurveTween() {
    var _getCurve = (index) {
      return _flipped[index]
          ? NamedCurves.all[_selectedCurves[index]].flipped
          : NamedCurves.all[_selectedCurves[index]];
    };
    var curve = _getCurve(0);
    Animatable tween = CurveTween(curve: curve);
    for (var i = 1; i < _selectedCurves.length; i++) {
      curve = _getCurve(i);
      tween = tween.chain(CurveTween(curve: curve));
    }
    return tween;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: this.addCurve)
        ],
      ),
      body: Column(
        children: [
          _buildCurvesSelector(),
          Expanded(child: CurvePresenter(curve: buildCurveTween())),
        ],
      ),
    );
  }

  void addCurve() {
    setState(() {
      _selectedCurves.add(NamedCurves.names.first);
      _flipped.add(false);
    });
  }

  Widget _buildCurvesSelector() {
    return Container(
      color: Colors.grey.shade200,
      constraints: BoxConstraints.tightForFinite(height: min(_selectedCurves.length*50.0, 100.0)),
      child: Scrollbar(
        thickness: 4.0,
        child: ListView.builder(
          itemCount: _selectedCurves.length,
          itemBuilder: (context, index) {
            return CurveTile(
              curveIndex: index,
              curveName: _selectedCurves[index],
              curveFlipped: _flipped[index],
              deletable: _selectedCurves.length > 1,
              onFlipped: (flipped) => setState(() => _flipped[index] = flipped),
              onChanged: (name) => setState(() => _selectedCurves[index] = name),
              onDelete: () => setState(() {
                this._selectedCurves.removeAt(index);
                this._flipped.removeAt(index);
              }),
            );
          },
        ),
      ),
    );
  }
}
