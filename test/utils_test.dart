import 'package:flutter_test/flutter_test.dart';
import 'package:field_suggestion/src/utils.dart';

import 'src/test_model.dart';

void main() {
  group('[Utils]', () {
    test("maxSuggestionBoxHeight", () {
      // `matchersList` takes one item.
      // So it would be [60].
      double defaultSize1 = maxSuggestionBoxHeight(
        wDivider: false,
        sizeByItem: 1,
        matchersList: ['1'],
      );

      // `matchersList` takes two item.
      // So it would be [120].
      double defaultSize2 = maxSuggestionBoxHeight(
        wDivider: false,
        sizeByItem: null,
        matchersList: ['1', '2'],
      );

      // `matchersList` takes two item.
      // So it would be [120].
      double defaultSize3 = maxSuggestionBoxHeight(
        wDivider: false,
        sizeByItem: null,
        matchersList: ['1', '2', '3'],
      );

      // `matchersList` takes more than 3 item.
      // And `wDivider` is [true].
      // So it would be [260].
      double defaultSize = maxSuggestionBoxHeight(
        wDivider: true,
        sizeByItem: null,
        matchersList: ['1', '2', '3', '4'],
      );

      // `matchersList` takes more than 4 item,
      // but `sizeByItem` is 2, so than the size would be 120.
      double sizeByItemSetted = maxSuggestionBoxHeight(
        wDivider: false,
        sizeByItem: 2,
        matchersList: ['1', '2', '3', '4'],
      );

      expect(defaultSize1, 60);
      expect(defaultSize2, 120);
      expect(defaultSize3, 180);
      expect(defaultSize, 260);
      expect(sizeByItemSetted, 120);
    });

    test('renderObjList', () {
      List<TestModel> modelList = [TestModel(title: 'Some test')];

      var renderedMatchersList = renderObjList(
        modelList,
        'Some',
        searchBy: ['title'],
      );

      var renderedMatchersListCustomSearch = renderObjList(
        modelList,
        'Some',
        customSearch: (item, input) {
          return item.title.contains(input);
        },
      );

      List<Map<String, dynamic>> mockRenderedMatchersList = [
        modelList[0].toJson()
      ];

      expect(renderedMatchersList is List<Map<String, dynamic>>, true);
      expect(renderedMatchersList, mockRenderedMatchersList);

      expect(
        renderedMatchersListCustomSearch is List<Map<String, dynamic>>,
        true,
      );
      expect(renderedMatchersListCustomSearch, mockRenderedMatchersList);
    });

    test('isSelected', () {
      // Should return false if matchers list is empty
      expect(isSelected(null, null, []), false);

      // Test with non-object suggestions list.
      const List<String> mockSuggestions = ['123', '345', '567', '789'];
      expect(
        true,
        isSelected(mockSuggestions, mockSuggestions[0], [mockSuggestions[0]]),
      );

      const List<TestModel> mockObjSuggestions = [TestModel(title: '123')];
      expect(
        true,
        isSelected(
          mockObjSuggestions,
          mockObjSuggestions[0].title,
          [mockObjSuggestions[0].toJson()],
          ['title'],
        ),
      );
    });

    test('isObjList', () {
      const List<String> stringList = ['one', 'two', 'three'];
      const List<int> intList = [1, 2, 3];
      const List<double> doubleList = [1.0, 2.0, 3.0];
      const List<TestModel> modelList = [TestModel(title: 'Some test')];

      expect(isObjList(stringList), false);
      expect(isObjList(intList), false);
      expect(isObjList(doubleList), false);
      expect(isObjList(modelList), true);
    });
  });
}
