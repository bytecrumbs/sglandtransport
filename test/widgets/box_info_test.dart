import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/widgets/box_info.dart';

void main() {
  const Widget widget = BoxInfo(
    child: Text('Info', textDirection: TextDirection.ltr),
    color: Colors.white,
  );

  testWidgets('Displays box information', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    expect(find.text('Info'), findsOneWidget);
  });
}
