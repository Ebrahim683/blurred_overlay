import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The style of progress indicator to display.
enum ProgressStyle {
  /// Horizontal line progress bar.
  line,

  /// Circular progress indicator.
  circle,
}

/// A widget that displays a blurred loading overlay with progress percentage.
///
/// Shows either a line or circular progress indicator with percentage text.
/// When [isLoading] is true, the overlay is displayed.
///
/// Example:
/// ```dart
/// BlurredLoadingPercentage(
///   isLoading: _isLoading,
///   child: MyContent(),
///   progress: 45.5,  // 45.5% progress
///   progressStyle: ProgressStyle.circle,
///   progressColor: Colors.blue,
/// )
/// ```
class BlurredLoadingPercentage extends StatelessWidget {
  /// Creates a blurred loading percentage widget.
  const BlurredLoadingPercentage({
    super.key,
    required this.isLoading,
    required this.child,
    this.progress = 0.0,
    this.blurSigma = 4.0,
    this.backgroundColor,
    this.progressColor = Colors.blue,
    this.trackColor,
    this.strokeWidth = 8.0,
    this.textColor = Colors.white,
    this.textSize = 24.0,
    this.showProgress = true,
    this.progressStyle = ProgressStyle.circle,
    this.size = 120.0,
    this.headerWidget,
    this.footerWidget,
  });

  /// Whether to show the loading overlay.
  final bool isLoading;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The progress value from 0.0 to 100.0.
  ///
  /// For example, 45.5 means 45.5% complete.
  /// Default is 0.0.
  final double progress;

  /// The amount of blur to apply to the background.
  ///
  /// Default is 4.0.
  final double blurSigma;

  /// The background color of the overlay.
  ///
  /// Default is black with 50% opacity.
  final Color? backgroundColor;

  /// The color of the progress indicator.
  ///
  /// Default is [Colors.blue].
  final Color progressColor;

  /// The color of the track behind the progress.
  ///
  /// Default is white with 30% opacity.
  final Color? trackColor;

  /// The width of the stroke.
  ///
  /// Default is 8.0.
  final double strokeWidth;

  /// The color of the progress text.
  ///
  /// Default is [Colors.white].
  final Color textColor;

  /// The font size of the progress text.
  ///
  /// Default is 24.0.
  final double textSize;

  /// Whether to show the percentage text.
  ///
  /// Default is true.
  final bool showProgress;

  /// The style of progress indicator.
  ///
  /// Default is [ProgressStyle.circle].
  final ProgressStyle progressStyle;

  /// The size of the progress indicator.
  ///
  /// For circle: diameter. For line: width.
  /// Default is 120.0.
  final double size;

  /// An optional widget to display above the progress indicator.
  final Widget? headerWidget;

  /// An optional widget to display below the progress indicator.
  final Widget? footerWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        if (isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              color: backgroundColor ?? Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (headerWidget != null) ...[
                      headerWidget!,
                      const SizedBox(height: 24),
                    ],
                    progressStyle == ProgressStyle.line
                        ? _buildLineProgress(context)
                        : _buildCircleProgress(),
                    if (footerWidget != null) ...[
                      const SizedBox(height: 24),
                      footerWidget!,
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLineProgress(BuildContext context) {
    final effectiveTrackColor =
        trackColor ?? Colors.white.withValues(alpha: 0.3);
    final normalizedProgress = (progress / 100).clamp(0.0, 1.0);
    final screenWidth = MediaQuery.of(context).size.width;
    final lineWidth = screenWidth * 0.7; // 70% of screen width

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: lineWidth,
          height: strokeWidth + 8,
          decoration: BoxDecoration(
            color: effectiveTrackColor,
            borderRadius: BorderRadius.circular(strokeWidth),
          ),
          padding: const EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(strokeWidth),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: normalizedProgress,
                child: Container(
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(strokeWidth),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showProgress) ...[
          const SizedBox(height: 16),
          _buildProgressText(),
        ],
      ],
    );
  }

  Widget _buildCircleProgress() {
    final effectiveTrackColor =
        trackColor ?? Colors.white.withValues(alpha: 0.3);
    final normalizedProgress = (progress / 100).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Track circle
              CustomPaint(
                size: Size(size, size),
                painter: _CircleProgressPainter(
                  progress: 1.0,
                  color: effectiveTrackColor,
                  strokeWidth: strokeWidth,
                ),
              ),
              // Progress circle
              CustomPaint(
                size: Size(size, size),
                painter: _CircleProgressPainter(
                  progress: normalizedProgress,
                  color: progressColor,
                  strokeWidth: strokeWidth,
                ),
              ),
              // Percentage text
              if (showProgress) _buildProgressText(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressText() {
    final percent = progress.clamp(0.0, 100.0).toStringAsFixed(1);
    return Text(
      '$percent%',
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  _CircleProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw arc from top (-90 degrees)
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircleProgressPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth;
}
