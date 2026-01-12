import 'package:flutter/material.dart';

/// Creates a loading animation with concentric rings expanding outward.
///
/// Multiple rings pulse outward from the center with fading opacity,
/// creating a radar/ripple-like effect.
///
/// Example:
/// ```dart
/// LoadingPulseRing(
///   color: Colors.blue,
///   size: 80.0,
/// )
/// ```
class LoadingPulseRing extends StatefulWidget {
  /// Creates the LoadingPulseRing animation.
  const LoadingPulseRing({
    super.key,
    this.controller,
    this.color = Colors.blue,
    this.size = 80.0,
    this.strokeWidth = 3.0,
    this.ringCount = 3,
    this.duration = const Duration(milliseconds: 1500),
  });

  /// Sets an [AnimationController] in case you need to do something
  /// specific with it like play/pause animation.
  final AnimationController? controller;

  /// The color of the rings.
  ///
  /// Default is [Colors.blue].
  final Color color;

  /// Size of the animation.
  ///
  /// Default is 80.0.
  final double size;

  /// The stroke width of the rings.
  ///
  /// Default is 3.0.
  final double strokeWidth;

  /// Number of rings to display.
  ///
  /// Default is 3.
  final int ringCount;

  /// Total duration for one cycle of animation.
  ///
  /// Default is 1500 milliseconds.
  final Duration duration;

  @override
  State<LoadingPulseRing> createState() => _LoadingPulseRingState();
}

class _LoadingPulseRingState extends State<LoadingPulseRing>
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
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _PulseRingPainter(
              progress: _controller.value,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
              ringCount: widget.ringCount,
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

class _PulseRingPainter extends CustomPainter {
  _PulseRingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.ringCount,
  });

  final double progress;
  final Color color;
  final double strokeWidth;
  final int ringCount;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    for (int i = 0; i < ringCount; i++) {
      final ringProgress = (progress + (i / ringCount)) % 1.0;
      final radius = maxRadius * ringProgress;
      final opacity = (1.0 - ringProgress).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(_PulseRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
