import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/src/constants/local_storage_keys.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/application/bus_arrivals_service.dart';
import 'package:lta_datamall_flutter/src/shared/application/local_storage_service.dart';
import 'package:lta_datamall_flutter/src/shared/third_party_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('BusServicesService should', () {
    Future<ProviderContainer> _setupWithSharedPreferences(
      Map<String, List<String>> stringList,
    ) async {
      final values = stringList;
      SharedPreferences.setMockInitialValues(values);

      final sharedPreferences = await SharedPreferences.getInstance();

      return ProviderContainer(
        overrides: [
          localStorageServiceProvider.overrideWithValue(
            LocalStorageService(sharedPreferences),
          ),
          loggerProvider.overrideWithValue(
            Logger(
              level: Level.error,
            ),
          )
        ],
      );
    }

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
        final container = await _setupWithSharedPreferences(values);

        final busServicesService = container.read(busArrivalsServiceProvider);
        expect(
          busServicesService.isFavorite(
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
        final container = await _setupWithSharedPreferences(values);

        final busServicesService = container.read(busArrivalsServiceProvider);
        expect(
          busServicesService.isFavorite(
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
        final container = await _setupWithSharedPreferences(values);
        final busServicesService = container.read(busArrivalsServiceProvider);

        // setup new favorite to add
        const newBusStopCode = '000000';
        const newServiceNo = '000';
        const newKeyValue =
            '$newBusStopCode$busStopCodeServiceNoDelimiter$newServiceNo';

        final localStorageService = container.read(localStorageServiceProvider);

        // ensure new key is not in the list yet
        final currentFavouritesList =
            localStorageService.getStringList(favoriteServiceNoKey);
        expect(
          currentFavouritesList.contains(newKeyValue),
          false,
        );

        final result = busServicesService.toggleFavoriteBusService(
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
            localStorageService.getStringList(favoriteServiceNoKey);
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
        final container = await _setupWithSharedPreferences(values);
        final busServicesService = container.read(busArrivalsServiceProvider);

        // setup new favorite to add

        const keyValueUnderTest =
            '$newBusStopCode$busStopCodeServiceNoDelimiter$newServiceNo';

        final localStorageService = container.read(localStorageServiceProvider);

        // ensure new key is in the list yet
        final currentFavouritesList =
            localStorageService.getStringList(favoriteServiceNoKey);
        expect(
          currentFavouritesList.contains(keyValueUnderTest),
          true,
        );

        final result = busServicesService.toggleFavoriteBusService(
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
            localStorageService.getStringList(favoriteServiceNoKey);
        expect(
          newFavouritesList.contains(keyValueUnderTest),
          false,
        );
      },
    );
  });
}
