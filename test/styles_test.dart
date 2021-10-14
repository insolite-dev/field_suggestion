import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_suggestion/src/styles.dart';

import 'src/utils.dart';

main() {
  late MockAnimationController animationControllerMock;

  late SuggestionBoxStyle customSuggestionBoxStyle;
  late SuggestionItemStyle customSuggestionItemStyle;

  setUpAll(() {
    animationControllerMock = MockAnimationController();

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

  group('[FieldAnimationStyle]', () {
    test('set box animation from slide should work properly', () {
      final fromSlideStyle = FieldAnimationStyle.setBoxAnimation(
        slideStyle: SlideStyle.RTL,
        animationController: animationControllerMock,
        slideTweenOffset: null,
        slideCurve: Curves.bounceOut,
      );

      expect(fromSlideStyle is Animation<Offset>, true);
    });

    test('set box animation from custom tween offset should work properly', () {
      final fromCustomTween = FieldAnimationStyle.setBoxAnimation(
        slideStyle: SlideStyle.UTD, // Doesn't matter.
        animationController: animationControllerMock,
        slideTweenOffset: Tween<Offset>(
          begin: Offset(0, 5),
          end: Offset(-5, 0),
        ),
        slideCurve: Curves.bounceOut,
      );

      expect(fromCustomTween is Animation<Offset>, true);
    });
  });

  group('[SuggestionBoxStyle]', () {
    test('customSuggestionBoxStyle should contain custom properties', () {
      expect(customSuggestionBoxStyle.backgroundColor, Colors.white);
      expect(customSuggestionBoxStyle.border, Border.all());
      expect(customSuggestionBoxStyle.borderRadius, BorderRadius.circular(10));
      expect(
        customSuggestionBoxStyle.gradient,
        LinearGradient(colors: [Colors.white, Colors.grey]),
      );
      expect(customSuggestionBoxStyle.boxShadow, [BoxShadow(spreadRadius: 15)]);
      expect(customSuggestionBoxStyle.padding, EdgeInsets.all(10));
      expect(customSuggestionBoxStyle.shape, BoxShape.circle);
    });

    test('DefaultStyle should contain initial properties', () {
      SuggestionBoxStyle defaultStyle = SuggestionBoxStyle.DefaultStyle;

      expect(defaultStyle.backgroundColor, Colors.white);
      expect(defaultStyle.border, null);
      expect(defaultStyle.borderRadius, BorderRadius.all(Radius.circular(5)));
      expect(defaultStyle.gradient, null);
      expect(defaultStyle.boxShadow, [
        const BoxShadow(
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
    test('customSuggestionItemStyle should contain custom properties', () {
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

    test('DefaultStyle should contain initial properties', () {
      SuggestionItemStyle defaultStyle = SuggestionItemStyle.DefaultStyle;

      expect(defaultStyle.backgroundColor, Colors.white);
      expect(defaultStyle.titleStyle, TextStyle(color: Colors.black));
      expect(defaultStyle.border, null);
      expect(
        defaultStyle.borderRadius,
        const BorderRadius.all(Radius.circular(5)),
      );
      expect(defaultStyle.gradient, null);
      expect(defaultStyle.boxShadow, null);
      expect(defaultStyle.margin, null);
    });
  });
}
