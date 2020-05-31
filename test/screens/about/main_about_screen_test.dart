import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/about/main_about_screen.dart';

void main() {
  Future<void> _pumpMainAboutScreen(WidgetTester tester) async {
    return await tester.pumpWidget(
      MaterialApp(
        home: MainAboutScreen(),
      ),
    );
  }

  testWidgets('Shows an Official Links header', (WidgetTester tester) async {
    await _pumpMainAboutScreen(tester);
    final labelFinder = find.text('Official Links');
    expect(labelFinder, findsOneWidget);
  });
}
