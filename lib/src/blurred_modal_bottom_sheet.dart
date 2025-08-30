import 'dart:ui';
import 'package:flutter/material.dart';

/// Shows a modal bottom sheet with a blurred background and customizable UI.
Future<T?> showBlurredModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  double blurSigma = 4.0,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useSafeArea = true,
  BorderRadius? borderRadius,
  double? minHeight,
  double? maxHeight,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  Color? backgroundColor,
  Color? barrierColor,
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
    enableDrag: enableDrag,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    barrierColor: barrierColor ?? Colors.white.withOpacity(0.0),
    builder: (context) {
      final mediaQuery = MediaQuery.of(context);
      final defaultMaxHeight = maxHeight ?? mediaQuery.size.height * 0.9;
      
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: GestureDetector(
          onTap: isDismissible ? () => Navigator.of(context).pop() : null,
          behavior: HitTestBehavior.translucent,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {}, // Prevent tap from bubbling up
              child: Container(
                margin: margin ?? const EdgeInsets.symmetric(horizontal: 10),
                constraints: BoxConstraints(
                  minHeight: minHeight ?? 0,
                  maxHeight: defaultMaxHeight,
                  maxWidth: mediaQuery.size.width - ((margin?.horizontal ?? 20)),
                ),
                decoration: BoxDecoration(
                  color: backgroundColor ?? Theme.of(context).bottomSheetTheme.backgroundColor ?? Colors.white,
                  borderRadius: borderRadius ?? const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: -2,
                      offset: const Offset(0, -4),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: -2,
                      offset: const Offset(-4, 0),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: -2,
                      offset: const Offset(4, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showHandle) ...[
                      Container(
                        width: handleWidth ?? 40,
                        height: handleHeight ?? 4,
                        margin: handleMargin ?? const EdgeInsets.only(top: 12.0, bottom: 8.0),
                        decoration: BoxDecoration(
                          color: handleColor ?? Colors.grey[400],
                          borderRadius: handleRadius ?? BorderRadius.circular(10),
                        ),
                      ),
                    ],
                    Flexible(
                      child: Container(
                        padding: padding ?? const EdgeInsets.all(16),
                        child: useSafeArea
                            ? SafeArea(
                                top: false,
                                child: builder(context),
                              )
                            : builder(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}