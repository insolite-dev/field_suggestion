import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_suggestion/field_suggestion.dart';

void main() {
  const mockNetworkRequestDuration = 1;

  late Widget mainWidget, mainWidgetNetwork;
  late FieldSuggestion fieldSuggestion;
  late FieldSuggestion fieldSuggestionNetwork;

  late BoxController boxController;
  late TextEditingController textEditingController;
  late TextEditingController textEditingControllerNetwork;

  final fFieldSuggestion = find.byKey(Key('suggestion.field'));
  final fFieldSuggestionNetwork = find.byKey(Key('suggestion.field.network'));

  final suggestions = List.generate(5, (i) => 'test$i@gmail.com');
  Future<List<String>> suggestionsFuture(String input) => Future.delayed(
        const Duration(seconds: mockNetworkRequestDuration ),
        () => suggestions.where((e) => e.contains(input)).toList(),
      );

  setUpAll(() {
    boxController = BoxController();
    textEditingController = TextEditingController();
    textEditingControllerNetwork = TextEditingController();

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

    fieldSuggestionNetwork = FieldSuggestion<String>.network(
      key: Key('suggestion.field.network'),
      initialData: suggestions,
      textController: textEditingControllerNetwork,
      future: (input) => suggestionsFuture(input),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading ...'));
        }

        final result = snapshot.data ?? [];
        return ListView(children: [for (final element in result) Text(element)]);
      },
    );

    mainWidget = MaterialApp(home: Scaffold(body: Center(child: fieldSuggestion)));
    mainWidgetNetwork = MaterialApp(home: Scaffold(body: Center(child: fieldSuggestionNetwork)));
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
      expect(find.byType(SlideTransition), findsOneWidget);
      expect(find.byType(SizedBox), findsNWidgets(7));
      expect(find.byType(Container), findsNWidgets(7));
      expect(find.byType(CompositedTransformTarget), findsNWidgets(2));
      expect(find.byType(ConstrainedBox), findsNWidgets(3));
      expect(find.byType(Opacity), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      expect(find.text('item.0'), findsOneWidget);
      expect(find.text('item.1'), findsOneWidget);
      expect(find.text('item.2'), findsOneWidget);
      expect(find.text('item.3'), findsOneWidget);
      expect(find.text('item.4'), findsOneWidget);

      // Re-execute text entering to test overlay list management functionality.
      await tester.enterText(fFieldSuggestion, 'te');
      await tester.pumpAndSettle();

      boxController.refresh!.call();
      await tester.pumpAndSettle();

      // Test closing suggestion box, by giving unmatched value.
      await tester.enterText(fFieldSuggestion, 'x');
      await tester.pumpAndSettle();

      // Test show suggestion box, by giving half matched value.
      await tester.enterText(fFieldSuggestion, 'test');
      await tester.pumpAndSettle();

      // Test closing suggestion box, by giving empty input.
      await tester.enterText(fFieldSuggestion, '');
      await tester.pumpAndSettle();
    });

    group('.network', () {
      testWidgets('should contain initial values', (WidgetTester tester) async {
        const duration = Duration(seconds: mockNetworkRequestDuration * 2);
        await tester.pumpWidget(mainWidgetNetwork);

        // mainWidget tests.
        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Center), findsOneWidget);
        expect(fFieldSuggestionNetwork, findsOneWidget);

        // Enter text to fieldSuggestion and reload page.
        await tester.enterText(fFieldSuggestionNetwork, 'test');
        await tester.pumpAndSettle();

        // Expect loading state. i.e [ConnectionState.waiting].
        expect(find.byType(Center), findsNWidgets(2));
        expect(find.text('Loading ...'), findsOneWidget);

        expect(find.byType(Material), findsNWidgets(2));
        expect(find.byType(Overlay), findsOneWidget);
        expect(find.byType(SlideTransition), findsNothing);
        expect(find.byType(SizedBox), findsNWidgets(3));
        expect(find.byType(Container), findsNWidgets(2));
        expect(find.byType(CompositedTransformTarget), findsNWidgets(2));
        expect(find.byType(ConstrainedBox), findsNWidgets(3));
        expect(find.byType(Opacity), findsOneWidget);
        expect(find.byType(ListView), findsNothing);
        expect(find.byType(TextFormField), findsOneWidget);

        await tester.pumpAndSettle(duration);

        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('test0@gmail.com'), findsOneWidget);
        expect(find.text('test1@gmail.com'), findsOneWidget);
        expect(find.text('test2@gmail.com'), findsOneWidget);
        expect(find.text('test3@gmail.com'), findsOneWidget);
        expect(find.text('test4@gmail.com'), findsOneWidget);

        // test no results
        await tester.enterText(fFieldSuggestionNetwork, '3.14');
        await tester.pumpAndSettle(duration);

        expect(find.byType(Center), findsOneWidget);
      });
    });
  });
}
