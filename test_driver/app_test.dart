import 'package:flutter_driver/flutter_driver.dart';
import 'package:screenshots/screenshots.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('SG Land Transport App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await setupAndGetDriver();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    group('Buses', () {
      final busStopCardFinder = find.byValueKey('busStopCard-0');
      final busArrivalCardFinder = find.byValueKey('busArrivalCard-0');
      final nearbyBottomBarFinder = find.text('Nearby');
      final favouriteBottomBarFinder = find.text('Favorites');
      final favouriteIconButtonFinder = find.byValueKey('favouriteIconButton');
      final noFavouriteBusStopsFoundFinder =
          find.byValueKey('noFavouriteBusStopsFound');
      final searchIconButtonFinder = find.byValueKey('searchIconButton');

      test('Should load the app', () async {
        final config = Config();
        await driver.waitFor(busStopCardFinder);
        await screenshot(driver, config, '01-nearbyBusStops');
      });

      test('Should switch between Nearby and Favorites', () async {
        await driver.tap(favouriteBottomBarFinder);
        await driver.tap(nearbyBottomBarFinder);
        await driver.waitFor(busStopCardFinder);
      });

      test('Should show bus arrival times for a given bus stop', () async {
        final config = Config();
        await driver.waitFor(busStopCardFinder);
        await driver.tap(busStopCardFinder);
        await driver.waitFor(busArrivalCardFinder);
        await screenshot(driver, config, '03-busArrivals');
      });

      test('Should add a bus stop to Favorites', () async {
        final config = Config();
        await driver.tap(favouriteIconButtonFinder);
        await driver.tap(find.pageBack());
        await driver.tap(favouriteBottomBarFinder);
        await driver.waitFor(busStopCardFinder);
        await screenshot(driver, config, '02-favouriteBusStops');
      });

      test('Should remove a bus stop from Favorites', () async {
        await driver.tap(busStopCardFinder);
        await driver.waitFor(busArrivalCardFinder);
        await driver.tap(favouriteIconButtonFinder);
        await driver.tap(find.pageBack());
        await driver.waitFor(noFavouriteBusStopsFoundFinder);
      });

      test('Should open Search screen', () async {
        await driver.tap(searchIconButtonFinder);
        await driver.waitFor(find.byType('TextField'));
      });

      test('Should show a search result', () async {
        final config = Config();
        await driver.tap(find.byType('TextField'));
        await driver.enterText('hotel');
        await driver.waitFor(busStopCardFinder);
        await screenshot(driver, config, '05-searchResult');
      });
    });
  });
}
