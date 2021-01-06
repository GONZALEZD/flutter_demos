import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';

class PicturesLayout extends StatefulWidget {
  @override
  _PicturesLayoutState createState() => _PicturesLayoutState();
}

class _PicturesLayoutState extends State<PicturesLayout> with TickerProviderStateMixin {
  AnimationController _animationController;
  List<_MyPictureData> _picturesData;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    _picturesData = _createPicturesData();
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Toulouse - FRANCE"),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.swap_horizontal_circle), onPressed: __swapLayout,),
        actions: [IconButton(icon: Icon(Icons.replay), onPressed: __replayAnimation)],
      ),
      body: WallLayout(
        stones: _buildList(),
        layersCount: 3,
        stonePadding: 12.0,
      ),
    );
  }

  void __swapLayout() {
    Navigator.of(context).popAndPushNamed("usecase2");
  }

  void __replayAnimation() {
    _animationController.forward(from: 0.0);
    setState(() {});
  }

  List<_MyPictureData> _createPicturesData() {
    final data = [
      {"name": "croix_occitane.png", "width": 1, "height": 1},
      {"name": "day_capitole.jpg", "width": 2, "height": 1},
      {"name": "day_jardin_plantes.jpg", "width": 1, "height": 2},
      {"name": "day_raymond4.jpg", "width": 1, "height": 1},
      {"name": "night_pont_neuf.jpg", "width": 2, "height": 2},
      {"name": "day_canal2.jpg", "width": 1, "height": 1},
      {"name": "day_augustin.jpg", "width": 1, "height": 1},
      {"name": "night_saint_pierre.jpg", "width": 2, "height": 1},
      {"name": "day_musee_espace.jpg", "width": 1, "height": 2},
      {"name": "day_saint_sernin.jpg", "width": 2, "height": 2},
      {"name": "day_minotaure.jpg", "width": 1, "height": 1},
      {"name": "day_overview.jpg", "width": 3, "height": 1},
    ];
    double length = data.length.toDouble();
    final firstEnd = 0.35;
    return data.map((d) {
      final isFirst = data.indexOf(d) == 0;
      double pos = data.indexOf(d).toDouble();
      return _MyPictureData(
          name: d["name"],
          width: d["width"],
          height: d["height"],
          animatable: CurveTween(
            curve: Interval(
              isFirst ? 0.0 : (firstEnd + (pos/length)*(1.0 - firstEnd)),
              isFirst ? firstEnd : min(1.0, firstEnd + ((pos + 1.0) / length)*(1.0 - firstEnd)),
              curve: isFirst ? Curves.elasticOut: Curves.easeOutBack,
            ),
          ));
    }).toList();
  }

  List<Stone> _buildList() {
    return _picturesData.map((d) {
      return Stone(
        id: _picturesData.indexOf(d),
        width: d.width,
        height: d.height,
        child: ScaleTransition(
          scale: d.animatable.animate(_animationController),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/usecase1/${d.name}"),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _MyPictureData {
  final String name;
  final int width;
  final int height;
  final Animatable animatable;

  _MyPictureData({this.name, this.width, this.height, this.animatable});
}
