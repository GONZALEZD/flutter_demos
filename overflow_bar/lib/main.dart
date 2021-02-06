import 'package:flutter/material.dart';
import 'package:overflow_bar/blog_overview.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter OverflowBar Demo'),
      ),
      body: ListView.separated(
        itemCount: 20,
        itemBuilder: (context, index) => _buildBlog(index),
        separatorBuilder: (context, index) => Divider(height: 80.0,),
        padding: EdgeInsets.symmetric(horizontal: 12.0),
      ),
    );
  }

  Widget _buildBlog(int index) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
      child: BlogOverview(
        title: 'Blog Nature #${index+1}',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Nam elementum gravida enim, vitae congue massa lacinia ut. '
            'Sed ultricies nulla eget sem convallis dignissim. '
            'Suspendisse sit amet nibh nec urna lobortis suscipit in nec lectus. '
            'Suspendisse dictum risus sit amet leo sodales, ac sodales ligula scelerisque. '
            'Maecenas gravida neque nec velit fermentum, vel tincidunt nunc laoreet.',
        image: Image.asset('assets/forest${index%5 +1}.jpg', fit: BoxFit.cover,),
        reversed: index.isOdd,
      ),
    );
  }
}
