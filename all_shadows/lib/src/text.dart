import 'package:flutter/material.dart';

class TextTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        test1(context),
        neumorphism(context),
      ]
          .map((w) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: w,
              ))
          .toList(),
    );
  }

  Widget test1(BuildContext context) {
    return Text(
      "Hello :)",
      style: TextStyle(
          fontSize: 60.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          shadows: [
            Shadow(
                color: Colors.indigo,
                offset: Offset(0.0, 3.0),
                blurRadius: 3.0),
          ]),
    );
  }

  Widget neumorphism(BuildContext context) {
    final elevation = 3.0;
    return Text(
      "Hello :)",
      style: TextStyle(
          fontSize: 60.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade50,
          shadows: [
            Shadow(
                color: Colors.grey.shade300,
                offset: Offset(3.0, 3.0),
                blurRadius: elevation),
            Shadow(
                color: Colors.white,
                offset: Offset(-3.0, 3.0),
                blurRadius: elevation),
          ]),
    );
  }
}
