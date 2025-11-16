import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common_widgets/error_display.dart';
import '../../../common_widgets/main_content_margin.dart';
import '../../../custom_exception.dart';
import '../../bus_stops/data/bus_stops_repository.dart';
import '../../bus_stops/domain/bus_stop_value_model.dart';
import '../../bus_stops/presentation/bus_stop_card/bus_stop_card.dart';
import '../../home/presentation/dashboard_screen.dart';

part 'search_result.g.dart';

@riverpod
Future<List<BusStopValueModel>> searchResult(
  Ref ref, {
  required String searchTerm,
}) {
  if (searchTerm.isNotEmpty) {
    final busStopRepo = ref.watch(busStopsRepositoryProvider);

    return busStopRepo.findBusStops(searchTerm);
  } else {
    return Future.value(<BusStopValueModel>[]);
  }
}

class SearchResult extends ConsumerWidget {
  const SearchResult({super.key, required this.searchTerm});

  final String searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult = ref.watch(
      searchResultProvider(searchTerm: searchTerm),
    );
    return MainContentMargin(
      child: searchResult.when(
        data: (searchResult) => ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: searchResult.length,
          itemBuilder: (_, index) => ProviderScope(
            overrides: [
              busStopValueModelProvider.overrideWithValue(searchResult[index]),
            ],
            child: BusStopCard(searchTerm: searchTerm),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          if (error is CustomException) {
            return ErrorDisplay(message: error.message);
          }
          return ErrorDisplay(message: error.toString());
        },
      ),
    );
  }
}
