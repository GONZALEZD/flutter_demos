import 'package:all_shadows/src/utils/shape_utils.dart';
import 'package:flutter/material.dart';
class PhysicalShapeTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipper: StarClipper(),
      color: Colors.amber,
      elevation: 4.0,
      shadowColor: Colors.deepOrange,
      child: SizedBox.fromSize(size: Size.square(100.0),),
    );
  }
}

class StarClipper extends CustomClipper<Path> {

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;

  @override
  Path getClip(Size size) => ShapeUtils.createStar(size);

}
