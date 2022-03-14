class Utils {
  // Generates acceptable max height for Suggestion Box.
  static double maxBoxHeight({
    required int? sizeByItem,
    required List matchersList,
  }) {
    final size = 60.0;

    // Set size by [matchersList].
    if (sizeByItem == null) return size * matchersList.length;

    // Set size by [sizeByItem].
    return (sizeByItem == 1) ? size : size * sizeByItem.roundToDouble();
  }
}
