import 'package:flutter_test/flutter_test.dart';

class HomeRobot {
  HomeRobot(this.tester);

  final WidgetTester tester;

  void expectAppTitleToBeShown() {
    expect(find.text('SG Land Transport'), findsOneWidget);
  }
}
