import 'package:flutter/material.dart';

class Utils {
  // Generates acceptable max height for Suggestion Box.
  static double maxBoxHeight({
    required int? sizeByItem,
    required int matchers,
    required double? maxBoxHeight,
  }) {
    if (maxBoxHeight != null) return maxBoxHeight;
    if (sizeByItem != null) return 60.0 * sizeByItem;
    return 60.0 * ((matchers > 3) ? 4 : matchers);
  }
}

// A dynamic BoxSize widget that implements multiple sizing styles:
// - BoxConstraints
// - IntrinsicHeight
class BoxSizer extends StatelessWidget {
  final Widget child;
  final bool intrinsicHeight;
  final BoxConstraints constraints;

  const BoxSizer({
    Key? key,
    required this.child,
    this.intrinsicHeight = false,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      child: child,
      constraints: !intrinsicHeight
          ? constraints
          : BoxConstraints(maxWidth: constraints.maxWidth),
    );
  }
}
