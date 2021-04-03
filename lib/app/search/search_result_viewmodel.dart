import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/database_service.dart';
import '../bus/models/bus_stop_model.dart';

/// Provides the SearchResultViewModel
final searchResultViewModelProvider =
    Provider((ref) => SearchResultViewModel(ref.read));

/// The view model for the SearchResultView class
class SearchResultViewModel {
  /// Constructor for the model
  SearchResultViewModel(this.read);

  /// A reader that enables reading other providers
  final Reader read;

  bool _containsSearchText(String value, String searchText) {
    final lowerCaseValue = value.toLowerCase();
    final lowerCaseSearchText = searchText.toLowerCase();
    return lowerCaseValue.contains(lowerCaseSearchText);
  }

  /// Searches the database for bus stops containing a given search text.
  /// Fields that are searched:
  /// - busStopCode
  /// - description
  /// - roadName
  Future<List<BusStopModel>> findBusStops(String searchText) async {
    final databaseService = read(databaseServiceProvider);
    final busStopSearchList = <BusStopModel>[];
    final allBusStops = await databaseService.getBusStops();

    if (searchText.isNotEmpty) {
      for (final currentBusStop in allBusStops) {
        final isTextMatching = _containsSearchText(
                currentBusStop.busStopCode, searchText) ||
            _containsSearchText(currentBusStop.description ?? '', searchText) ||
            _containsSearchText(currentBusStop.roadName, searchText);
        if (isTextMatching) {
          busStopSearchList.add(currentBusStop);
        }
      }
    }
    return busStopSearchList;
  }
}
