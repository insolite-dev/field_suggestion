/// Custom controller to make able using suggestion box as external.
/// Has two functions: [close] and [show].
/// So basicly [close] used to close suggestion box,
/// and [show] used to show suggestion box.
class BoxController {
  void Function()? close;
  void Function()? show;
}
