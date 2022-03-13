import 'package:flutter/material.dart';

/// Slide animation types for SuggestionBox.
///
/// **[RTL] - Right to left.**
///
/// **[LTR] - Left to right.**
///
/// **[BTU] - Bottom to up.**
///
/// **[UTD] - Up to down.**
enum SlideStyle { RTL, LTR, BTU, UTD }

class FieldAnimationStyle {
  // Returns Animation Offset for suggestion box.
  static Animation<Offset>? setBoxAnimation({
    required SlideStyle slideStyle,
    required AnimationController animationController,
    required Tween<Offset>? slideTweenOffset,
    required Curve slideCurve,
  }) {
    // Tween offsets appropriate to [SlideAnimationStyle].
    final slideAnimationValues = <SlideStyle, Tween<Offset>>{
      SlideStyle.RTL: Tween<Offset>(begin: Offset(5, 0), end: Offset.zero),
      SlideStyle.LTR: Tween<Offset>(begin: Offset(-5, 0), end: Offset.zero),
      SlideStyle.BTU: Tween<Offset>(begin: Offset(0, 5), end: Offset.zero),
      SlideStyle.UTD: Tween<Offset>(begin: Offset(0, -5), end: Offset.zero),
    };

    late Tween<Offset> _offsetTween;
    if (slideTweenOffset != null) {
      _offsetTween = slideTweenOffset;
    } else {
      _offsetTween = slideAnimationValues[slideStyle]!;
    }

    return _offsetTween.animate(CurvedAnimation(
      parent: animationController,
      curve: slideCurve,
    ));
  }
}

/// Custom style object for [SuggestionBox].
///
/// **Use cases:**
/// ```dart
/// SuggestionBoxStyle.DefaultStyle
/// ```
///
/// **Or configure as the way you want:**
/// ```dart
/// SuggestionBoxStyle(
///  backgroundColor: Colors.white,
///  border: Border.all(color: Colors.red)
///  borderRadius: const BorderRadius.all(Radius.circular(10)),
///  ...
/// );
/// ```
class SuggestionBoxStyle {
  /// [backgroundColor] of `SuggestionBox`
  final Color backgroundColor;

  /// [border] of `SuggestionBox`
  final Border? border;

  /// [borderRadius] of `SuggestionBox`
  final BorderRadiusGeometry? borderRadius;

  /// [gradient] of `SuggestionBox`
  final Gradient? gradient;

  /// [boxShadow] of `SuggestionBox`
  final List<BoxShadow>? boxShadow;

  /// [padding] of `SuggestionBox`
  final EdgeInsetsGeometry? padding;

  /// [shape] of `SuggestionBox`.
  final BoxShape shape;

  const SuggestionBoxStyle({
    this.backgroundColor = Colors.transparent,
    this.border,
    this.borderRadius,
    this.gradient,
    this.boxShadow,
    this.padding,
    this.shape = BoxShape.rectangle,
  });

  // TODO: should listen current theme values.
  // and automatically generate style appropriate to theme.
  static const DefaultStyle = const SuggestionBoxStyle(
    backgroundColor: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    shape: BoxShape.rectangle,
    boxShadow: [
      BoxShadow(
        spreadRadius: 10,
        offset: Offset(0, 5),
        color: Color(0xFFA3A3A3),
        blurRadius: 10,
      )
    ],
  );
}

