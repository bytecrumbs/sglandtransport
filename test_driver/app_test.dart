import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'utils.dart';

void main() {
  group('LTA App', () {
    final SerializableFinder unselectedFavoriteIcon =
        find.byValueKey('favoriteIconUnselected');
    final SerializableFinder selectedFavoriteIcon =
        find.byValueKey('favoriteIconSelected');
    final SerializableFinder busStopCard = find.byValueKey('busStopCard-0');
    final SerializableFinder favoriteIconButton =
        find.byValueKey('favoriteIconButton');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Clicks on a given bus stop and see a list of bus arrivals', () async {
      await driver.tap(busStopCard);

      expect(
          await isRendered(find.byValueKey('busArrivalCard-0'), driver), true);
    });

    group('Favorites', () {
      test('Checks that favorite bus can be added and removed', () async {
        expect(await isRendered(unselectedFavoriteIcon, driver), true);
        expect(await isRendered(selectedFavoriteIcon, driver), false);

        await driver.tap(favoriteIconButton);

        expect(await isRendered(unselectedFavoriteIcon, driver), false);
        expect(await isRendered(selectedFavoriteIcon, driver), true);
      });

      test('Checks that bus stop is present in favorite screen', () async {
        await driver.tap(find.pageBack());
        await driver.tap(find.byValueKey('favoriteScreen'));
        expect(await isRendered(busStopCard, driver), true);
      });

      test(
          'Checks that bus stop is not present when bus stop is removed from favorites',
          () async {
        await driver.tap(busStopCard);
        await driver.tap(favoriteIconButton);
        await driver.tap(find.pageBack());
        expect(await isRendered(busStopCard, driver), false);
      });
    });
  });
}
