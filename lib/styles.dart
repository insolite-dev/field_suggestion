import 'package:flutter/material.dart';

/// Slide animation types of SuggestionBox.
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

/// Custom style class for [SuggestionBox].
///
/// Uses ─▶ [BoxStyle.default(context)] as default.
/// Which listens to theme context, and fills values by it.
///
/// Or use custom one
/// to configure as the way you want:
/// ```dart
/// BoxStyle(
///  backgroundColor: Colors.white,
///  border: Border.all(color: Colors.red)
///  borderRadius: const BorderRadius.all(Radius.circular(10)),
///  ...
/// )
/// ```
class BoxStyle {
  /// [backgroundColor] of `SuggestionBox`
  ///
  /// As default its ─▶ [Colors.transparent].
  final Color backgroundColor;

  /// [border] of `SuggestionBox`
  final Border? border;

  /// [borderRadius] of `SuggestionBox`
  final BorderRadiusGeometry? borderRadius;

  /// [gradient] of `SuggestionBox`
  final Gradient? gradient;

  /// [boxShadow] of `SuggestionBox`
  final List<BoxShadow>? boxShadow;

  /// [shape] of `SuggestionBox`.
  ///
  /// As default its ─▶ [BoxShape.rectangle].
  final BoxShape shape;

  const BoxStyle({
    this.backgroundColor = Colors.transparent,
    this.border,
    this.borderRadius,
    this.gradient,
    this.boxShadow,
    this.shape = BoxShape.rectangle,
  });

  /// Generate a minimalist box style theme,
  /// appropriate to context's theme.
  static BoxStyle defaultStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BoxStyle(
      backgroundColor: theme.cardColor,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      boxShadow: [
        BoxShadow(
          spreadRadius: 12.5,
          offset: Offset(0, 5),
          color: theme.shadowColor,
          blurRadius: 12.5,
        )
      ],
    );
  }
}
