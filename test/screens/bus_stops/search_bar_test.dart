import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus_stops/search_bar.dart';

void main() {
  Widget _getSearchBar() {
    return MaterialApp(
      home: Scaffold(
        body: SearchBar(),
      ),
    );
  }

  testWidgets('TextField has a label', (WidgetTester tester) async {
    await tester.pumpWidget(_getSearchBar());

    final Finder labelFinder = find.text('Enter a Bus Stop number');
    expect(labelFinder, findsOneWidget);
  });

  testWidgets('TextField allows text input', (WidgetTester tester) async {
    await tester.pumpWidget(_getSearchBar());

    const String textFieldValue = '010101';
    await tester.enterText(find.byType(TextField), textFieldValue);
    final Finder textFieldValueFinder = find.text(textFieldValue);
    expect(textFieldValueFinder, findsOneWidget);
  });

  testWidgets('TextField has an icon that clears text',
      (WidgetTester tester) async {
    await tester.pumpWidget(_getSearchBar());

    // write into the text field and confirm text is there
    const String textFieldValue = '010101';
    await tester.enterText(find.byType(TextField), textFieldValue);
    final Finder textFieldValueFinder = find.text(textFieldValue);
    expect(textFieldValueFinder, findsOneWidget);

    // clear the text field
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    // confirm text is not there anymore
    expect(textFieldValueFinder, findsNothing);
  });
}
