import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/application/bus_arrivals_service.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/domain/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/domain/bus_arrival_with_bus_stop_model.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/domain/next_bus_model.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/domain/bus_stop_value_model.dart';
import 'package:lta_datamall_flutter/src/local_storage/local_storage_keys.dart';
import 'package:lta_datamall_flutter/src/local_storage/local_storage_service.dart';
import 'package:lta_datamall_flutter/src/third_party_providers/third_party_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('BusArrivalsService should', () {
    ProviderContainer _setupContainer() {
      return ProviderContainer(
        overrides: [
          loggerProvider.overrideWithValue(
            Logger(
              level: Level.error,
            ),
          )
        ],
      );
    }

    ProviderContainer _setupWithSharedPreferences(
      Map<String, List<String>> stringList,
    ) {
      final values = stringList;
      SharedPreferences.setMockInitialValues(values);

      return _setupContainer();
    }

    test('Sort bus stops by distance in ascending order', () {
      // setup
      final container = _setupContainer();
      final busArrivalsService = container.read(busArrivalsServiceProvider);
      const awayDistance = 100;
      const nearDistance = 50;
      final listToTest = [
        BusArrivalWithBusStopModel(
          busStopValueModel: BusStopValueModel(
            busStopCode: '100100',
            roadName: 'Road Name 1',
            description: 'Description 1',
            latitude: 100,
            longitude: 500,
            distanceInMeters: awayDistance,
          ),
          services: [
            BusArrivalServiceModel(
              serviceNo: '354',
              busOperator: 'LTA',
              nextBus: NextBusModel(),
              nextBus2: NextBusModel(),
              nextBus3: NextBusModel(),
            ),
          ],
        ),
        BusArrivalWithBusStopModel(
          busStopValueModel: BusStopValueModel(
            busStopCode: '200200',
            roadName: 'Road Name 2',
            description: 'Description 2',
            latitude: 200,
            longitude: 600,
            distanceInMeters: nearDistance,
          ),
          services: [
            BusArrivalServiceModel(
              serviceNo: '354',
              busOperator: 'LTA',
              nextBus: NextBusModel(),
              nextBus2: NextBusModel(),
              nextBus3: NextBusModel(),
            ),
          ],
        ),
      ];

      // verify setup
      expect(listToTest[0].busStopValueModel.distanceInMeters, awayDistance);

      // run
      busArrivalsService.sortBusStopsByDistance(listToTest);

      // verify
      expect(listToTest[0].busStopValueModel.distanceInMeters, nearDistance);
    });

    test(
      '''
return true for isFavorite if the corresponding busStopCode and serviceNo is 
already stored as a favorite''',
      () async {
        const busStopCode = '515151';
        const serviceNo = '123';
        final values = <String, List<String>>{
          favoriteServiceNoKey: [
            '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo'
          ]
        };
        final container = _setupWithSharedPreferences(values);

        final busServicesService = container.read(busArrivalsServiceProvider);
        expect(
          await busServicesService.isFavorite(
            busStopCode: busStopCode,
            serviceNo: serviceNo,
          ),
          true,
        );
      },
    );
    test(
      '''
return false for isFavorite if the corresponding busStopCode and serviceNo is not
already stored as a favorite''',
      () async {
        const busStopCode = '515151';
        const serviceNo = '123';
        final values = <String, List<String>>{
          favoriteServiceNoKey: [
            '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo'
          ]
        };
        final container = _setupWithSharedPreferences(values);

        final busServicesService = container.read(busArrivalsServiceProvider);
        expect(
          await busServicesService.isFavorite(
            busStopCode: '000000',
            serviceNo: '000',
          ),
          false,
        );
      },
    );
    test(
      '''
add the bus service to the favorites list and and return true if the
bus service is not a favourite yet''',
      () async {
        const busStopCode = '515151';
        const serviceNo = '123';
        final values = <String, List<String>>{
          favoriteServiceNoKey: [
            '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo'
          ]
        };
        final container = _setupWithSharedPreferences(values);
        final busServicesService = container.read(busArrivalsServiceProvider);

        // setup new favorite to add
        const newBusStopCode = '000000';
        const newServiceNo = '000';
        const newKeyValue =
            '$newBusStopCode$busStopCodeServiceNoDelimiter$newServiceNo';

        final localStorageService = container.read(localStorageServiceProvider);

        // ensure new key is not in the list yet
        final currentFavouritesList =
            await localStorageService.getStringList(favoriteServiceNoKey);
        expect(
          currentFavouritesList.contains(newKeyValue),
          false,
        );

        final result = await busServicesService.toggleFavoriteBusService(
          busStopCode: newBusStopCode,
          serviceNo: newServiceNo,
        );
        // ensure the return value is right
        expect(
          result,
          true,
        );
        // ensure the favorite is added to the list
        final newFavouritesList =
            await localStorageService.getStringList(favoriteServiceNoKey);
        expect(
          newFavouritesList.contains(newKeyValue),
          true,
        );
      },
    );
    test(
      '''
remove the bus service from the favorites list and return false if the
bus service is already a favourite''',
      () async {
        const busStopCode = '515151';
        const serviceNo = '123';
        const newBusStopCode = '000000';
        const newServiceNo = '000';
        final values = <String, List<String>>{
          favoriteServiceNoKey: [
            '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo',
            '$newBusStopCode$busStopCodeServiceNoDelimiter$newServiceNo'
          ]
        };
        final container = _setupWithSharedPreferences(values);
        final busServicesService = container.read(busArrivalsServiceProvider);

        // setup new favorite to add

        const keyValueUnderTest =
            '$newBusStopCode$busStopCodeServiceNoDelimiter$newServiceNo';

        final localStorageService = container.read(localStorageServiceProvider);

        // ensure new key is in the list yet
        final currentFavouritesList =
            await localStorageService.getStringList(favoriteServiceNoKey);
        expect(
          currentFavouritesList.contains(keyValueUnderTest),
          true,
        );

        final result = await busServicesService.toggleFavoriteBusService(
          busStopCode: newBusStopCode,
          serviceNo: newServiceNo,
        );
        // ensure the return value is right
        expect(
          result,
          false,
        );
        // ensure the favorite is added to the list
        final newFavouritesList =
            await localStorageService.getStringList(favoriteServiceNoKey);
        expect(
          newFavouritesList.contains(keyValueUnderTest),
          false,
        );
      },
    );
  });
}
