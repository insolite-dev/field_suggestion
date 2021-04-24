import 'package:flutter/widgets.dart';

// Method to get right max height of Suggestion Box,
// By listening [wDivider] and [sizeByItem] properties.
double maxSuggestionBoxHeight({
  @required bool wDivider,
  @required int sizeByItem,
  @required List matchersList,
}) {
  double size;

  // Set size by listening [wDivider].
  size = (wDivider) ? 65 : 60;

  // Set size by listening [sizeByItem].
  if (sizeByItem != null) {
    if (sizeByItem == 1)
      return size;
    else
      return size * sizeByItem.roundToDouble();
  }

  // Set size by listening [matchersList].
  switch (matchersList.length) {
    case 1:
      return size;
    case 2:
      return size * 2.toDouble();
    case 3:
      return size * 3.toDouble();
      break;
    default:
      return size * 4.toDouble();
  }
}
