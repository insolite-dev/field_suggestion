// Gets right max height for Suggestion Box
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

  final sizesByMatchers = {
    1: size,
    2: size * 2.0,
    3: size * 3.0,
    4: size * 4.0,
  };

  // Set size by listening [matchersList].
  return sizesByMatchers[matchersList.length] ?? sizesByMatchers[4]!;
}

// It takes a list (which runtime type is List<Object>), user input, searchBy hints and customSearch function.
// Converts list's each item to json and creates matchers list.
List<dynamic> renderObjList(
  List<dynamic> suggestions,
  String input, {
  List<String>? searchBy,
  bool Function(dynamic, String)? customSearch,
}) {
  List<Map<String, dynamic>> _jsonModelList = [];
  List<dynamic> _matchers;

  suggestions.forEach((item) => _jsonModelList.add(item.toJson()));

  _matchers = _jsonModelList.where((el) {
    List<bool> matchedItems = [];
    matchedItems.clear();

    // Parse by [customSearch].
    if (customSearch != null) {
      final res = customSearch(suggestions[_jsonModelList.indexOf(el)], input);
      if (res) matchedItems.add(res);
    } else {
      // Parse by default contains method.
      for (var searchEl in searchBy!) {
        final res = el['$searchEl'].toUpperCase().contains(input.toUpperCase());
        if (res) matchedItems.add(res);
      }
    }

    return matchedItems.isNotEmpty;
  }).toList();

  return _matchers;
}

/// Basically used to detect if selected item matchs with any suggested value.
/// The reason of making "isSelected" as model is we have to check values by "searchBy" properties.
bool isSelected([
  List<dynamic>? suggestions,
  String? input,
  List? matchers,
  List? searchBy,
]) {
  int diff = 0;
  if (matchers!.isEmpty) return false;

  if (!isObjList(suggestions!)) {
    if (matchers[0].toString() == input) diff++;
  } else {
    for (var el in searchBy!) {
      if (matchers[0]['$el'].toString().toUpperCase() == input!.toUpperCase()) {
        diff++;
      }
    }
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
