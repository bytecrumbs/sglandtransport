import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusStopViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future navigateToBusArrival(String busStopCode, String description) async {
    await _navigationService.navigateTo(
      Routes.busArrivalView,
      arguments: BusArrivalViewArguments(
        busStopCode: busStopCode,
        description: description,
      ),
    );
  }
}
