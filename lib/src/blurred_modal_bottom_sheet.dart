import 'dart:ui';
import 'package:flutter/material.dart';

/// Shows a modal bottom sheet with a blurred background and customizable UI.
Future<T?> showBlurredModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  double blurSigma = 4.0,
  bool isDismissible = true,
  BorderRadius? borderRadius,
  double? minHeight,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  bool showHandle = false,
  EdgeInsetsGeometry? handleMargin,
  BorderRadiusGeometry? handleRadius,
  Color? handleColor,
  double? handleHeight,
  double? handleWidth,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: isDismissible ? () => Navigator.of(context).pop() : null,
            child: Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: margin ?? EdgeInsets.all(10),
              padding: margin ?? EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width,
              constraints: BoxConstraints(
                minHeight: minHeight ?? 100,
                maxHeight: MediaQuery.sizeOf(context).height * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius ?? BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: showHandle,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: handleWidth ?? 40,
                            height: handleHeight ?? 5,
                            margin: handleMargin ??
                                const EdgeInsets.only(bottom: 12.0),
                            decoration: BoxDecoration(
                              color: handleColor ?? Colors.grey[600],
                              borderRadius:
                                  handleRadius ?? BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      builder(context),
                    ],
                  )),
            ),
          ),
        ],
      );
    },
  );
}
