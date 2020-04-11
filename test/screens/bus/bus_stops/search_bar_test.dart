import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/search_bar.dart';

void main() {
  Future<void> _pumpSearchBar(WidgetTester tester) async {
    return await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SearchBar(),
      ),
    ));
  }

  testWidgets('TextField has a label', (WidgetTester tester) async {
    await _pumpSearchBar(tester);

    final Finder labelFinder = find.text('Enter a Bus Stop number');
    expect(labelFinder, findsOneWidget);
  });

  testWidgets('TextField allows text input', (WidgetTester tester) async {
    await _pumpSearchBar(tester);
    const String textFieldValue = '010101';
    await tester.enterText(find.byType(TextField), textFieldValue);
    final Finder textFieldValueFinder = find.text(textFieldValue);
    expect(textFieldValueFinder, findsOneWidget);
  });

  testWidgets('TextField has an icon that clears text',
      (WidgetTester tester) async {
    await _pumpSearchBar(tester);
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

  testWidgets('TextField allows only to enter numbers',
      (WidgetTester tester) async {
    await _pumpSearchBar(tester);
    // write into the text field and confirm text is there
    const String validTextFieldValue = '010101';
    await tester.enterText(find.byType(TextField), validTextFieldValue);
    final Finder validTextFieldValueFinder = find.text(validTextFieldValue);
    expect(validTextFieldValueFinder, findsOneWidget);

    // clear the text field
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    const String invalidTextFieldValue = 'asdf';
    await tester.enterText(find.byType(TextField), invalidTextFieldValue);
    final Finder invalidTextFieldValueFinder = find.text(invalidTextFieldValue);
    expect(invalidTextFieldValueFinder, findsNothing);
  });
}
