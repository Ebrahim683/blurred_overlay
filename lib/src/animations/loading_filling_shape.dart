import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Creates a loading animation that fills a shape
/// then rotates 360 degrees clockwise unfilling the shape.
///
/// Example:
/// ```dart
/// LoadingFilling.square(
///   borderColor: Colors.blueGrey,
///   fillingColor: Colors.blueGrey,
///   size: 50.0,
/// )
/// ```
class LoadingFilling extends ProgressIndicator {
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

  /// The color of the filling of the shape.
  ///
  /// Default color is set to [Colors.blueGrey].
  final Color fillingColor;

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
  /// Default value is set to [Duration(milliseconds: 3000)].
  final Duration duration;

  /// Sets an [IndexedWidgetBuilder] function to return
  /// your own customized widget.
  final IndexedWidgetBuilder? itemBuilder;

  /// Creates the LoadingFilling animation with a square shape.
  const LoadingFilling.square({
    super.key,
    this.controller,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.blueGrey,
    this.fillingColor = Colors.blueGrey,
    this.size = 50.0,
    this.borderSize,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 3000),
  }) : _shape = BoxShape.rectangle;

  @override
  State<LoadingFilling> createState() => _LoadingFillingState();
}

class _LoadingFillingState extends State<LoadingFilling>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    _animation1 = CurveTween(curve: Curves.ease).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0),
      ),
    )..addListener(() => setState(() {}));

    _animation2 = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    )..addListener(() => setState(() {}));

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final transform = Matrix4.rotationZ(_animation1.value * math.pi * 2.0);

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
        : Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              // Fill shape
              Positioned(
                height: (1 - _animation2.value.abs()) * widget.size,
                width: widget.size,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: widget._shape,
                    color: widget.fillingColor,
                  ),
                ),
              ),
              // Border shape
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: widget._shape,
                  color: widget.backgroundColor,
                  border: Border.all(
                    color: widget.borderColor,
                    width: widget.borderSize ?? widget.size / 8,
                  ),
                ),
              ),
            ],
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
