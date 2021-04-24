import 'package:field_suggestion/src/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  SuggestionBoxStyle customSuggestionBoxStyle;
  SuggestionItemStyle customSuggestionItemStyle;

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
      icon: Icons.remove,
      iconSize: 18,
      iconColor: Colors.red,
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
      expect(customSuggestionItemStyle.icon, Icons.remove);
      expect(customSuggestionItemStyle.iconSize, 18);
      expect(customSuggestionItemStyle.iconColor, Colors.red);
      expect(customSuggestionItemStyle.border, Border.all());
      expect(customSuggestionItemStyle.borderRadius,
          const BorderRadius.all(Radius.circular(10)));
      expect(customSuggestionItemStyle.gradient,
          LinearGradient(colors: [Colors.pink, Colors.purple]));
      expect(
          customSuggestionItemStyle.boxShadow, [BoxShadow(spreadRadius: 15)]);
      expect(customSuggestionItemStyle.margin, EdgeInsets.all(5));
    });

    test('DefaultStyle', () {
      SuggestionItemStyle defaultStyle = SuggestionItemStyle.DefaultStyle;

      expect(defaultStyle.backgroundColor, Colors.white);
      expect(defaultStyle.titleStyle, TextStyle(color: Colors.black));
      expect(defaultStyle.icon, Icons.clear);
      expect(defaultStyle.iconSize, 20);
      expect(defaultStyle.iconColor, Colors.red);
      expect(defaultStyle.border, null);
      expect(defaultStyle.borderRadius,
          const BorderRadius.all(Radius.circular(5)));
      expect(defaultStyle.gradient, null);
      expect(defaultStyle.boxShadow, null);
      expect(defaultStyle.margin, null);
    });

    test('WhiteNeumorphismedStyle', () {
      SuggestionItemStyle whiteNeumorphismedStyle =
          SuggestionItemStyle.WhiteNeumorphismedStyle;

      expect(whiteNeumorphismedStyle.backgroundColor, Colors.white);
      expect(
          whiteNeumorphismedStyle.titleStyle, TextStyle(color: Colors.black));
      expect(whiteNeumorphismedStyle.icon, Icons.clear);
      expect(whiteNeumorphismedStyle.iconSize, 20);
      expect(whiteNeumorphismedStyle.iconColor, Colors.red);
      expect(whiteNeumorphismedStyle.border, null);
      expect(whiteNeumorphismedStyle.borderRadius,
          const BorderRadius.all(Radius.circular(5)));
      expect(whiteNeumorphismedStyle.gradient, null);
      expect(whiteNeumorphismedStyle.boxShadow, [
        BoxShadow(
          blurRadius: 1,
          spreadRadius: 1,
          offset: Offset(0, 2),
          color: Color(0xffD5D5D5),
        ),
      ]);
      expect(whiteNeumorphismedStyle.margin,
          EdgeInsetsDirectional.only(start: 1, end: 1, top: 1));
    });

    test('BlackNeumorphismedStyle', () {
      SuggestionItemStyle blackNeumorphismedStyle =
          SuggestionItemStyle.BlackNeumorphismedStyle;

      expect(blackNeumorphismedStyle.backgroundColor, Color(0xFF0E0E0E));
      expect(
          blackNeumorphismedStyle.titleStyle, TextStyle(color: Colors.white));
      expect(blackNeumorphismedStyle.icon, Icons.clear);
      expect(blackNeumorphismedStyle.iconSize, 20);
      expect(blackNeumorphismedStyle.iconColor, Colors.red);
      expect(blackNeumorphismedStyle.border, null);
      expect(blackNeumorphismedStyle.borderRadius,
          const BorderRadius.all(Radius.circular(5)));
      expect(blackNeumorphismedStyle.gradient, null);
      expect(blackNeumorphismedStyle.boxShadow, [
        BoxShadow(
          blurRadius: 1,
          spreadRadius: 1,
          offset: Offset(0, 2),
          color: Color(0xFF2E2E2E),
        ),
      ]);
      expect(blackNeumorphismedStyle.margin,
          EdgeInsetsDirectional.only(start: 1, end: 1, top: 1));
    });
  });
}
