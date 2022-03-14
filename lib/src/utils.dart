class Utils {
  // Generates acceptable max height for Suggestion Box.
  static double maxBoxHeight({
    required int? sizeByItem,
    required List matchersList,
  }) {
    final size = 60.0;

    // Set size by [sizeByItem].
    if (sizeByItem != null) {
      return (sizeByItem == 1) ? size : size * sizeByItem.roundToDouble();
    }

    // Set size by [matchersList].
    return size * matchersList.length;
  }
}
