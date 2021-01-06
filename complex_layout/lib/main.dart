import 'package:flutter/material.dart';
import 'package:complex_layout/usecase/pictures_layout.dart';
import 'package:complex_layout/usecase/article_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wall Layout',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: "usecase1",
      routes: {
        "usecase1" : (context) => PicturesLayout(),
        "usecase2" : (context) => ArticleLayout(),
      },
    );
  }
}