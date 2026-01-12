import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Creates a loading animation with dots orbiting around a center point.
///
/// Multiple dots rotate around a central point like planets orbiting the sun,
/// creating an elegant spinning effect.
///
/// Example:
/// ```dart
/// LoadingOrbitDots(
///   color: Colors.blue,
///   size: 60.0,
/// )
/// ```
class LoadingOrbitDots extends StatefulWidget {
  /// Creates the LoadingOrbitDots animation.
  const LoadingOrbitDots({
    super.key,
    this.controller,
    this.color = Colors.blue,
    this.size = 60.0,
    this.dotCount = 5,
    this.dotSize = 10.0,
    this.duration = const Duration(milliseconds: 1500),
  });

  /// Sets an [AnimationController] in case you need to do something
  /// specific with it like play/pause animation.
  final AnimationController? controller;

  /// The color of the dots.
  ///
  /// Default is [Colors.blue].
  final Color color;

  /// Size of the animation (orbit diameter).
  ///
  /// Default is 60.0.
  final double size;

  /// Number of orbiting dots.
  ///
  /// Default is 5.
  final int dotCount;

  /// Size of each dot.
  ///
  /// Default is 10.0.
  final double dotSize;

  /// Total duration for one full orbit.
  ///
  /// Default is 1500 milliseconds.
  final Duration duration;

  @override
  State<LoadingOrbitDots> createState() => _LoadingOrbitDotsState();
}

class _LoadingOrbitDotsState extends State<LoadingOrbitDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(vsync: this, duration: widget.duration);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size + widget.dotSize,
      height: widget.size + widget.dotSize,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.size + widget.dotSize, widget.size + widget.dotSize),
            painter: _OrbitDotsPainter(
              progress: _controller.value,
              color: widget.color,
              dotCount: widget.dotCount,
              dotSize: widget.dotSize,
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

class _OrbitDotsPainter extends CustomPainter {
  _OrbitDotsPainter({
    required this.progress,
    required this.color,
    required this.dotCount,
    required this.dotSize,
  });

  final double progress;
  final Color color;
  final int dotCount;
  final double dotSize;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - dotSize) / 2;

    for (int i = 0; i < dotCount; i++) {
      final angle = (2 * math.pi * progress) + (2 * math.pi * i / dotCount);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      // Dots get smaller and more transparent towards the tail
      final scale = 1.0 - (i / dotCount) * 0.5;
      final opacity = 1.0 - (i / dotCount) * 0.7;

      final paint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), (dotSize / 2) * scale, paint);
    }
  }

  @override
  bool shouldRepaint(_OrbitDotsPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
