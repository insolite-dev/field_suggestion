import 'package:flutter_test/flutter_test.dart';
import 'package:field_suggestion/field_suggestion.dart';

void main() {
  late BoxController boxController;

  String state = '';

  void closeFun() => state = 'close';
  void openFun() => state = 'open';
  void refreshFun() => state = 'refresh';

  setUpAll(() {
    boxController = BoxController();

    boxController.close = closeFun;
    boxController.open = openFun;
    boxController.refresh = refreshFun;
  });

  group("[BoxController]", () {
    test('test [close]', () {
      boxController.close!();
      expect(state, 'close');
    });
    test('test [open]', () {
      boxController.open!();
      expect(state, 'open');
    });
    test('test [refresh]', () {
      boxController.refresh!();
      expect(state, 'refresh');
    });
  });
}
