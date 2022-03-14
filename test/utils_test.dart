import 'package:flutter_test/flutter_test.dart';
import 'package:field_suggestion/src/utils.dart';

void main() {
  group('[Utils]', () {
    test("maxBoxHeight", () {
      // `matchersList` takes one item.
      // So it would be [60].
      double defaultSize1 = Utils.maxBoxHeight(
        sizeByItem: 1,
        matchersList: ['1'],
      );

      // `matchersList` takes two item.
      // So it would be [120].
      double defaultSize2 = Utils.maxBoxHeight(
        sizeByItem: null,
        matchersList: ['1', '2'],
      );

      // `matchersList` takes two item.
      // So it would be [120].
      double defaultSize3 = Utils.maxBoxHeight(
        sizeByItem: null,
        matchersList: ['1', '2', '3'],
      );

      // `matchersList` takes more than 3 item.
      // And `wDivider` is [true].
      // So it would be [260].
      double defaultSize = Utils.maxBoxHeight(
        sizeByItem: null,
        matchersList: ['1', '2', '3', '4'],
      );

      // `matchersList` takes more than 4 item,
      // but `sizeByItem` is 2, so than the size would be 120.
      double sizeByItemSetted = Utils.maxBoxHeight(
        sizeByItem: 2,
        matchersList: ['1', '2', '3', '4'],
      );

      expect(defaultSize1, 60);
      expect(defaultSize2, 120);
      expect(defaultSize3, 180);
      expect(defaultSize, 240);
      expect(sizeByItemSetted, 120);
    });
  });
}
