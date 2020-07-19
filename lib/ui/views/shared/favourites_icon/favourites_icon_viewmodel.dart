import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:stacked/stacked.dart';

class FavouritesIconViewModel extends BaseViewModel {
  final _favouritesService = locator<FavouritesService>();
  final _busService = locator<BusService>();

  bool _isFavourited = false;
  bool get isFavourited => _isFavourited;

  Future<void> initialise(String busStopCode) async {
    _isFavourited = await _favouritesService.isFavouriteBusStop(busStopCode);
    notifyListeners();
  }

  void toggleFavourite(String busStopCode) {
    _isFavourited = !_isFavourited;
    notifyListeners();
    if (!_isFavourited) {
      _favouritesService.removeBusStop(busStopCode);
    } else {
      _favouritesService.addBusStop(busStopCode);
    }
    _busService.setFavouriteBusStops();
  }
}
