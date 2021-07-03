import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_suggestion/field_suggestion.dart';
import 'package:field_suggestion/src/suggestion_item.dart';

import 'src/test_model.dart';

void main() {
  // To test [fieldSuggestion].
  late Widget mainWidget;

  // To test [secondFieldSuggestion].
  late Widget secondMainWidget;

  // To test [thirdFieldSuggestion].
  late Widget thirdMainWidget;

  // To test [fourthFieldSuggestion].
  late Widget fourthMainWidget;

  // To test [fifthFieldSuggestion]
  late Widget fifthMainWidget;

  // To test inital values of [FieldSuggestion].
  FieldSuggestion fieldSuggestion;

  // To test `slideAnimationStyle` property as [SlideAnimationStyle.LTR].
  // And test `wDivider` property as custom widget.
  FieldSuggestion secondFieldSuggestion;

  // To test `slideAnimationStyle` property as [SlideAnimationStyle.BTU].
  // And test `fieldDecoration` property as custom InputDecoration.
  FieldSuggestion thirdFieldSuggestion;

  // To test `slideAnimationStyle` property as [SlideAnimationStyle.UTD],
  // custom gestures and number type suggestion list.
  FieldSuggestion fourthFieldSuggestion;

  // To test slideTweenOffset property as custom value, default gestures.
  // external control, and Custom model class list.
  FieldSuggestion fifthFieldSuggestion;

  // For [fieldSuggestion].
  TextEditingController textEditingController;

  // For [secondFieldSuggestion].
  TextEditingController secondTextEditingController;

  // For [thirdFieldSuggestion].
  TextEditingController thirdTextEditingController;

  // For [fourthFieldSuggestion].
  TextEditingController fourthTextEditingController;

  // For [fifthFieldSuggestion].
  TextEditingController fifthTextEditingController;

  BoxController boxController;

  const suggestions = ['test@gmail.com'];
  var numSuggestions = [13187829696, 99873124124];
  var testModelSuggestions = [TestModel(title: 'Some test')];

  final findFieldSuggestion = find.byKey(Key('suggestion.field'));
  final findSecondFieldSuggestion = find.byKey(Key('seccond.suggestion.field'));
  final findThirdFieldSuggestion = find.byKey(Key('third.suggestion.field'));
  final findFourthFieldSuggestion = find.byKey(Key('fourth.suggestion.field'));
  final findFifthFieldSuggestion = find.byKey(Key('fifth.suggestion.field'));

  setUpAll(() {
    textEditingController = TextEditingController();
    secondTextEditingController = TextEditingController();
    thirdTextEditingController = TextEditingController();
    fourthTextEditingController = TextEditingController();
    fifthTextEditingController = TextEditingController();

    boxController = BoxController();

    fieldSuggestion = FieldSuggestion(
      key: Key('suggestion.field'),
      textController: textEditingController,
      suggestionList: suggestions,
      wDivider: true,
      wSlideAnimation: true,
      wOpacityAnimation: true,
      onItemSelected: (val) {},
    );

    secondFieldSuggestion = FieldSuggestion(
      key: Key('seccond.suggestion.field'),
      textController: secondTextEditingController,
      suggestionList: suggestions,
      wDivider: true,
      divider: Divider(),
      disabledDefaultOnIconTap: true,
      disabledDefaultOnTap: true,
      wSlideAnimation: true,
      slideAnimationStyle: SlideAnimationStyle.LTR,
    );

    thirdFieldSuggestion = FieldSuggestion(
      key: Key('third.suggestion.field'),
      textController: thirdTextEditingController,
      suggestionList: numSuggestions,
      wSlideAnimation: true,
      fieldDecoration: InputDecoration(labelText: 'Type.'),
      slideAnimationStyle: SlideAnimationStyle.BTU,
    );

    fourthFieldSuggestion = FieldSuggestion(
      key: Key('fourth.suggestion.field'),
      textController: fourthTextEditingController,
      suggestionList: numSuggestions,
      disabledDefaultOnTap: true,
      disabledDefaultOnIconTap: true,
      onTap: () {},
      onIconTap: () {},
      onItemSelected: (val) {},
      wSlideAnimation: true,
      slideAnimationStyle: SlideAnimationStyle.UTD,
    );

    fifthFieldSuggestion = FieldSuggestion(
      key: Key('fifth.suggestion.field'),
      boxController: boxController,
      textController: fifthTextEditingController,
      searchBy: ['title'],
      suggestionList: testModelSuggestions,
      closeBoxAfterSelect: false,
      wSlideAnimation: true,
      slideTweenOffset: Tween<Offset>(begin: Offset(-8, 0), end: Offset.zero),
    );

    mainWidget = MaterialApp(
      title: "Suggestion Field",
      home: Scaffold(
        body: Center(child: fieldSuggestion),
      ),
    );

    secondMainWidget = MaterialApp(
      title: "Second Suggestion Field",
      home: Scaffold(
        body: Center(child: secondFieldSuggestion),
      ),
    );

    thirdMainWidget = MaterialApp(
      title: "Third Suggestion Field",
      home: Scaffold(
        body: Center(child: thirdFieldSuggestion),
      ),
    );

    fourthMainWidget = MaterialApp(
      title: "Fourth Suggestion Field",
      home: Scaffold(
        body: Center(child: fourthFieldSuggestion),
      ),
    );

    fifthMainWidget = MaterialApp(
      title: "Fifth Suggestion Field",
      home: Scaffold(
        body: Center(child: fifthFieldSuggestion),
      ),
    );
  });

  group('[FieldSuggestion]', () {
    testWidgets('should contain initial values', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // mainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(findFieldSuggestion, findsOneWidget);

      // Enter text to fieldSuggestion and reload page.
      await tester.enterText(findFieldSuggestion, 'test');
      await tester.pumpAndSettle();

      // FieldSuggestion Widget founding tests. with 3 matchers.
      expect(find.byType(Material), findsNWidgets(2));
      expect(find.byType(Overlay), findsOneWidget);
      expect(find.byType(SlideTransition), findsNWidgets(2));
      expect(find.byType(SizedBox), findsNWidgets(4));
      expect(find.byType(Container), findsNWidgets(3));
      expect(find.byType(CompositedTransformTarget), findsNWidgets(2));
      expect(find.byType(ConstrainedBox), findsNWidgets(4));
      expect(find.byType(Opacity), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(SlideTransition), findsNWidgets(2));
      expect(find.byType(Padding), findsNWidgets(5));
      expect(find.byType(SuggestionItem), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Test closing suggestion box, by giving unmatched value.
      await tester.enterText(findFieldSuggestion, 'x');
      await tester.pumpAndSettle();

      // Test show suggestion box, by giving half matched value.
      await tester.enterText(findFieldSuggestion, 'te');
      await tester.pumpAndSettle();

      // Test closing suggestion box, by giving fully matched value.
      await tester.enterText(findFieldSuggestion, suggestions[0]);
      await tester.pumpAndSettle();
    });

    testWidgets('Test [slideAnimationStyle: SlideAnimationStyle.LTR]',
        (WidgetTester tester) async {
      await tester.pumpWidget(secondMainWidget);

      // secondMainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(findSecondFieldSuggestion, findsOneWidget);

      // Enter text to secondFieldSuggestion and reload page.
      await tester.enterText(findSecondFieldSuggestion, 'test');
      await tester.pumpAndSettle();
    });

    testWidgets('Test [slideAnimationStyle: SlideAnimationStyle.BTU]',
        (WidgetTester tester) async {
      await tester.pumpWidget(thirdMainWidget);

      // thirdMainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(findThirdFieldSuggestion, findsOneWidget);

      // Enter text to thirdFieldSuggestion and reload page.
      await tester.enterText(findThirdFieldSuggestion, '1');
      await tester.pumpAndSettle();

      await tester.tap(find.text(numSuggestions[0].toString()));
      await tester.pumpAndSettle();
    });

    testWidgets(
        'Test [slideAnimationStyle: SlideAnimationStyle.UTD]  + custom gestures',
        (WidgetTester tester) async {
      await tester.pumpWidget(fourthMainWidget);

      // fourthMainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(findFourthFieldSuggestion, findsOneWidget);

      // Enter text to fourthFieldSuggestion and reload page.
      await tester.enterText(findFourthFieldSuggestion, '13187829696');
      await tester.pumpAndSettle();

      final suggestedItem = find.byType(SuggestionItem);
      final tralling = find.byIcon(Icons.clear);

      await tester.tap(suggestedItem);
      await tester.tap(tralling);
    });

    testWidgets('Test [slideTweenOffset] as custom property + default gestures',
        (WidgetTester tester) async {
      await tester.pumpWidget(fifthMainWidget);

      // fifthMainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(findFifthFieldSuggestion, findsOneWidget);

      // Enter text to fifthFieldSuggestion and reload page.
      await tester.enterText(findFifthFieldSuggestion, 'test');
      await tester.pumpAndSettle();

      final suggestedItem = find.byType(SuggestionItem);
      final tralling = find.byIcon(Icons.clear);

      expect(tralling, findsOneWidget);

      await tester.tap(suggestedItem);
      await tester.pumpAndSettle();

      await tester.tap(tralling);
      await tester.pumpAndSettle();
    });
  });
}
