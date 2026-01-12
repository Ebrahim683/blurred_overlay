import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Creates a loading animation with iOS-style spinner in a rounded box.
///
/// The box takes 50% of screen width as a square container with
/// semi-transparent black background and rounded corners.
///
/// Example:
/// ```dart
/// LoadingCupertinoBox(
///   boxColor: Colors.black54,
///   spinnerColor: Colors.white,
/// )
/// ```
class LoadingCupertinoBox extends StatelessWidget {
  /// Creates the LoadingCupertinoBox animation.
  const LoadingCupertinoBox({
    super.key,
    this.boxColor,
    this.spinnerColor = Colors.white,
    this.borderRadius = 16.0,
    this.spinnerSize = 50.0,
  });

  /// The background color of the box.
  ///
  /// Default is black with 70% opacity.
  final Color? boxColor;

  /// The color of the Cupertino spinner.
  ///
  /// Default is [Colors.white].
  final Color spinnerColor;

  /// The border radius of the box.
  ///
  /// Default is 16.0.
  final double borderRadius;

  /// The size of the spinner.
  ///
  /// Default is 50.0.
  final double spinnerSize;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxSize = screenWidth * 0.5; // 50% of screen width

    return Center(
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: boxColor ?? Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: CupertinoActivityIndicator(
            radius: spinnerSize / 2,
            color: spinnerColor,
          ),
        ),
      ),
    );
  }
}
