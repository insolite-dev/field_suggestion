// Method to get right max height for Suggestion Box,
// by listening [wDivider] and [sizeByItem] properties.
double maxSuggestionBoxHeight({
  required bool wDivider,
  required int? sizeByItem,
  required List matchersList,
}) {
  double size;

  // Set size by listening [wDivider].
  size = (wDivider) ? 65 : 60;

  // Set size by listening [sizeByItem].
  if (sizeByItem != null) {
    return (sizeByItem == 1) ? size : size * sizeByItem.roundToDouble();
  }

  // Set size by listening [matchersList].
  switch (matchersList.length) {
    case 1:
      return size;
    case 2:
      return size * 2.toDouble();
    case 3:
      return size * 3.toDouble();
    default:
      return size * 4.toDouble();
  }
}
