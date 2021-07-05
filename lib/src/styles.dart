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
enum SlideAnimationStyle { RTL, LTR, BTU, UTD }

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

  /// [margin] of `SuggestionBox`
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

  /// [subtitleStyle] of `SuggestionItem`'s title.
  final TextStyle? subtitleStyle;

  /// [icon] of `SuggestionItem` which .
  final IconData icon;
  final double? iconSize;
  final Color iconColor;

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
    this.subtitleStyle,
    this.icon = Icons.clear,
    this.iconSize,
    this.iconColor = Colors.red,
    this.border,
    this.borderRadius,
    this.gradient,
    this.boxShadow,
    this.margin,
  });

  /// The default style, wich is setted automatically.
  /// Includes just basic white theme design
  static const DefaultStyle = const SuggestionItemStyle(
    backgroundColor: Colors.white,
    icon: Icons.clear,
    iconColor: Colors.red,
    iconSize: 20,
    titleStyle: TextStyle(color: Colors.black),
    subtitleStyle: TextStyle(color: Colors.black45),
    borderRadius: const BorderRadius.all(Radius.circular(5)),
  );

  /// The Custom White Neumorphism style of `SuggestionItemStyle`.
  static const WhiteNeumorphismedStyle = const SuggestionItemStyle(
    margin: const EdgeInsetsDirectional.only(start: 1, end: 1, top: 1),
    backgroundColor: Colors.white,
    icon: Icons.clear,
    iconColor: Colors.red,
    iconSize: 20,
    titleStyle: TextStyle(color: Colors.black),
    subtitleStyle: TextStyle(color: Colors.black45),
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      BoxShadow(
        blurRadius: 1,
        spreadRadius: 1,
        offset: Offset(0, 2),
        color: Color(0xffD5D5D5),
      ),
    ],
  );

  /// The Custom Black Neumorphism style of `SuggestionItemStyle`.
  static const BlackNeumorphismedStyle = const SuggestionItemStyle(
    margin: const EdgeInsetsDirectional.only(start: 1, end: 1, top: 1),
    backgroundColor: Color(0xFF0E0E0E),
    icon: Icons.clear,
    iconColor: Colors.red,
    iconSize: 20,
    titleStyle: TextStyle(color: Colors.white),
    subtitleStyle: TextStyle(color: Colors.white60),
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      BoxShadow(
        blurRadius: 1,
        spreadRadius: 1,
        offset: Offset(0, 2),
        color: Color(0xFF2E2E2E),
      ),
    ],
  );
}
