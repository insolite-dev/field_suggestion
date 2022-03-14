import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_suggestion/field_suggestion.dart';

import 'src/test_model.dart';

void main() {
  late Widget mainWidget;

  late FieldSuggestion fieldSuggestion;
  late BoxController boxController;
  late TextEditingController textEditingController;

  final fFieldSuggestion = find.byKey(Key('suggestion.field'));

  final suggestions = List.generate(5, (i) => 'test$i@gmail.com');

  setUpAll(() {
    boxController = BoxController();
    textEditingController = TextEditingController();

    fieldSuggestion = FieldSuggestion(
      key: Key('suggestion.field'),
      boxController: boxController,
      textController: textEditingController,
      search: (item, input) {
        return item.toString().toUpperCase().contains(input.toUpperCase());
      },
      suggestions: suggestions,
      wSlideAnimation: true,
      wOpacityAnimation: true,
      itemBuilder: (context, index) {
        return Card(child: Text('item.$index'));
      },
    );

    mainWidget = MaterialApp(
      home: Scaffold(body: Center(child: fieldSuggestion)),
    );
  });

  group('[FieldSuggestion]', () {
    testWidgets('should contain initial values', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // mainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(fFieldSuggestion, findsOneWidget);

      // Enter text to fieldSuggestion and reload page.
      await tester.enterText(fFieldSuggestion, 'test');
      await tester.pumpAndSettle();

      expect(find.byType(Material), findsNWidgets(7));
      expect(find.byType(Overlay), findsOneWidget);
      expect(find.byType(SlideTransition), findsNWidgets(2));
      expect(find.byType(SizedBox), findsNWidgets(6));
      expect(find.byType(Container), findsNWidgets(7));
      expect(find.byType(CompositedTransformTarget), findsNWidgets(2));
      expect(find.byType(ConstrainedBox), findsNWidgets(3));
      expect(find.byType(Opacity), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      expect(find.byType(Card), findsNWidgets(5));
      expect(find.text('item.0'), findsOneWidget);
      expect(find.text('item.1'), findsOneWidget);
      expect(find.text('item.2'), findsOneWidget);
      expect(find.text('item.3'), findsOneWidget);
      expect(find.text('item.4'), findsOneWidget);

      // Test closing suggestion box, by giving unmatched value.
      await tester.enterText(fFieldSuggestion, 'x');
      await tester.pumpAndSettle();

      // Test show suggestion box, by giving half matched value.
      await tester.enterText(fFieldSuggestion, 'te');
      await tester.pumpAndSettle();

      // Test closing suggestion box, by giving empty input.
      await tester.enterText(fFieldSuggestion, '');
      await tester.pumpAndSettle();
    });
  });
}
