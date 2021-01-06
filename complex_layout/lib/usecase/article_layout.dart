import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';

class ArticleLayout extends StatefulWidget {
  @override
  _ArticleLayoutState createState() => _ArticleLayoutState();
}

class _ArticleLayoutState extends State<ArticleLayout> {
  int _nbColumns;

  @override
  void initState() {
    super.initState();
    _nbColumns = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Jewel example"),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.swap_horizontal_circle), onPressed: __swapLayout,),
        actions: [IconButton(icon: RotatedBox(quarterTurns: 1, child: Icon(Icons.height),), onPressed: __changeLayersNumber)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: WallLayout(
          stones: _buildElements(),
          layersCount: _nbColumns,
          stonePadding: 2.0,
        ),
      ),
    );
  }

  void __swapLayout() {
    Navigator.of(context).popAndPushNamed("usecase1");
  }

  void __changeLayersNumber() {
    setState(() {
      _nbColumns = max(2, (_nbColumns + 1) % 5);
    });
  }

  List<Stone> _buildElements() {
    final description1 =
        "Bracelet semainier en laiton trempé dans un bain doré est signé Shabada X Chachawax (SHABABAX)";
    final description2 =
        "Composé de plusieurs joncs sertis de pierres jade orange reliés par des breloques";
    var data = [
      {"width": 2, "height": 1, "child": _Builder.buildArticleName()},
      {"width": 1, "height": 1, "child": _Builder.buildText("49,00 €", fontSize: 20.0)},
      {"width": 1, "height": 1, "child": _Builder.buildImage("shabada_4.jpg")},
      {"width": 2, "height": 1, "child": _Builder.buildImage("shabada_2long.jpg")},
      {"width": 2, "height": 2, "child": _Builder.buildImage("shabada_1.jpg")},
      {"width": 1, "height": 1, "child": _Builder.buildText("Diamètre\n7 cm")},
      {"width": 1, "height": 2, "child": _Builder.buildImage("shabada_4_tall.jpg")},
      {"width": 2, "height": 2, "child": _Builder.buildText(description1)},
      {"width": 1, "height": 1, "child": _Builder.buildImage("shabada_5.jpg")},
      {"width": 2, "height": 1, "child": _Builder.buildImage("shabada_4long.jpg")},
      {"width": 1, "height": 1, "child": _Builder.buildText("Poignets fins à normaux")},
      {"width": 1, "height": 1, "child": _Builder.buildText("éco-conçues à Barcelone")},
      {"width": 1, "height": 1, "child": _Builder.buildImage("shabada_2.jpg")},
      {"width": 1, "height": 1, "child": _Builder.buildImage("shabada_3.jpg")},
      {"width": 1, "height": 2, "child": _Builder.buildImage("shabada_3_tall.jpg")},
      {"width": 2, "height": 2, "child": _Builder.buildText(description2)},
      {"width": 1, "height": 2, "child": _Builder.buildImage("shabada_2_tall.jpg")},
      {"width": 1, "height": 1, "child": _Builder.buildText("Une question ?")},
      {"width": 2, "height": 1, "child": _Builder.buildImage("shabada_2_long2.jpg")},
      {"width": 1, "height": 1, "child": _Builder.buildText("By\nJollia")},
    ];
    return data.map((d) {
      return Stone(id: data.indexOf(d), width: d["width"], height: d["height"], child: d["child"]);
    }).toList();
  }
}

class _Builder {
  static Widget buildArticleName() {
    return __buildColoredTile(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Shabada",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 6.0,
              fontSize: 30.0,
            ),
          ),
          Text(
            "Bracelet semainier wax (turquoise)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildImage(String image) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/usecase2/$image"),
        ),
      ),
    );
  }

  static Widget buildText(String text, {double fontSize = 17.0}) {
    return __buildColoredTile(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }

  static Widget __buildColoredTile({Widget child}) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.tealAccent.shade700, Colors.cyan.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
