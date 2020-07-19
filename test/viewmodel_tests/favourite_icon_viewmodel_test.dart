import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/ui/views/shared/favourites_icon/favourites_icon_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../setup/test_helpers.dart';

void main() {
  group('FavouriteIconViewModel -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());
    group('isFavourited -', () {
      test('When constructed should be set to false', () {
        var model = FavouritesIconViewModel();
        expect(model.isFavourited, false);
      });
      test('When toggled should invert the value', () {
        var favouritesService = getAndRegisterFavouritesServiceMock();
        var model = FavouritesIconViewModel();
        var busStopNo = '01019';
        model.toggleFavourite(busStopNo);
        expect(model.isFavourited, true);
        verify(favouritesService.addBusStop(busStopNo));
        model.toggleFavourite(busStopNo);
        expect(model.isFavourited, false);
        verify(favouritesService.removeBusStop(busStopNo));
      });
      test('When toggled should call the bus service and setBusStopFavourites',
          () {
        var busService = getAndRegisterBusServiceMock();
        var model = FavouritesIconViewModel();
        model.toggleFavourite('01019');
        verify(busService.setFavouriteBusStops());
      });
    });
    group('initialise -', () {
      test(
          'When called should check with favourites service if bus stop is already favourited',
          () async {
        var favouritesService = getAndRegisterFavouritesServiceMock();
        var model = FavouritesIconViewModel();
        var busStopCode = '01019';
        await model.initialise(busStopCode);
        verify(favouritesService.isFavouriteBusStop(busStopCode));
      });
      test('When called should update isFavourited', () async {
        var busStopCode = '01019';
        var isFavourite = true;
        getAndRegisterFavouritesServiceMock(
          isFavouriteReturnValue: isFavourite,
          busStopCode: busStopCode,
        );
        var model = FavouritesIconViewModel();
        await model.initialise(busStopCode);
        expect(model.isFavourited, isFavourite);
      });
    });
  });
}
