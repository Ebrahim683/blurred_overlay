import 'dart:ui';

import 'package:flutter/material.dart';

import 'animations/loading_bouncing_line.dart';
import 'animations/loading_bouncing_grid.dart';
import 'animations/loading_bumping_line.dart';
import 'animations/loading_fading_line.dart';
import 'animations/loading_jumping_line.dart';
import 'animations/loading_rotating_shape.dart';
import 'animations/loading_flipping_shape.dart';
import 'animations/loading_double_flipping.dart';
import 'animations/loading_filling_shape.dart';
import 'animations/loading_cupertino_box.dart';
import 'animations/loading_pulse_ring.dart';
import 'animations/loading_orbit_dots.dart';
import 'animations/loading_breathing_circle.dart';

/// The style of loading animation to display.
enum LoadingStyle {
  /// Three circles bouncing smoothly with sine wave motion.
  bouncingLineCircle,

  /// Three squares bouncing smoothly with sine wave motion.
  bouncingLineSquare,

  /// 3x3 grid of circles with diagonal bounce effect.
  bouncingGridCircle,

  /// 3x3 grid of squares with diagonal bounce effect.
  bouncingGridSquare,

  /// Three circles with horizontal bump motion.
  bumpingLineCircle,

  /// Three squares with horizontal bump motion.
  bumpingLineSquare,

  /// Three circles with sequential fade effect.
  fadingLineCircle,

  /// Three squares with sequential fade effect.
  fadingLineSquare,

  /// Three circles jumping vertically.
  jumpingLineCircle,

  /// Three squares jumping vertically.
  jumpingLineSquare,

  /// Single square rotating 360 degrees.
  rotatingSquare,

  /// Single circle flipping horizontally 3 times.
  flippingCircle,

  /// Single square flipping horizontally 3 times.
  flippingSquare,

  /// Circle flipping on X then Y axis with 3D effect.
  doubleFlippingCircle,

  /// Square flipping on X then Y axis with 3D effect.
  doubleFlippingSquare,

  /// Square that fills and rotates while unfilling.
  fillingSquare,

  /// iOS-style spinner in a semi-transparent rounded box.
  /// Takes 50% of screen width as a square container.
  cupertinoBox,

  /// Concentric rings expanding outward with fading opacity.
  /// Creates a radar/ripple-like effect.
  pulseRing,

  /// Multiple dots orbiting around a center point like planets.
  /// Elegant spinning effect.
  orbitDots,

  /// Circle that smoothly expands and contracts like breathing.
  /// Calm and elegant loading indicator.
  breathingCircle,
}

/// A widget that displays a blurred loading overlay on top of its child.
///
/// When [isLoading] is true, a blur effect is applied to the background
/// and a loading animation is shown in the center.
///
/// Example:
/// ```dart
/// // Using default loading styles
/// BlurredLoadingOverlay(
///   isLoading: _isLoading,
///   child: MyContent(),
///   loadingStyle: LoadingStyle.bouncingLineCircle,
/// )
///
/// // Using custom loading widget
/// BlurredLoadingOverlay(
///   isLoading: _isLoading,
///   child: MyContent(),
///   customLoadingWidget: CircularProgressIndicator(),
/// )
/// ```
class BlurredLoadingOverlay extends StatelessWidget {
  /// Creates a blurred loading overlay widget.
  const BlurredLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingStyle = LoadingStyle.cupertinoBox,
    this.customLoadingWidget,
    this.blurSigma = 4.0,
    this.backgroundColor,
    this.loadingColor,
    this.loadingSize = 50.0,
    this.headerWidget,
    this.footerWidget,
  });

  /// Whether to show the loading overlay.
  final bool isLoading;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The style of loading animation to display.
  ///
  /// Default is [LoadingStyle.cupertinoBox].
  /// Ignored if [customLoadingWidget] is provided.
  final LoadingStyle loadingStyle;

  /// A custom widget to display as the loading indicator.
  ///
  /// When provided, this overrides [loadingStyle], [loadingColor], and [loadingSize].
  final Widget? customLoadingWidget;

  /// The amount of blur to apply to the background.
  ///
  /// Default is 4.0.
  final double blurSigma;

  /// The background color of the overlay.
  ///
  /// Default is transparent.
  final Color? backgroundColor;

  /// The color of the loading animation.
  ///
  /// Default depends on the loading style.
  /// Ignored if [customLoadingWidget] is provided.
  final Color? loadingColor;

  /// The size of the loading animation.
  ///
  /// Default is 50.0.
  /// Ignored if [customLoadingWidget] is provided.
  final double loadingSize;

  /// An optional widget to display above the loading animation.
  final Widget? headerWidget;

  /// An optional widget to display below the loading animation.
  final Widget? footerWidget;

  Widget _buildLoadingWidget(BuildContext context) {
    final color = loadingColor ?? Colors.blue;
    final borderColor = loadingColor ?? Colors.blueGrey;

    switch (loadingStyle) {
      case LoadingStyle.bouncingLineCircle:
        return LoadingBouncingLine.circle(
          backgroundColor: color,
          borderColor: color,
          size: loadingSize,
        );
      case LoadingStyle.bouncingLineSquare:
        return LoadingBouncingLine.square(
          backgroundColor: color,
          borderColor: color,
          size: loadingSize,
        );
      case LoadingStyle.bouncingGridCircle:
        return LoadingBouncingGrid.circle(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.bouncingGridSquare:
        return LoadingBouncingGrid.square(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.bumpingLineCircle:
        return LoadingBumpingLine.circle(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.bumpingLineSquare:
        return LoadingBumpingLine.square(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.fadingLineCircle:
        return LoadingFadingLine.circle(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.fadingLineSquare:
        return LoadingFadingLine.square(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.jumpingLineCircle:
        return LoadingJumpingLine.circle(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.jumpingLineSquare:
        return LoadingJumpingLine.square(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.rotatingSquare:
        return LoadingRotating.square(
          borderColor: borderColor,
          size: loadingSize,
        );
      case LoadingStyle.flippingCircle:
        return LoadingFlipping.circle(
          borderColor: borderColor,
          size: loadingSize,
        );
      case LoadingStyle.flippingSquare:
        return LoadingFlipping.square(
          borderColor: borderColor,
          size: loadingSize,
        );
      case LoadingStyle.doubleFlippingCircle:
        return LoadingDoubleFlipping.circle(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.doubleFlippingSquare:
        return LoadingDoubleFlipping.square(
          backgroundColor: color,
          size: loadingSize,
        );
      case LoadingStyle.fillingSquare:
        return LoadingFilling.square(
          borderColor: borderColor,
          fillingColor: color,
          size: loadingSize,
        );
      case LoadingStyle.cupertinoBox:
        return const LoadingCupertinoBox();
      case LoadingStyle.pulseRing:
        return LoadingPulseRing(
          color: color,
          size: loadingSize,
        );
      case LoadingStyle.orbitDots:
        return LoadingOrbitDots(
          color: color,
          size: loadingSize,
        );
      case LoadingStyle.breathingCircle:
        return LoadingBreathingCircle(
          color: color,
          size: loadingSize,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Visibility(
          visible: isLoading,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              color: backgroundColor ?? Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (headerWidget != null) headerWidget!,
                  if (headerWidget != null) const SizedBox(height: 20),
                  Center(child: customLoadingWidget ?? _buildLoadingWidget(context)),
                  if (footerWidget != null) const SizedBox(height: 20),
                  if (footerWidget != null) footerWidget!,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
