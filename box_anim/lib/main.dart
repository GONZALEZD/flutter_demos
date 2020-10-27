import 'package:box_anim/animated_parcel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Box Animation Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
        children: [
          AnimatedParcel(
            content: Icon(CupertinoIcons.device_phone_portrait, size: 120.0),
            fallHeight: 400.0,
            boxSize: Size(100.0, 60.0),
          ),
          _buildGround(),
        ],
      ),
    );
  }

  Widget _buildGround() {
    return Container(
      color: Colors.grey,
      height: 2.0,
    );
  }
}
