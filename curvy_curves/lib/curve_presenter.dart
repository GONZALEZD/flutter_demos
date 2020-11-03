import 'dart:math' as math;
import 'dart:ui';

import 'package:curvy_curves/graph_painter.dart';
import 'package:flutter/material.dart';

class CurvePresenter extends StatefulWidget {
  final Animatable curve;

  CurvePresenter({this.curve});

  @override
  _CurvePresenterState createState() => _CurvePresenterState();
}

class _CurvePresenterState extends State<CurvePresenter> with TickerProviderStateMixin {
  AnimationController _animationController;

  Animation _curveAnimation;

  List<Offset> _curvePoints;

  List<Offset> get _currentCurve => _curvePoints
      .getRange(0, (_animationController.value * (_curvePoints.length - 1) + 1).toInt())
      .toList();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animationController.addStatusListener((status) async {
      try {
        switch (status) {
          case AnimationStatus.completed:
            await Future.delayed(Duration(seconds: 2));
            _animationController.reverse(from: 1.0);
            break;
          case AnimationStatus.dismissed:
            await Future.delayed(Duration(seconds: 2));
            _animationController.forward(from: 0.0);
            break;
        }
      } catch (e) {
        print("Canceled when disposed");
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CurvePresenter oldWidget) {
    _resetAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _resetAnimation();
    super.didChangeDependencies();
  }

  void _resetAnimation() {
    _curveAnimation = this.widget.curve.animate(_animationController);
    _curvePoints = __createCurvePoints();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        var children = [
          Expanded(child: _buildGraphPanel()),
          TransformationsContainer(animation: _curveAnimation)
        ];
        if (orientation == Orientation.portrait) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        }
      },
    );
  }

  Widget _buildGraphPanel() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
      child: AspectRatio(
        aspectRatio: 1.5,
        child: AnimatedBuilder(
          animation: _curveAnimation,
          builder: (context, child) {
            return CustomPaint(painter: GraphPainter(curve: _currentCurve));
          },
        ),
      ),
    );
  }

  List<Offset> __createCurvePoints() {
    int nbPoints = 200;
    var points = List.generate(nbPoints + 1, (index) {
      double t = (index / nbPoints).toDouble();
      return Offset(t, 1.0 - this.widget.curve.transform(t));
    });
    return points;
  }
}

class TransformationsContainer extends StatelessWidget {
  final Animation animation;

  TransformationsContainer({this.animation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            __buildBox(
              builder: (_, child) =>
                  Transform.translate(offset: Offset(this.animation.value * 25, 0.0), child: child),
              alignment: Alignment.centerLeft,
            ),
            Padding(padding: EdgeInsets.only(bottom: 12.0), child: Text("Translate")),
            __buildBox(
                builder: (_, child) => Transform.scale(scale: this.animation.value, child: child)),
            Padding(padding: EdgeInsets.only(bottom: 12.0), child: Text("Scale")),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            __buildBox(
                builder: (_, child) =>
                    Transform.rotate(angle: this.animation.value * math.pi / 2, child: child)),
            Padding(padding: EdgeInsets.only(bottom: 12.0), child: Text("Rotate")),
            __buildBox(
                builder: (_, child) =>
                    Opacity(opacity: this.animation.value.clamp(0.0, 1.0), child: child)),
            Padding(padding: EdgeInsets.only(bottom: 12.0), child: Text("Opacity")),
          ],
        ),
      ],
    );
  }

  Widget __buildBox({TransitionBuilder builder, Alignment alignment = Alignment.center}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      alignment: alignment,
      constraints: BoxConstraints.tight(Size.square(60.0)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade700, width: 2.0),
      ),
      child: AnimatedBuilder(
        animation: this.animation,
        builder: builder,
        child: __buildElement(),
      ),
    );
  }

  Widget __buildElement() {
    return SizedBox.fromSize(
      size: Size(30.0, 15.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.green.shade400,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
