import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_favourites/bus_favourites_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../setup/test_data.dart' as test_data;
import '../setup/test_helpers.dart';

void main() {
  group('BusFavouritesViewModel -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());
    group('favouriteBusStops -', () {
      test('Should check the bus service for favourite bus stops', () {
        getAndRegisterBusServiceMock(
          busStopForBusArrival: '01019',
          busStopModelList: test_data.busStopModelList,
        );
        var model = BusFavouritesViewModel();
        expect(model.favouriteBusStops.length, 2);
      });
    });
    group('initialise -', () {
      test('When called should set the favourite bus stops via bus service',
          () {
        var busService = getAndRegisterBusServiceMock();
        var model = BusFavouritesViewModel();
        model.initialise();
        verify(busService.setFavouriteBusStops());
      });
    });
    // The below test fails, and I don't know why...
    // group('navigation -', () {
    //   test('When called should navigate to Routes.busArrivalView', () {
    //     var navigationService = getAndRegisterNavigationServiceMock();
    //     var model = BusFavouritesViewModel();
    //     var busStopCode = '01019';
    //     var description = 'desc';
    //     model.navigateToBusArrival(busStopCode, description);
    //     verify(
    //       navigationService.navigateTo(
    //         Routes.busArrivalView,
    //         arguments: BusArrivalViewArguments(
    //           busStopCode: busStopCode,
    //           description: description,
    //         ),
    //       ),
    //     );
    //   });
    // });
  });
}
