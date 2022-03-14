import 'package:flutter_test/flutter_test.dart';
import 'package:field_suggestion/utils.dart';

void main() {
  group('[Utils]', () {
    test("maxBoxHeight", () {
      // `matchersList` takes one item.
      // So it would be [60].
      double defaultSize1 = Utils.maxBoxHeight(
        sizeByItem: 1,
        matchers: ['1'].length,
      );

      // `matchersList` takes two item.
      // So it would be [120].
      double defaultSize2 = Utils.maxBoxHeight(
        sizeByItem: null,
        matchers: ['1', '2'].length,
      );

      // `matchersList` takes two item.
      // So it would be [120].
      double defaultSize3 = Utils.maxBoxHeight(
        sizeByItem: null,
        matchers: ['1', '2', '3'].length,
      );

      // `matchersList` takes more than 3 item.
      // So it would be [240].
      double defaultSize = Utils.maxBoxHeight(
        sizeByItem: null,
        matchers: ['1', '2', '3', '4'].length,
      );

      // `matchersList` takes more than 4 item,
      // but `sizeByItem` is 2, so than the size would be 120.
      double sizeByItemSetted = Utils.maxBoxHeight(
        sizeByItem: 2,
        matchers: ['1', '2', '3', '4'].length,
      );

      expect(defaultSize1, 60);
      expect(defaultSize2, 120);
      expect(defaultSize3, 180);
      expect(defaultSize, 240);
      expect(sizeByItemSetted, 120);
    });
  });
}
