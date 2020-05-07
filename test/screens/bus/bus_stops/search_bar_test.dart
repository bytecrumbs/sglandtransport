import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/search_bar.dart';

void main() {
  Future<void> _pumpSearchBar(WidgetTester tester) async {
    return await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SearchBar(
          onSearchTextChanged: (String text) {},
          controller: TextEditingController(),
        ),
      ),
    ));
  }

  testWidgets('TextField has a label', (WidgetTester tester) async {
    await _pumpSearchBar(tester);

    final labelFinder = find.text('Search bus stop');
    expect(labelFinder, findsOneWidget);
  });

  testWidgets('TextField allows text input', (WidgetTester tester) async {
    await _pumpSearchBar(tester);
    const textFieldValue = '010101';
    await tester.enterText(find.byType(TextField), textFieldValue);
    final textFieldValueFinder = find.text(textFieldValue);
    expect(textFieldValueFinder, findsOneWidget);
  });

  testWidgets('TextField has an icon that clears text',
      (WidgetTester tester) async {
    await _pumpSearchBar(tester);
    // write into the text field and confirm text is there
    const textFieldValue = '010101';
    await tester.enterText(find.byType(TextField), textFieldValue);
    final textFieldValueFinder = find.text(textFieldValue);
    expect(textFieldValueFinder, findsOneWidget);

    // clear the text field
    await tester.tap(find.byIcon(Icons.cancel));
    await tester.pump();

    // confirm text is not there anymore
    expect(textFieldValueFinder, findsNothing);
  });
}
