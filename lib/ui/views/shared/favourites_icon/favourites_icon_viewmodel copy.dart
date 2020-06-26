import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:stacked/stacked.dart';

class FavouritesIconViewModel extends ReactiveViewModel {
  final _favouritesService = locator<FavouritesService>();
  final _busService = locator<BusService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_busService];

  String _busStopCode;

  bool _isFavourited = false;
  bool get isFavourited => _isFavourited;

  Future<void> initialize(String busStopCode) async {
    _busStopCode = busStopCode;
    _isFavourited = await _favouritesService.isFavouriteBusStop(busStopCode);
    notifyListeners();
  }

  void toggleFavourite() async {
    print('toggle');
    _isFavourited = !_isFavourited;
    if (!_isFavourited) {
      await _favouritesService.removeBusStop(_busStopCode);
    } else {
      await _favouritesService.addBusStop(_busStopCode);
    }
    await _busService.setFavouriteBusStops();
    notifyListeners();
  }
}
