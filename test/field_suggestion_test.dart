import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_suggestion/field_suggestion.dart';
import 'package:field_suggestion/src/suggestion_item.dart';

void main() {
  // To test [fieldSuggestion].
  Widget mainWidget;

  // To test [secondFieldSuggestion].
  Widget secondMainWidget;

  // To test [thirdFieldSuggestion].
  Widget thirdMainWidget;

  // To test [fourthFieldSuggestion].
  Widget fourthMainWidget;

  // To test [fifthFieldSuggestion]
  Widget fifthMainWidget;

  // To test inital values of [FieldSuggestion].
  FieldSuggestion fieldSuggestion;

  // To test `slideAnimationStyle` property as [SlideAnimationStyle.LTR].
  // And test `wDivider` property as custom widget.
  FieldSuggestion secondFieldSuggestion;

  // To test `slideAnimationStyle` property as [SlideAnimationStyle.BTU].
  // And test `fieldDecoration` property as custom InputDecoration.
  FieldSuggestion thirdFieldSuggestion;

  // To test `slideAnimationStyle` property as [SlideAnimationStyle.UTD].
  FieldSuggestion fourthFieldSuggestion;

  // To test slideTweenOffset property as custom value.
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

  const suggestions = ['test@gmail.com', 'test1@gmail.com', 'test2@gmail.com'];

  final findFieldSuggestion = find.byKey(Key('suggestion.field'));
  final findSecondFieldSuggestion = find.byKey(Key('seccond.suggestion.field'));
  final findThirdFieldSuggestion = find.byKey(Key('third.suggestion.field'));
  final findFourthFieldSuggestion = find.byKey(Key('fourth.suggestion.field'));
  final findFifthFieldSuggestion = find.byKey(Key('fifth.suggestion.field'));

  setUpAll(() {
    // Initilaze all text editing controllerers.
    textEditingController = TextEditingController();
    secondTextEditingController = TextEditingController();
    thirdTextEditingController = TextEditingController();
    fourthTextEditingController = TextEditingController();
    fifthTextEditingController = TextEditingController();

    fieldSuggestion = FieldSuggestion(
      key: Key('suggestion.field'),
      textController: textEditingController,
      suggestionList: suggestions,
      wDivider: true,
      wSlideAnimation: true,
      wOpacityAnimation: true,
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
      suggestionList: suggestions,
      wSlideAnimation: true,
      fieldDecoration: InputDecoration(labelText: 'Type.'),
      slideAnimationStyle: SlideAnimationStyle.BTU,
    );

    fourthFieldSuggestion = FieldSuggestion(
      key: Key('fourth.suggestion.field'),
      textController: fourthTextEditingController,
      suggestionList: suggestions,
      wSlideAnimation: true,
      slideAnimationStyle: SlideAnimationStyle.UTD,
    );

    fifthFieldSuggestion = FieldSuggestion(
      key: Key('fifth.suggestion.field'),
      textController: fifthTextEditingController,
      suggestionList: suggestions,
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
    testWidgets('Should expect initial values', (WidgetTester tester) async {
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
      expect(find.byType(SizedBox), findsNWidgets(7));
      expect(find.byType(Container), findsNWidgets(9));
      expect(find.byType(CompositedTransformTarget), findsNWidgets(2));
      expect(find.byType(ConstrainedBox), findsNWidgets(9));
      expect(find.byType(Opacity), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(SlideTransition), findsNWidgets(2));
      expect(find.byType(Column), findsNWidgets(3));
      expect(find.byType(Padding), findsNWidgets(12));
      expect(find.byType(SuggestionItem), findsNWidgets(3));
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
      await tester.enterText(findThirdFieldSuggestion, 'test');
      await tester.pumpAndSettle();
    });

    testWidgets('Test [slideAnimationStyle: SlideAnimationStyle.UTD]',
        (WidgetTester tester) async {
      await tester.pumpWidget(fourthMainWidget);

      // fourthMainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(findFourthFieldSuggestion, findsOneWidget);

      // Enter text to fourthFieldSuggestion and reload page.
      await tester.enterText(findFourthFieldSuggestion, 'test');
      await tester.pumpAndSettle();
    });

    testWidgets('Test [slideTweenOffset] as custom property',
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
    });
  });
}
