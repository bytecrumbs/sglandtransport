import 'package:flutter_test/flutter_test.dart';

import '../../bus_arrivals_robot.dart';

void main() {
  group('FavoriteToggler should', () {
    testWidgets('show as favorite if it is set as favorite', (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpFavoriteTogglerWithActivatedFavorite();
      r.expectFindFavoriteIndicator();
    });

    testWidgets('show not as favorite if it is not set as favorite',
        (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpFavoriteTogglerWithoutFavorite();
      r.expectFindNoFavoriteIndicator();
    });
    testWidgets('toggle favorite indicator', (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpFavoriteTogglerWithoutFavorite();
      r.expectFindNoFavoriteIndicator();

      await r.tapFavoriteButton();
      r.expectFindFavoriteIndicator();

      await r.tapFavoriteButton();
      r.expectFindNoFavoriteIndicator();
    });
  });
}
