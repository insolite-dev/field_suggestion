import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_suggestion/field_suggestion.dart';

void main() {
  Widget mainWidget;
  FieldSuggestion fieldSuggestion;

  // Text Editing controller for fieldSuggestion.
  TextEditingController textEditingController;

  // The suggestions list.
  List<String> suggestions;

  setUpAll(() {
    // initilaze controller.
    textEditingController = TextEditingController();

    // initilaze suggestions list.
    suggestions = ['test@gmail.com', 'test1@gmail.com', 'test2@gmail.com'];

    // initilaze [mainWidget].
    mainWidget = MaterialApp(
      title: "Suggestion Field",
      home: Scaffold(
        body: Center(
          child: fieldSuggestion,
        ),
      ),
    );

    // initilaze SuggestionField widget with default properties.
    fieldSuggestion = FieldSuggestion(
      textController: textEditingController,
      suggestionList: suggestions,
    );
  });
  testWidgets('[SuggestionField] tests', (WidgetTester tester) async {
    await tester.pumpWidget(mainWidget);

    // mainWidget tests.
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);

    // fieldSuggestion tests.
    // expect(find.byType(FieldSuggestion), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);
  });
}
