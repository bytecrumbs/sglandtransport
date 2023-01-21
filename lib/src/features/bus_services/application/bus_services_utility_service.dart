import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bus_stops/data/bus_local_repository.dart';
import '../domain/bus_arrival_service_model.dart';

final busServicesUtilityServiceProvider =
    Provider<BusServicesUtilityService>(BusServicesUtilityService.new);

class BusServicesUtilityService {
  BusServicesUtilityService(this._ref);

  final Ref _ref;

  Future<List<BusArrivalServiceModel>> addDestination({
    required List<BusArrivalServiceModel> busArrivals,
  }) async {
    // get a list of all bus service nos
    final busArrivalsDestinationCode =
        busArrivals.map((e) => e.nextBus.destinationCode ?? '').toList();

    // fetch all bus stops as per the busArrivals list
    final busStops = await _ref
        .read(busDatabaseServiceProvider)
        .getBusStops(busStopCodes: busArrivalsDestinationCode);

    // add the destination to the busArrivals list
    final busArrivalsWithDestination = <BusArrivalServiceModel>[];
    for (final busArrival in busArrivals) {
      final destination = busStops
          .where(
            (element) =>
                element.busStopCode == busArrival.nextBus.destinationCode,
          )
          .toList();
      if (destination.isNotEmpty) {
        busArrivalsWithDestination.add(
          busArrival.copyWith(
            destinationName: destination[0].description ?? '',
          ),
        );
      } else {
        busArrivalsWithDestination.add(busArrival);
      }
    }
    return busArrivalsWithDestination;
  }
}
