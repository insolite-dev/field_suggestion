import 'package:field_suggestion/src/errors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Errors", () {
    test('test searchByORcustomSearchIsNull', () {
      expect(Errors.searchByORcustomSearchIsNull.length, 223);
    });
  });
}
