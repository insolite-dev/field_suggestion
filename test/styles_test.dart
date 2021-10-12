import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_suggestion/src/styles.dart';

main() {
  late SuggestionBoxStyle customSuggestionBoxStyle;
  late SuggestionItemStyle customSuggestionItemStyle;

  setUpAll(() {
    customSuggestionBoxStyle = SuggestionBoxStyle(
      backgroundColor: Colors.white,
      border: Border.all(),
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
      boxShadow: [BoxShadow(spreadRadius: 15)],
      padding: EdgeInsets.all(10),
      shape: BoxShape.circle,
    );

    customSuggestionItemStyle = SuggestionItemStyle(
      backgroundColor: Colors.white,
      titleStyle: TextStyle(color: Colors.purple),
      border: Border.all(),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      gradient: LinearGradient(colors: [Colors.pink, Colors.purple]),
      boxShadow: [BoxShadow(spreadRadius: 15)],
      margin: EdgeInsets.all(5),
    );
  });

  group('[SuggestionBoxStyle]', () {
    test('customSuggestionBoxStyle', () {
      expect(customSuggestionBoxStyle.backgroundColor, Colors.white);
      expect(customSuggestionBoxStyle.border, Border.all());
      expect(customSuggestionBoxStyle.borderRadius, BorderRadius.circular(10));
      expect(customSuggestionBoxStyle.gradient,
          LinearGradient(colors: [Colors.white, Colors.grey]));
      expect(customSuggestionBoxStyle.boxShadow, [BoxShadow(spreadRadius: 15)]);
      expect(customSuggestionBoxStyle.padding, EdgeInsets.all(10));
      expect(customSuggestionBoxStyle.shape, BoxShape.circle);
    });

    test('DefaultStyle', () {
      SuggestionBoxStyle defaultStyle = SuggestionBoxStyle.DefaultStyle;

      expect(defaultStyle.backgroundColor, Colors.white);
      expect(defaultStyle.border, null);
      expect(defaultStyle.borderRadius, BorderRadius.all(Radius.circular(5)));
      expect(defaultStyle.gradient, null);
      expect(defaultStyle.boxShadow, [
        BoxShadow(
          spreadRadius: 10,
          offset: Offset(0, 5),
          color: Color(0xFFA3A3A3),
          blurRadius: 10,
        )
      ]);
      expect(defaultStyle.padding, null);
      expect(defaultStyle.shape, BoxShape.rectangle);
    });
  });

  group('[SuggestionItemStyle]', () {
    test('customSuggestionItemStyle', () {
      expect(customSuggestionItemStyle.backgroundColor, Colors.white);
      expect(
        customSuggestionItemStyle.titleStyle,
        TextStyle(color: Colors.purple),
      );
      expect(customSuggestionItemStyle.border, Border.all());
      expect(
        customSuggestionItemStyle.borderRadius,
        const BorderRadius.all(Radius.circular(10)),
      );
      expect(
        customSuggestionItemStyle.gradient,
        LinearGradient(colors: [Colors.pink, Colors.purple]),
      );
      expect(
        customSuggestionItemStyle.boxShadow,
        [BoxShadow(spreadRadius: 15)],
      );
      expect(customSuggestionItemStyle.margin, EdgeInsets.all(5));
    });

    test('DefaultStyle', () {
      SuggestionItemStyle defaultStyle = SuggestionItemStyle.DefaultStyle;

      expect(defaultStyle.backgroundColor, Colors.white);
      expect(defaultStyle.titleStyle, TextStyle(color: Colors.black));
      expect(defaultStyle.border, null);
      expect(defaultStyle.borderRadius,
          const BorderRadius.all(Radius.circular(5)));
      expect(defaultStyle.gradient, null);
      expect(defaultStyle.boxShadow, null);
      expect(defaultStyle.margin, null);
    });
  });
}
