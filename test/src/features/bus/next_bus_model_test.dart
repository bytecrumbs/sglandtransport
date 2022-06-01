import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/features/bus/bus_repository.dart';
import 'package:lta_datamall_flutter/src/shared/palette.dart';

void main() {
  group('NextBusModel should', () {
    test('show "n/a" when no estimated arrival is present', () {
      final nextBusModel = NextBusModel(estimatedArrivalAbsolute: '');
      expect(nextBusModel.getEstimatedArrival(), 'n/a');
      final nextBusModelNull = NextBusModel();
      expect(nextBusModelNull.getEstimatedArrival(), 'n/a');
    });
    test('show that bus has arrived if arrival time is less than 1 minutes',
        () {
      final arrivalTimeNow = DateTime.now().toUtc().toIso8601String();
      final nextBusModelNow =
          NextBusModel(estimatedArrivalAbsolute: arrivalTimeNow);
      expect(nextBusModelNow.getEstimatedArrival(), 'Arr');
      final arrivalTime59Seconds = DateTime.now()
          .toUtc()
          .add(const Duration(seconds: 59))
          .toIso8601String();
      final nextBusModel59Seconds =
          NextBusModel(estimatedArrivalAbsolute: arrivalTime59Seconds);
      expect(nextBusModel59Seconds.getEstimatedArrival(), 'Arr');
    });
    test(
        'show that bus arrives within 1 minute if arrival time is between 1 and 2 minutes',
        () {
      final arrivalTime1Minute = DateTime.now()
          .toUtc()
          .add(const Duration(minutes: 1))
          .toIso8601String();
      final nextBusModel1Minute =
          NextBusModel(estimatedArrivalAbsolute: arrivalTime1Minute);
      expect(nextBusModel1Minute.getEstimatedArrival(), '1min');
      final arrivalTime1Minute59Seconds = DateTime.now()
          .toUtc()
          .add(const Duration(minutes: 1, seconds: 59))
          .toIso8601String();
      final nextBusModel1Minute59Seconds =
          NextBusModel(estimatedArrivalAbsolute: arrivalTime1Minute59Seconds);
      expect(nextBusModel1Minute59Seconds.getEstimatedArrival(), '1min');
    });
    test(
        'show that bus arrives within 2 minutes if arrival time is between 2 and 3 minutes',
        () {
      final arrivalTime2Minute = DateTime.now()
          .toUtc()
          .add(const Duration(minutes: 2))
          .toIso8601String();
      final nextBusModel2Minute =
          NextBusModel(estimatedArrivalAbsolute: arrivalTime2Minute);
      expect(nextBusModel2Minute.getEstimatedArrival(), '2min');
      final arrivalTime2Minute59Seconds = DateTime.now()
          .toUtc()
          .add(const Duration(minutes: 2, seconds: 59))
          .toIso8601String();
      final nextBusModel2Minute59Seconds =
          NextBusModel(estimatedArrivalAbsolute: arrivalTime2Minute59Seconds);
      expect(nextBusModel2Minute59Seconds.getEstimatedArrival(), '2min');
    });

    test('show correct color when seats are available ', () {
      final nextBusModel = NextBusModel(load: 'SEA');
      final loadColor = nextBusModel.getLoadColor();
      expect(loadColor, kLoadSeatsAvailable);
    });
    test('show correct color when standing is available ', () {
      final nextBusModel = NextBusModel(load: 'SDA');
      final loadColor = nextBusModel.getLoadColor();
      expect(loadColor, kLoadStandingAvailable);
    });
    test('show correct color when standing is limited ', () {
      final nextBusModel = NextBusModel(load: 'LDS');
      final loadColor = nextBusModel.getLoadColor();
      expect(loadColor, kLoadLimitedStanding);
    });
  });
}
