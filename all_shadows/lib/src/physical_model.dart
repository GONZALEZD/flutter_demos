import 'dart:math';

import 'package:flutter/material.dart';

class PhysicalModelTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        example1(),
        example2(),
        example3(),
        example4(),
      ].map((w) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: w,
        );
      }).toList(),
    );
  }

  Widget example1() {
    return PhysicalModel(
      color: Colors.lightBlue,
      elevation: 3.5,
      shape: BoxShape.rectangle,
      child: SizedBox.fromSize(
        size: const Size.square(100.0),
      ),
    );
  }

  Widget example2() {
    return PhysicalModel(
      color: Colors.red,
      shadowColor: Colors.red,
      elevation: 5.0,
      shape: BoxShape.circle,
      child: SizedBox.fromSize(
        size: const Size.square(100.0),
      ),
    );
  }

  Widget example3() {
    return PhysicalModel(
      color: Colors.greenAccent,
      shadowColor: Colors.greenAccent,
      elevation: 12.0,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(40.0),
      child: SizedBox.fromSize(
        size: const Size(200.0, 80.0),
      ),
    );
  }

  Widget example4() {
    final elevations = [1.0, 16.0];
    int index = elevations.length-1;
    return StatefulBuilder(
      builder: (context, setState) {
        return AnimatedPhysicalModel(
          child: GestureDetector(
            onTap: () => setState(() {
              index = (index + 1) % elevations.length;
            }),
            child: SizedBox.fromSize(
              size: const Size.square(100.0),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
          shape: BoxShape.rectangle,
          elevation: elevations[index],
          borderRadius: BorderRadius.circular(elevations[index]),
          color: Colors.amber,
          shadowColor: Colors.deepOrange,
          duration: Duration(milliseconds: 500),
        );
      },
    );
  }
}
