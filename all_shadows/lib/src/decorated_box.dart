import 'package:flutter/material.dart';

class DecoratedBoxTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _example1(),
        _example2(),
        _neumorphism(),
        _example4(),
        _example4WithContainer(),
      ],
    );
  }

  Widget _example1() {
    return _wrap(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        shape: BoxShape.rectangle,
        color: Colors.lightBlue,
        boxShadow: [
          BoxShadow(
              color: Colors.blue.shade700,
              spreadRadius: 1.0,
              blurRadius: 10,
              offset: Offset(3.0, 3.0))
        ],
      ),
    );
  }

  Widget _example2() {
    return _wrap(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade700,
            spreadRadius: 0.0,
            blurRadius: 6.0,
          )
        ],
      ),
    );
  }

  Widget _neumorphism() {
    double elevation = 16.0;
    return _wrap(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.grey.shade50,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0.0,
              blurRadius: elevation,
              offset: Offset(3.0, 3.0)),
          BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 0.0,
              blurRadius: elevation / 2.0,
              offset: Offset(3.0, 3.0)),
          BoxShadow(
              color: Colors.white,
              spreadRadius: 2.0,
              blurRadius: elevation,
              offset: Offset(-3.0, -3.0)),
          BoxShadow(
              color: Colors.white,
              spreadRadius: 2.0,
              blurRadius: elevation / 2,
              offset: Offset(-3.0, -3.0)),
        ],
      ),
    );
  }

  List<BoxDecoration> get decorations => [
  BoxDecoration(color: Colors.teal.shade400, boxShadow: [
  BoxShadow(color: Colors.teal.shade700, blurRadius: 1.0),
  ]),
  BoxDecoration(
  color: Colors.tealAccent.shade700,
  borderRadius: BorderRadius.circular(60.0),
  boxShadow: [BoxShadow(color: Colors.teal.shade700, blurRadius: 6.0)]),
  ];

  Widget _example4() {
    return Center(child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: AnimatedDecorationBox(decorations: decorations),
    ));
  }

  Widget _example4WithContainer() {
    final decorationsList = decorations;
    int index = 0;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StatefulBuilder(builder: (context, setState) {
          return GestureDetector(
            onTap: () => setState(() => index = (index + 1)%decorationsList.length),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              constraints: BoxConstraints.expand(width: 100.0, height: 100.0),
              decoration: decorationsList[index],
              child: Icon(Icons.play_arrow, color: Colors.white,),
            ),
          );
        }),
      ),
    );
  }

  Widget _wrap({BoxDecoration decoration}) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(width: 100.0, height: 100.0),
        decoration: decoration,
        margin: const EdgeInsets.all(20.0),
      ),
    );
  }
}

class AnimatedDecorationBox extends StatefulWidget {
  final List<BoxDecoration> decorations;

  AnimatedDecorationBox({this.decorations});

  @override
  _AnimatedDecorationBoxState createState() => _AnimatedDecorationBoxState();
}

class _AnimatedDecorationBoxState extends State<AnimatedDecorationBox>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int index;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    index = 0;
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get _nextIndex => (index + 1) % widget.decorations.length;

  void _onClick() {
    setState(() {
      index = _nextIndex;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBoxTransition(
      child: GestureDetector(
        onTap: _onClick,
        child: SizedBox.fromSize(
          size: Size.square(100.0),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ),
      decoration: DecorationTween(
              begin: widget.decorations[index],
              end: widget.decorations[_nextIndex])
          .animate(_controller),
    );
  }
}
