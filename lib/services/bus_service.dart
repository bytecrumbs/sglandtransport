import 'package:injectable/injectable.dart';
import 'package:latlong/latlong.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/services/database_service.dart';
import 'package:http/io_client.dart' as http;

@lazySingleton
class BusService {
  static final _log = Logger('BusService');
  final _databaseService = locator<DatabaseService>();
  final _api = locator<Api>();

  Future<List<BusStopModel>> getNearbyBusStopsByLocation(
      UserLocation userLocation) async {
    final nearbyBusStops = <BusStopModel>[];
    final distance = Distance();

    if (userLocation != null && userLocation.permissionGranted) {
      var allBusStops = await _getBusStopsByLocation();

      allBusStops.forEach((busStop) {
        final distanceInMeters = distance(
          LatLng(userLocation.latitude, userLocation.longitude),
          LatLng(busStop.latitude, busStop.longitude),
        );
        if (distanceInMeters <= 500) {
          busStop.distanceInMeters = distanceInMeters.round();
          nearbyBusStops.add(busStop);
        }
      });

      nearbyBusStops.sort((BusStopModel a, BusStopModel b) =>
          a.distanceInMeters.compareTo(b.distanceInMeters));
    }

    return nearbyBusStops;
  }

  Future<List<BusArrivalServiceModel>> getBusArrivalServices(
      String busStopCode) async {
    _log.info('getting bus arrival list for bus stop $busStopCode');
    final busArrivalServiceListModel =
        await _api.fetchBusArrivalList(http.IOClient(), busStopCode);
    var busServicesFromApi = busArrivalServiceListModel.services;
    _log.info('getting all bus services for $busStopCode from bus routes DB');
    var busServicesFromBusRoutes =
        await _databaseService.getBusRoutes(busStopCode);

    // add services not in use to the original api result
    if (busServicesFromApi.length < busServicesFromBusRoutes.length) {
      final busServicesFromApiList =
          busServicesFromApi.map((e) => e.serviceNo).toList();
      final busServicesFromBusRoutesList =
          busServicesFromBusRoutes.map((e) => e.serviceNo).toList();

      final busNoDifferences = busServicesFromBusRoutesList
          .toSet()
          .difference(busServicesFromApiList.toSet())
          .toList();

      busNoDifferences.forEach((element) {
        final missingBusArrivalServiceModel = BusArrivalServiceModel(
          serviceNo: element,
          inService: false,
        );
        busServicesFromApi.add(missingBusArrivalServiceModel);
      });

      // sort bus arrival by bus number
      busServicesFromApi.sort((BusArrivalServiceModel a,
              BusArrivalServiceModel b) =>
          int.parse(a.serviceNo.replaceAll(RegExp('\\D'), ''))
              .compareTo(int.parse(b.serviceNo.replaceAll(RegExp('\\D'), ''))));
    }
    return busServicesFromApi;
  }

  Future<void> addBusRoutesToDb() async {
    _log.info('checking if table is empty');
    var count = await _databaseService.getBusRoutesCount();
    if (count == 0) {
      _log.info('fetching bus routes from server');
      var busRoutes = await _api.fetchBusRoutes(http.IOClient());
      _log.info('adding bus routes information into DB');
      _databaseService.insertBusRoutes(busRoutes);
    }
  }

  Future<List<BusStopModel>> _getBusStopsByLocation() async {
    var data = await _databaseService.getBusStopsByLocation();
    return data.isNotEmpty ? data : _fetchBusStopsFromServer();
  }

  Future<List<BusStopModel>> _fetchBusStopsFromServer() async {
    final busStops = await _api.fetchBusStopList(http.IOClient());
    _databaseService.insertBusStops(busStops);
    return busStops;
  }
}
