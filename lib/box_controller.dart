/// A controller for [FieldSuggestion]'s box.
/// Could be used to [open] or [close] suggestions' box,
/// and even to [refresh] content of active suggestion box.
class BoxController {
  /// Opens(activates) a suggestion box.
  void Function()? open;

  /// Closes active suggestion box.
  ///
  /// If it's not active, nothing will happen.
  void Function()? close;

  /// Refreshes content of active suggestion box.
  ///
  /// If it's not active, nothing will happen.
  void Function()? refresh;
}
