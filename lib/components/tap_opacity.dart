import 'dart:async';
import 'package:flutter/widgets.dart';

class TapOpacity extends StatefulWidget {
  TapOpacity(
      {@required this.onTap,
      @required this.child,
      this.disabled = false,
      this.opacity = 1,
      this.tapOpacity = 0.5,
      this.duration = const Duration(milliseconds: 300),
      this.curve = Curves.easeInOut});

  final Widget child;
  final GestureTapCallback onTap;
  final Curve curve;
  final double opacity;
  final double tapOpacity;
  final Duration duration;
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _TapOpacityState();
}

class _TapOpacityState extends State<TapOpacity>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _opacity;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, value: 1, lowerBound: 0, upperBound: 1);
    _opacity = Tween<double>(begin: widget.tapOpacity, end: widget.opacity)
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: !widget.disabled ? widget.onTap : null,
      onTapDown: (_) => _animateTapDown(),
      onTapUp: (_) => _animateTapUp(),
      onTapCancel: () => _animateTapUp(),
      child: _AnimatedTapOpacity(
        animation: _opacity,
        child: widget.child,
      ));

  _animateTapDown() {
    _controller.duration = Duration(milliseconds: 50);
    _controller.reverse();
  }

  _animateTapUp() {
    _controller.duration = widget.duration;
    if (_controller.status != AnimationStatus.completed) {
      Timer(Duration(milliseconds: 200), () {
        _controller.forward();
      });
    } else {
      _controller.forward();
    }
  }
}

class _AnimatedTapOpacity extends AnimatedWidget {
  _AnimatedTapOpacity({Key key, this.animation, this.child})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: child,
    );
  }
}
