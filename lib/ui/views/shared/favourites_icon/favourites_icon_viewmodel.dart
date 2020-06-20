import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:stacked/stacked.dart';

class FavouritesIconViewModel extends BaseViewModel {
  final _favouritesService = locator<FavouritesService>();

  String _busStopCode;

  bool _isFavourited = false;
  bool get isFavourited => _isFavourited;

  Future<void> initialize(String busStopCode) async {
    _busStopCode = busStopCode;
    _isFavourited = await _favouritesService.isFavouriteBusStop(busStopCode);
    notifyListeners();
  }

  void toggleFavourite() {
    _isFavourited = !_isFavourited;
    notifyListeners();
    if (!_isFavourited) {
      _favouritesService.removeBusStop(_busStopCode);
    } else {
      _favouritesService.addBusStop(_busStopCode);
    }
  }
}
