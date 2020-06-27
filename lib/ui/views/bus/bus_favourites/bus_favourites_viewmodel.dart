import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/app/router.gr.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusFavouritesViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _busService = locator<BusService>();

  List<BusStopModel> get favouriteBusStops => _busService.favouriteBusStops;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_busService];

  Future<void> initialize() async {
    await _busService.setFavouriteBusStops();
  }

  Future navigateToBusArrival(String busStopCode, String description) async {
    await _navigationService.navigateTo(Routes.busArrivalView,
        arguments: BusArrivalViewArguments(
          busStopCode: busStopCode,
          description: description,
        ));
  }
}
