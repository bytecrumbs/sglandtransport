import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common_widgets/error_display.dart';
import '../../../custom_exception.dart';
import '../../../database/database.dart';
import '../../bus_stops/domain/bus_stop_value_model.dart';
import '../../bus_stops/presentation/bus_stop_card/bus_stop_card.dart';
import '../../home/presentation/dashboard_screen.dart';

part 'search_result.g.dart';

@riverpod
Future<List<BusStopValueModel>> searchResult(
  SearchResultRef ref, {
  required String searchTerm,
}) {
  if (searchTerm.isNotEmpty) {
    final busDatabaseService = ref.watch(appDatabaseProvider);

    return busDatabaseService.findBusStops(searchTerm);
  } else {
    return Future.value(<BusStopValueModel>[]);
  }
}

class SearchResult extends ConsumerWidget {
  const SearchResult({
    super.key,
    required this.searchTerm,
  });

  final String searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult =
        ref.watch(searchResultProvider(searchTerm: searchTerm));
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
