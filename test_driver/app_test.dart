import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('SG Land Transport App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    group('Buses', () {
      test('Should load the app', () async {
        await driver.runUnsynchronized(() async {
          await driver.waitFor(find.byValueKey('BottomBar'));
          await driver.tap(find.text('Buses'));
        });
      });

      test('Should switch between Nearby and Favorites', () async {
        await driver.runUnsynchronized(() async {
          await driver.waitFor(find.byValueKey('BottomBar'));
          await driver.tap(find.text('Nearby'));
          await driver.tap(find.text('Favorites'));
          await driver.tap(find.text('Nearby'));
        });
      });

      test('Should show bus arrival times for a given bus stop', () {});

      test('Should add a bus stop to Favorites', () {});

      test('Should remove a bus stop from Favorites', () {});

      test('Should open Search screen', () {});

      test('Should show a search result', () {});
    });
  });
}
