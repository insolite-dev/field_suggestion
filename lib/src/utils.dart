// Method to get right max height for Suggestion Box
// by listening [wDivider] and [sizeByItem] properties.
double maxSuggestionBoxHeight({
  required bool wDivider,
  required int? sizeByItem,
  required List matchersList,
}) {
  double size = (wDivider) ? 65 : 60;

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

// It takes a list (which runtime type is List<DartClass>), user input and searchBy hints.
// Converts list's each item to json and creates matchers list.
List<dynamic> renderObjList(
    List<dynamic> suggestions, String input, List<String>? searchBy) {
  List<Map<String, dynamic>> _jsonModelList = [];
  List<dynamic> _matchers;

  suggestions.forEach((item) => _jsonModelList.add(item.toJson()));

  _matchers = _jsonModelList.where((el) {
    List<bool> matchedItems = [];
    matchedItems.clear();

    searchBy!.forEach((searchEl) {
      var val = el['$searchEl'].toUpperCase().contains(input.toUpperCase());

      if (val) matchedItems.add(val);
    });

    return matchedItems.isNotEmpty;
  }).toList();

  return _matchers;
}

/// Basically used to detect if selected item matchs with any suggested value.
/// The reason of making "isSelected" as model is we have to check values by "searchBy" properties.
bool isSelected(
    List<dynamic> suggestions, String input, List matchers, List searchBy) {
  int diff = 0;
  if (matchers.isEmpty) return false;

  if (isObjList(suggestions)) {
    searchBy.forEach((el) {
      if (matchers[0]['$el'].toString().toUpperCase() == input.toUpperCase())
        diff++;
    });
  } else {
    if (matchers[0].toString() == input) diff++;
  }

  return diff > 0;
}

/// Checks given list's runtimeType and returns result.
/// If given list's runtimeType isn't String, int or double list that means the list contains [Objects]. so [true].
/// If matchs then it would return [false].
bool isObjList(List list) {
  if (list is! List<String> && list is! List<int> && list is! List<double>) {
    return true;
  }
  return false;
}
