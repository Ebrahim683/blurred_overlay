import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Creates a loading animation with a circle that expands and contracts.
///
/// A smooth breathing effect where the circle grows and shrinks
/// continuously, creating a calm and elegant loading indicator.
///
/// Example:
/// ```dart
/// LoadingBreathingCircle(
///   color: Colors.blue,
///   size: 60.0,
/// )
/// ```
class LoadingBreathingCircle extends StatefulWidget {
  /// Creates the LoadingBreathingCircle animation.
  const LoadingBreathingCircle({
    super.key,
    this.controller,
    this.color = Colors.blue,
    this.size = 60.0,
    this.minScale = 0.5,
    this.duration = const Duration(milliseconds: 1500),
  });

  /// Sets an [AnimationController] in case you need to do something
  /// specific with it like play/pause animation.
  final AnimationController? controller;

  /// The color of the circle.
  ///
  /// Default is [Colors.blue].
  final Color color;

  /// Maximum size of the circle.
  ///
  /// Default is 60.0.
  final double size;

  /// Minimum scale of the circle (0.0 to 1.0).
  ///
  /// Default is 0.5 (circle shrinks to 50% of size).
  final double minScale;

  /// Total duration for one breath cycle (expand + contract).
  ///
  /// Default is 1500 milliseconds.
  final Duration duration;

  @override
  State<LoadingBreathingCircle> createState() => _LoadingBreathingCircleState();
}

class _LoadingBreathingCircleState extends State<LoadingBreathingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Use sine wave for smooth breathing effect
          final breathValue = (math.sin(_animation.value) + 1) / 2;
          final scale = widget.minScale + (1 - widget.minScale) * breathValue;
          final opacity = 0.5 + 0.5 * breathValue;

          return Center(
            child: Transform.scale(
              scale: scale,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: opacity),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
