import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/data/local_db_repository.dart';
import '../domain/bus_route_with_bus_stop_info_model.dart';

part 'bus_routes_service.g.dart';

@riverpod
BusRoutesService busRoutesService(BusRoutesServiceRef ref) =>
    BusRoutesService(ref);

class BusRoutesService {
  BusRoutesService(this.ref);

  final Ref ref;

  Future<List<BusRouteWithBusStopInfoModel>> getBusRoute({
    required String busStopCode,
    required String originCode,
    required String destinationCode,
    required String serviceNo,
  }) async {
    final repository = ref.read(localDbRepositoryProvider);

    final busRoutes = await repository.getBusRoute(
      busStopCode: busStopCode,
      serviceNo: serviceNo,
      originCode: originCode,
      destinationCode: destinationCode,
    );

    // add an additional item at the beginning of the list, which indicates
    // how many bus stops are there prior to the current bus stop, unless it
    // is the first bus stop of the route
    return busRoutes[0].stopSequence == 1
        ? busRoutes
        : [
            BusRouteWithBusStopInfoModel(
              isPreviousStops: true,
              serviceNo: '',
              direction: 1,
              stopSequence: 0,
              distance: 0,
              busStopCode: '',
              roadName: '',
              description: '${busRoutes[0].stopSequence - 1} previous stops',
              latitude: 1,
              longitude: 2,
            ),
            ...busRoutes
          ];
  }
}
