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

// Takes a list which runtime type is List<DartClass>, user input and searchBy hint.
// Converts list's each item to json and creates matchers list.
List<dynamic> renderClassList(
    List<dynamic> suggestions, String input, List<String>? searchBy) {
  List<Map<String, dynamic>> _jsonModelList = [];
  List<dynamic> _matchers;

  suggestions.forEach((item) => _jsonModelList.add(item.toJson()));

  _matchers = _jsonModelList.where((el) {
    List<bool> trues = [];
    List<bool> falses = [];

    trues.clear();
    falses.clear();

    searchBy!.forEach((searchEl) {
      var val = el['$searchEl'].toUpperCase().contains(input.toUpperCase());

      val ? trues.add(val) : falses.add(val);
    });

    return trues.isNotEmpty;
  }).toList();

  return _matchers;
}

/// Detects class lists. If given list not matchs
/// no one which types [FieldSuggestion] support, that means the list is model class list. so [true].
/// If matchs then it would return [false].
bool isClassList(List list) {
  if (list is! List<String> && list is! List<int> && list is! List<double>) {
    return true;
  }
  return false;
}
