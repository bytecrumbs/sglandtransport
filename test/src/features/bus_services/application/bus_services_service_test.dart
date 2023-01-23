import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/constants/local_storage_keys.dart';
import 'package:lta_datamall_flutter/src/features/bus_services/application/bus_services_service.dart';
import 'package:lta_datamall_flutter/src/shared/application/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('BusServicesService should', () {
    group('for isFavorite', () {
      Future<ProviderContainer> _setup(
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
          ],
        );
      }

      test(
        '''
return true if the corresponding busStopCode and serviceNo is 
already stored as a favorite''',
        () async {
          const busStopCode = '515151';
          const serviceNo = '123';
          final values = <String, List<String>>{
            favoriteServiceNoKey: [
              '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo'
            ]
          };
          final container = await _setup(values);

          final busServicesService = container.read(busServicesServiceProvider);
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
return false if the corresponding busStopCode and serviceNo is not
already stored as a favorite''',
        () async {
          const busStopCode = '515151';
          const serviceNo = '123';
          final values = <String, List<String>>{
            favoriteServiceNoKey: [
              '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo'
            ]
          };
          final container = await _setup(values);

          final busServicesService = container.read(busServicesServiceProvider);
          expect(
            busServicesService.isFavorite(
              busStopCode: '000000',
              serviceNo: serviceNo,
            ),
            false,
          );
        },
      );
    });
  });
}
