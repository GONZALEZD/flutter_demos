import 'package:flutter/material.dart';

class BlogOverview extends StatelessWidget {
  final Widget image;
  final String title;
  final String text;
  final bool reversed;

  BlogOverview({this.title, this.text, this.image, this.reversed = false});

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      overflowAlignment: OverflowBarAlignment.center,
      spacing: 20.0,
      overflowSpacing: 16.0,
      textDirection: reversed ? TextDirection.rtl : TextDirection.ltr,
      children: [
        _buildImageWidget(),
        _buildDescriptionPanel(),
      ],
    );
  }

  Widget _buildImageWidget() {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.square(300.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: image,
      ),
    );
  }

  Widget _buildDescriptionPanel() {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size.fromWidth(300.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(bottom: 4.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),),
          ),
          Text(text, maxLines: 8, overflow: TextOverflow.ellipsis,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(title: 'I Like it !', color: Colors.pink),
              _buildButton(title: 'Share !', color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({String title, Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: color,
        textColor: Colors.white,
        onPressed: () {},
        child: Text(title),
      ),
    );
  }
}
