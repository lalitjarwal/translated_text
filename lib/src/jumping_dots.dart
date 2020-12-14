import 'package:flutter/material.dart';

class _JumpingDot extends AnimatedWidget {
  final Color color;
  final double fontSize;
  _JumpingDot({Key key, Animation<double> animation, this.color, this.fontSize})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Transform.translate(
      offset: Offset(0, -animation.value),
      child: Text(
        '•',
        textAlign: TextAlign.center,
        style: TextStyle(color: color, fontSize: fontSize),
      ),
    );
  }
}

class JumpingDotsProgressIndicator extends StatefulWidget {
  /// number dots required to animate
  final int numberOfDots;

  /// FontSize per dot character
  final double fontSize;

  /// Spacing between the dots
  final double dotSpacing;

  /// Color of the dot
  final Color color;

  final int milliseconds;
  final double beginTweenValue = 0.0;
  final double endTweenValue;

  JumpingDotsProgressIndicator(
      {this.numberOfDots = 3,
      this.fontSize = 10.0,
      this.color = const Color(0xff000000),
      this.dotSpacing = 0.0,
      this.milliseconds = 250})
      : endTweenValue = fontSize / 4;

  @override
  _JumpingDotsProgressIndicatorState createState() =>
      _JumpingDotsProgressIndicatorState();
}

class _JumpingDotsProgressIndicatorState
    extends State<JumpingDotsProgressIndicator> with TickerProviderStateMixin {
  final List<AnimationController> controllers = <AnimationController>[];
  final List<Animation<double>> animations = <Animation<double>>[];
  final List<Widget> _widgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.numberOfDots; i++) {
      _addAnimationControllers();
      _buildAnimations(i);
      _addListOfDots(i);
    }

    controllers[0].forward();
  }

  void _addAnimationControllers() {
    controllers.add(AnimationController(
        duration: Duration(milliseconds: widget.milliseconds), vsync: this));
  }

  void _addListOfDots(int index) {
    _widgets.add(Padding(
      padding: EdgeInsets.only(right: widget.dotSpacing),
      child: _JumpingDot(
        animation: animations[index],
        fontSize: widget.fontSize,
        color: widget.color,
      ),
    ));
  }

  void _buildAnimations(int index) {
    animations.add(
        Tween(begin: widget.beginTweenValue, end: widget.endTweenValue)
            .animate(controllers[index])
              ..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed)
                  controllers[index].reverse();
                if (index == widget.numberOfDots - 1 &&
                    status == AnimationStatus.dismissed) {
                  controllers[0].forward();
                }
                if (animations[index].value > widget.endTweenValue / 2 &&
                    index < widget.numberOfDots - 1) {
                  controllers[index + 1].forward();
                }
              }));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _widgets,
    );
  }

  @override
  void dispose() {
    for (var i = 0; i < widget.numberOfDots; i++) {
      controllers[i].dispose();
    }
    super.dispose();
  }
}
