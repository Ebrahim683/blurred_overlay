import 'dart:ui';
import 'package:flutter/material.dart';

/// Position of the drawer (left or right side of the screen)
enum DrawerPosition {
  /// Left side drawer (default)
  left,

  /// Right side drawer
  right,
}

/// A drawer widget with a blurred background effect.
///
/// This widget can be used in [Scaffold.drawer] or [Scaffold.endDrawer]
/// to create a drawer with a beautiful blur effect on the background.
///
/// Example:
/// ```dart
/// Scaffold(
///   drawer: BlurredDrawer(
///     child: ListView(
///       children: [
///         DrawerHeader(child: Text('Header')),
///         ListTile(title: Text('Item 1')),
///       ],
///     ),
///   ),
/// )
/// ```
class BlurredDrawer extends StatelessWidget {
  /// The widget below this widget in the tree (drawer content).
  final Widget child;

  /// The amount of blur to apply to the background.
  /// Default is 4.0.
  final double blurSigma;

  /// The width of the drawer.
  /// Default is 304.0 (Material Design standard).
  final double? width;

  /// The background color of the drawer.
  /// If null, uses [Theme.of(context).drawerTheme.backgroundColor] or defaults to surface color.
  final Color? backgroundColor;

  /// The elevation of the drawer.
  /// Default is 16.0 (Material Design standard).
  final double elevation;

  /// The color of the shadow cast by the drawer.
  final Color? shadowColor;

  /// The border radius for the drawer's edge (the side that opens from).
  /// Only applies to the open edge (right side for left drawer, left side for right drawer).
  final BorderRadiusGeometry? borderRadius;

  /// The position of the drawer (left or right).
  /// Default is [DrawerPosition.left].
  final DrawerPosition position;

  /// Creates a blurred drawer.
  const BlurredDrawer({
    super.key,
    required this.child,
    this.blurSigma = 4.0,
    this.width,
    this.backgroundColor,
    this.elevation = 16.0,
    this.shadowColor,
    this.borderRadius,
    this.position = DrawerPosition.left,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final drawerTheme = theme.drawerTheme;
    final defaultWidth = width ?? 304.0;

    // Determine background color with fallbacks
    final effectiveBackgroundColor = backgroundColor ??
        drawerTheme.backgroundColor ??
        theme.colorScheme.surface;

    // Determine shadow color
    final effectiveShadowColor =
        shadowColor ?? Colors.black.withValues(alpha: 0.2);

    // Border radius - only apply to the open edge
    final effectiveBorderRadius = borderRadius ??
        (position == DrawerPosition.left
            ? const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ));

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: Align(
        alignment: position == DrawerPosition.left
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          width: defaultWidth,
          height: double.infinity,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: effectiveBorderRadius,
            boxShadow: [
              BoxShadow(
                color: effectiveShadowColor,
                blurRadius: elevation,
                spreadRadius: 0,
                offset: position == DrawerPosition.left
                    ? const Offset(2, 0)
                    : const Offset(-2, 0),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
