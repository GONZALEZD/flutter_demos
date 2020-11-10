import 'package:flavors_demo/flavor_interface.dart';
import 'package:flutter/material.dart';

FlavorLayoutBuilder layout = (BuildContext context, Widget child) {
  print("COUCOU");
  return Scaffold(
    body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: child),
        Container(
          height: 80.0,
          color: Colors.green,
          child: Center(child: Text("Advertisements"),),
        ),
      ],
    ),
  );
};