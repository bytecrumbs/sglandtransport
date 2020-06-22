import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/app/router.gr.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusFavouritesViewModel extends FutureViewModel<List<BusStopModel>> {
  final _navigationService = locator<NavigationService>();
  final _favouritesService = locator<FavouritesService>();
  final _busService = locator<BusService>();
  final String _title = 'Favourites';
  String get title => _title;

  @override
  Future<List<BusStopModel>> futureToRun() =>
      _busService.getFavouriteBusStops();

  Future<List<String>> addBusStop(String busStopCode) =>
      _favouritesService.addBusStop(busStopCode);

  Future<List<String>> removeBusStop(String busStopCode) =>
      _favouritesService.removeBusStop(busStopCode);

  Future navigateToBusArrival(String busStopCode, String description) async {
    await _navigationService.navigateTo(Routes.busArrivalView,
        arguments: BusArrivalViewArguments(
          busStopCode: busStopCode,
          description: description,
        ));
  }
}
