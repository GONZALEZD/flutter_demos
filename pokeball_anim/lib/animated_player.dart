import 'package:flutter/material.dart';

@protected
abstract class AnimatedPlayerState extends State<StatefulWidget> with TickerProviderStateMixin {
  final bool resetAnimationsOnUpdate;

  final Duration _duration = Duration(milliseconds: 6000);

  AnimatedPlayerState({this.resetAnimationsOnUpdate = false});

  AnimationController animationController;

  void createAnimations();

  AnimatedBuilder buildAnimatedPokeball(BuildContext context);

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    this.animationController = AnimationController(vsync: this, duration: _duration);
    this.animationController.addStatusListener(this.animationStatusListener);
    createAnimations();
    this.animationController.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    if (this.resetAnimationsOnUpdate) {
      _disposeAnimationController();
      _initAnimations();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _disposeAnimationController();
    super.dispose();
  }

  void _disposeAnimationController() {
    this.animationController?.removeStatusListener(this.animationStatusListener);
    this.animationController?.dispose();
  }

  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      this.animationController.stop();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: buildAnimatedPokeball(context),
        ),
        _buildPlayer(context),
      ],
    );
  }

  Widget _buildPlayer(BuildContext context) {
    return Material(
      type: MaterialType.card,
      color: Theme.of(context).colorScheme.surface,
      elevation: 8.0,
      child: AnimatedBuilder(
        animation: this.animationController,
        builder: (context, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPlayPauseButton(),
              Expanded(child: _buildProgressBar()),
              _buildElapsedTime(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return GestureDetector(
      onTap: this.togglePlayPause,
      child: SizedBox.fromSize(
        size: Size.square(56),
        child: Icon(
          this.animationController.velocity != 0.0 ? Icons.pause : Icons.play_arrow,
          size: 32.0,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Slider.adaptive(
      activeColor: Colors.grey.shade800,
      value: this.animationController.value,
      onChanged: this.seekTo,
      min: this.animationController.lowerBound,
      max: this.animationController.upperBound,
    );
  }

  Widget _buildElapsedTime() {
    int totalMs = this.animationController.duration.inMilliseconds;
    int ms = (this.animationController.value * totalMs).round();
    int seconds = ms ~/ 1000;
    var threeDigits = (n) {
      if (n >= 100) return "$n";
      if (n >= 10) return "0$n";
      return "00$n";
    };

    return Container(
      width: 60.0,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text("$seconds.${threeDigits(ms - seconds * 1000)}"),
    );
  }

  void togglePlayPause() {
    if (this.animationController.velocity != 0.0) {
      this.animationController.stop(canceled: true);
    } else {
      if (this.animationController.isCompleted || this.animationController.isDismissed) {
        this.animationController.forward(from: 0.0);
      } else {
        this.animationController.forward();
      }
    }
  }

  void seekTo(double value) {
    this.animationController.value = value;
  }
}
