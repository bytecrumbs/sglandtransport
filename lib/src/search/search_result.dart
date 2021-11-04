import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../bus/bus_database_service.dart';
import '../bus/bus_repository.dart';
import '../bus/bus_stop_list_page_view.dart';
import '../bus/widgets/bus_stop_card.dart';
import '../shared/custom_exception.dart';
import '../shared/widgets/error_display.dart';

final searchResultFutureProvider = FutureProvider.autoDispose
    .family<List<BusStopValueModel>, String>((ref, searchTerm) async {
  if (searchTerm.isNotEmpty) {
    final busDatabaseService = ref.watch(busDatabaseServiceProvider);
    final tableBusStopList = await busDatabaseService.findBusStops(searchTerm);
    final busStopValueModelList = tableBusStopList
        .map((e) => BusStopValueModel(
              busStopCode: e.busStopCode,
              description: e.description,
              latitude: e.latitude,
              longitude: e.longitude,
              roadName: e.roadName,
            ))
        .toList();
    return busStopValueModelList;
  } else {
    return [];
  }
});

class SearchResult extends ConsumerWidget {
  const SearchResult({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  final String searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _searchResult = ref.watch(searchResultFutureProvider(searchTerm));
    return _searchResult.when(
      data: (searchResult) => ListView.builder(
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
      loading: (_) => const Center(child: CircularProgressIndicator()),
      error: (error, stack, _) {
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
