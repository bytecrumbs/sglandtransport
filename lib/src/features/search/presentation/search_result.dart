import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/custom_exception.dart';
import '../../../shared/presentation/error_display.dart';
import '../../bus_stops/data/bus_local_repository.dart';
import '../../bus_stops/domain/bus_stop_value_model.dart';
import '../../bus_stops/presentation/bus_stop_card/bus_stop_card.dart';
import '../../home/presentation/dashboard_screen.dart';

final searchResultFutureProvider = FutureProvider.autoDispose
    .family<List<BusStopValueModel>, String>((ref, searchTerm) async {
  if (searchTerm.isNotEmpty) {
    final busDatabaseService = ref.watch(busDatabaseServiceProvider);
    final tableBusStopList = await busDatabaseService.findBusStops(searchTerm);
    final busStopValueModelList = tableBusStopList
        .map(
          (e) => BusStopValueModel(
            busStopCode: e.busStopCode,
            description: e.description,
            latitude: e.latitude,
            longitude: e.longitude,
            roadName: e.roadName,
          ),
        )
        .toList();
    return busStopValueModelList;
  } else {
    return [];
  }
});

class SearchResult extends ConsumerWidget {
  const SearchResult({
    super.key,
    required this.searchTerm,
  });

  final String searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult = ref.watch(searchResultFutureProvider(searchTerm));
    return searchResult.when(
      data: (searchResult) => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: searchResult.length,
        itemBuilder: (_, index) => ProviderScope(
          overrides: [
            busStopValueModelProvider.overrideWithValue(searchResult[index])
          ],
          child: BusStopCard(
            searchTerm: searchTerm,
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        if (error is CustomException) {
          return ErrorDisplay(message: error.message);
        }
        return ErrorDisplay(
          message: error.toString(),
        );
      },
    );
  }
}
