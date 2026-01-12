import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Creates a loading animation that flips horizontally 3 times.
///
/// Example:
/// ```dart
/// LoadingFlipping.circle(
///   borderColor: Colors.blueGrey,
///   size: 50.0,
/// )
/// ```
class LoadingFlipping extends ProgressIndicator {
  /// Sets an [AnimationController] in case you need to do something
  /// specific with it like play/pause animation.
  final AnimationController? controller;

  final BoxShape _shape;

  /// The color of the shape itself.
  ///
  /// Default color is set to [Colors.transparent].
  @override
  final Color backgroundColor;

  /// The color of the border of the shape.
  ///
  /// Default color is set to [Colors.blueGrey].
  final Color borderColor;

  /// Size of the whole square containing the animation.
  ///
  /// Default size is set to [50.0].
  final double size;

  /// Size of the border of the shape.
  ///
  /// Default size is set to [size/8].
  final double? borderSize;

  /// Total duration for one cycle of animation.
  ///
  /// Default value is set to [Duration(milliseconds: 1500)].
  final Duration duration;

  /// Sets an [IndexedWidgetBuilder] function to return
  /// your own customized widget.
  final IndexedWidgetBuilder? itemBuilder;

  /// Creates the LoadingFlipping animation with a circle shape.
  const LoadingFlipping.circle({
    super.key,
    this.controller,
    this.borderColor = Colors.blueGrey,
    this.backgroundColor = Colors.transparent,
    this.size = 50.0,
    this.borderSize,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1500),
  }) : _shape = BoxShape.circle;

  /// Creates the LoadingFlipping animation with a square shape.
  const LoadingFlipping.square({
    super.key,
    this.controller,
    this.borderColor = Colors.blueGrey,
    this.backgroundColor = Colors.transparent,
    this.size = 50.0,
    this.borderSize,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1500),
  }) : _shape = BoxShape.rectangle;

  @override
  State<LoadingFlipping> createState() => _LoadingFlippingState();
}

class _LoadingFlippingState extends State<LoadingFlipping>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    _animation = CurveTween(curve: Curves.easeInOut).animate(_controller)
      ..addListener(() => setState(() {}));

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final transform = Matrix4.identity()
      ..setEntry(3, 2, widget._shape == BoxShape.circle ? 0.002 : 0.005)
      ..rotateY(_animation.value * 3 * -math.pi);

    return Center(
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: SizedBox.fromSize(
          size: Size.square(widget.size),
          child: _itemBuilder(0),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) {
    return widget.itemBuilder != null
        ? widget.itemBuilder!(context, index)
        : DecoratedBox(
            decoration: BoxDecoration(
              shape: widget._shape,
              color: widget.backgroundColor,
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderSize ?? widget.size / 8,
              ),
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
