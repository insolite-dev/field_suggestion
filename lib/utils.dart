class Utils {
  // Generates acceptable max height for Suggestion Box.
  static double maxBoxHeight({
    required int? sizeByItem,
    required int matchers,
  }) {
    final size = 60.0;

    // Set size by [sizeByItem].
    if (sizeByItem != null) return size * sizeByItem;

    // Set size by [matchers].
    return size * ((matchers > 3) ? 4 : matchers);
  }
}
