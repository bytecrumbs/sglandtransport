import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/database_service.dart';

@lazySingleton
class BusService {
  static final _log = Logger('BusService');

  final _databaseService = locator<DatabaseService>();

  Future<List<BusStopModel>> getNearbyBusStops() {
    _log.info('getting bus stops');
    final userLocation = UserLocation(latitude: 1.29785, longitude: 103.853);
    return _databaseService.getBusStopsByLocation(
        userLocation.latitude, userLocation.latitude);
  }
}
