import 'utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:field_suggestion/styles.dart';

main() {
  late BoxStyle boxStyle;

  late MockBuildContext buildContextMock;
  late MockAnimationController animationControllerMock;

  setUpAll(() {
    buildContextMock = MockBuildContext();
    animationControllerMock = MockAnimationController();

    boxStyle = BoxStyle(
      backgroundColor: Colors.white,
      border: Border.all(),
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
      boxShadow: [BoxShadow(spreadRadius: 15)],
      shape: BoxShape.circle,
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
    test('hand made box style should contain custom properties', () {
      expect(boxStyle.backgroundColor, Colors.white);
      expect(boxStyle.border, Border.all());
      expect(boxStyle.borderRadius, BorderRadius.circular(10));
      expect(
        boxStyle.gradient,
        LinearGradient(colors: [Colors.white, Colors.grey]),
      );
      expect(boxStyle.boxShadow, [BoxShadow(spreadRadius: 15)]);
      expect(boxStyle.shape, BoxShape.circle);
    });

    test('defaultStyle should contain initial properties', () {
      final BoxStyle defaultStyle = BoxStyle.defaultStyle(buildContextMock);

      expect(defaultStyle.backgroundColor, Colors.white);
      expect(defaultStyle.border, null);
      expect(defaultStyle.borderRadius, BorderRadius.all(Radius.circular(5)));
      expect(defaultStyle.gradient, null);
      expect(defaultStyle.boxShadow, [
        const BoxShadow(
          spreadRadius: 12.5,
          offset: Offset(0, 5),
          color: Color(0xff000000),
          blurRadius: 12.5,
        )
      ]);
      expect(defaultStyle.shape, BoxShape.rectangle);
    });
  });
}
