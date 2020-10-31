import 'package:flutter/material.dart';
import 'package:pokeball_anim/solution1/animated_pokeball.dart' as solution1;
import 'package:pokeball_anim/solution2/animated_pokeball.dart' as solution2;
import 'package:pokeball_anim/solution3/animated_pokeball.dart' as solution3;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokeball animation',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Animation Showcase'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade600,
        title: Text(this.title),
      ),
      backgroundColor: Colors.amber.shade50,
      body: solution3.AnimatedPokeball(),
    );
  }
}