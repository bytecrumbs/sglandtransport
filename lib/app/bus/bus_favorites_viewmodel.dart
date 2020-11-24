import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../../services/database_service.dart';
import '../../services/local_storage_service.dart';
import 'models/bus_stop_model.dart';

/// Provider the BusFavoritesViewModel class
final busFavoritesViewModelProvider =
    Provider((ref) => BusFavoritesViewModel(ref.read));

/// The view model class for the BusFavoritesView
class BusFavoritesViewModel {
  /// constructor for the model
  BusFavoritesViewModel(this.read);

  /// a reader that enables reading other providers
  final Reader read;

  static final _log = Logger('BusFavoritesViewModel');

  // TODO: this is duplicated in several files...
  /// the key which we are going to use to store the favorite bus stops
  static const favoriteBusStopsKey = 'favouriteBusStopsKey';

  /// Gets all the favorited bus stops by first fetching the bus stop codes
  /// from the local storage and then the details of each bus stop from
  /// the local database
  Future<List<BusStopModel>> getFavoriteBusStops() async {
    _log.info('getting all favourite bus stops');
    final databaseService = read(databaseServiceProvider);
    final localStorageService = read(localStorageServiceProvider);
    final favoriteBusStopStringList =
        await localStorageService.getStringList(favoriteBusStopsKey);
    return await databaseService.getBusStops(favoriteBusStopStringList);
  }
}
