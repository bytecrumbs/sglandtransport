import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/api.dart';
import 'models/bus_arrival_service_model.dart';

/// Provides the BusArrivalViewModel class
final busArrivalViewModelProvider =
    Provider((ref) => BusArrivalViewModel(ref.read));

/// The viewmodel for the BusArrival screen
class BusArrivalViewModel {
  /// a reader that enables reading other providers
  final Reader read;

  /// constructor for the model
  BusArrivalViewModel(this.read);

  /// returns bus arrival services, sorted by bus number
  Future<List<BusArrivalServiceModel>> getBusArrivalServiceList(
      String busStopCode) async {
    final _api = read(apiProvider);
    var busArrivalList = await _api.fetchBusArrivalList(busStopCode);

    busArrivalList.sort((var a, var b) =>
        int.parse(a.serviceNo.replaceAll(RegExp('\\D'), ''))
            .compareTo(int.parse(b.serviceNo.replaceAll(RegExp('\\D'), ''))));

    return busArrivalList;
  }
}
