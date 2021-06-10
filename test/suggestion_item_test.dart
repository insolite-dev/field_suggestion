import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_suggestion/field_suggestion.dart';
import 'package:field_suggestion/src/suggestion_item.dart';

void main() {
  late Widget mainWidget;
  Widget suggestionItem;

  setUpAll(() {
    // Initilaze [SuggestionItem] widget with custom properties.
    suggestionItem = SuggestionItem(
      disableItemTrailing: false,
      style: SuggestionItemStyle.DefaultStyle,
      onTap: () {},
      onIconTap: () {},
      title: "Suggested Item",
    );

    // initilaze [mainWidget].
    mainWidget = MaterialApp(
      title: "Suggestion Item",
      home: Scaffold(
        body: Center(
          child: suggestionItem,
        ),
      ),
    );
  });

  testWidgets('Suggestion Item test', (WidgetTester tester) async {
    await tester.pumpWidget(mainWidget);

    // mainWidget tests.
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Center), findsNWidgets(2));

    // Suggestion Item tests
    expect(find.byType(SuggestionItem), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Suggested Item'), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsOneWidget);
  });
}
