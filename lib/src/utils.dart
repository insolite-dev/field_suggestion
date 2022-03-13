class Utils {
  // Generates acceptable max height for Suggestion Box.
  static double maxBoxHeight({
    required bool wDivider,
    required int? sizeByItem,
    required List matchersList,
  }) {
    final double size = (wDivider) ? 65 : 60;

    // Set size by [sizeByItem].
    if (sizeByItem != null) {
      return (sizeByItem == 1) ? size : size * sizeByItem.roundToDouble();
    }

    // Set size by [matchersList].
    return size * matchersList.length;
  }
}
