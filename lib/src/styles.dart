import 'package:flutter/material.dart';

/// Slide animation types for SuggestionBox.
/// It's just able to use when [wSlideAnimation] is [true].
///
/// **[RTL] - Right to left.**
///
/// **[LTR] - Left to right.**
///
/// **[BTU] - Bottom to up.**
///
/// **[UTD] - Up to down.**
enum SlideStyle { RTL, LTR, BTU, UTD }

// Helper class that basically used to choose/set/manage animations of `FieldSuggestion`.
class FieldAnimationStyle {
  // Returns Animation Offset for suggestion box.
  static Animation<Offset>? chooseBoxAnimation({
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

    Tween<Offset> _offsetTween;

    if (slideTweenOffset != null) {
      _offsetTween = slideTweenOffset;
    } else {
      _offsetTween = slideAnimationValues[slideStyle]!;
    }

    return _offsetTween.animate(
      CurvedAnimation(parent: animationController, curve: slideCurve),
    );
  }
}

/// Custom style class for [SuggestionBox].
///
/// **Use cases:**
/// ```dart
/// SuggestionBoxStyle.DefaultStyle
/// ```
/// **Or set as custom:**
/// ```dart
/// SuggestionBoxStyle(
///  backgroundColor: Colors.white,
///  border: Border.all(color: Colors.red)
///  borderRadius: const BorderRadius.all(Radius.circular(10)),
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

  /// The default style, wich is setted automatically.
  /// Includes just basic white theme design.
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

/// Custom style class for [SuggestionListItem].
/// **Use cases:**
/// ```dart
/// SuggestionItemStyle.DefaultStyle
/// SuggestionItemStyle.WhiteNeumorphismedStyle
/// SuggestionItemStyle.BlackNeumorphismedStyle
/// ```
/// **Or set as custom:**
/// ```dart
/// SuggestionItemStyle(
///  leading: const Icon(Icons.person)
///  backgroundColor: Colors.white,
///  icon: Icons.clear,
///  iconColor: Colors.red[700],
///  iconSize: 18,
///  titleStyle: TextStyle(color: Colors.purple),
///  borderRadius: const BorderRadius.all(Radius.circular(10)),
/// );
/// ```
class SuggestionItemStyle {
  /// [leading] widget for suggestion item.
  /// (Can be imagine as ListTile's leading.)
  final Widget? leading;

  /// [backgroundColor] of `SuggestionItem` card.
  final Color? backgroundColor;

  /// [titleStyle] of `SuggestionItem`'s title.
  final TextStyle? titleStyle;

  /// [border] of `SuggestionItem` card.
  final Border? border;

  /// [borderRadius] of `SuggestionItem` card.
  final BorderRadius? borderRadius;

  /// [gradient] of `SuggestionItem` card.
  final Gradient? gradient;

  /// [boxShadow] of `SuggestionItem` card.
  final List<BoxShadow>? boxShadow;

  /// [margin] of `SuggestionItem` card.
  final EdgeInsetsGeometry? margin;

  const SuggestionItemStyle({
    this.leading,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.titleStyle,
    this.border,
    this.borderRadius,
    this.gradient,
    this.boxShadow,
    this.margin,
  });

  /// The default style, wich is setted automatically.
  /// Includes just basic white theme design
  static const DefaultStyle = SuggestionItemStyle(
    backgroundColor: Colors.white,
    titleStyle: TextStyle(color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );
}
