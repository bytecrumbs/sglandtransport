import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'utils.dart';

dynamic searchForText(String searchText, dynamic driver) async {
  await driver.tap(find.byValueKey('searchInput'));
  await driver.enterText(searchText);
}

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

    group('Search', () {
      test('Checks that bus stop can be searched by description', () async {
        await driver.tap(find.byValueKey('searchScreen'));
        searchForText('Opp Holiday Inn', driver);
        await driver.waitFor(busStopCard);
        expect(await isRendered(busStopCard, driver), true);
      });

      test('Clicks on bus stop to see a list of bus arrivals', () async {
        await driver.tap(busStopCard);
        expect(await isRendered(find.byValueKey('busArrivalCard-0'), driver),
            true);
      });

      test('Checks that favorite bus can be added and removed', () async {
        expect(await isRendered(unselectedFavoriteIcon, driver), true);
        expect(await isRendered(selectedFavoriteIcon, driver), false);

        await driver.tap(favoriteIconButton);

        expect(await isRendered(unselectedFavoriteIcon, driver), false);
        expect(await isRendered(selectedFavoriteIcon, driver), true);

        await driver.tap(find.pageBack());
      });

      test('Checks that bus stop can be searched by bus code', () async {
        await driver.tap(find.byValueKey('searchInput'));
        searchForText('01012', driver);
        await driver.waitFor(busStopCard);
        expect(await isRendered(busStopCard, driver), true);
      });

      test('Checks that bus stop can be searched by road name', () async {
        await driver.tap(find.byValueKey('searchInput'));
        searchForText('Victoria St', driver);
        await driver.waitFor(busStopCard);
        expect(await isRendered(busStopCard, driver), true);
      });

      test('Checks that input text can be cleared', () async {
        await driver.tap(find.byValueKey('clearSearchInput'));
        expect(await isRendered(busStopCard, driver), false);
      });
    });

    group('Favorites', () {
      test('Checks that bus stop is present in favorite screen', () async {
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
