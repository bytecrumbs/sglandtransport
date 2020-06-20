import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/app/router.gr.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusFavouritesViewModel extends FutureViewModel<List<String>> {
  final _navigationService = locator<NavigationService>();
  final _favouritesService = locator<FavouritesService>();
  final String _title = 'Favourites';
  String get title => _title;

  // Future<List<String>> get favouriteBusStops => futureToRun();

  @override
  Future<List<String>> futureToRun() =>
      _favouritesService.getFavouriteBusStops();

  Future<List<String>> addBusStop(String busStopCode) =>
      _favouritesService.addBusStop(busStopCode);

  Future<List<String>> removeBusStop(String busStopCode) =>
      _favouritesService.removeBusStop(busStopCode);

  Future navigateToBusArrival() async {
    await _navigationService.navigateTo(Routes.busArrivalView);
  }
}
