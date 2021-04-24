import 'package:flutter_test/flutter_test.dart';
import 'package:field_suggestion/src/utils.dart';

void main() {
  group('[Utils]', () {
    test("`maxSuggestionBoxHeight` test", () {
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
  });
}
