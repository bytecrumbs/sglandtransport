import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/error_view.dart';
import '../bus/bus_stop_card.dart';
import '../bus/models/bus_stop_model.dart';
import '../failure.dart';
import 'search_result_viewmodel.dart';

/// Provides a list of bus stops with the containing the given search term
final searchResultFutureProvider = FutureProvider.autoDispose
    .family<List<BusStopModel>, String>((ref, searchTerm) async {
  final vm = ref.read(searchResultViewModelProvider);
  return vm.findBusStops(searchTerm);
});

/// Shows the serach results
class SearchResultView extends HookWidget {
  /// The term the bus stop should be searched for
  final String searchTerm;

  /// Constructor for the class
  SearchResultView({@required this.searchTerm});

  @override
  Widget build(BuildContext context) {
    final searchResult = useProvider(searchResultFutureProvider(searchTerm));
    return searchResult.when(
      data: (searchResult) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 15.0),
          itemCount: searchResult.length,
          itemBuilder: (context, index) => BusStopCard(
            busStopModel: searchResult[index],
            key: ValueKey<String>('busStopCard-$index'),
            searchTerm: searchTerm,
          ),
        );
      },
      loading: () => Container(),
      error: (err, stack) {
        if (err is Failure) {
          return ErrorView(message: err.message);
        }
        return ErrorView();
      },
    );
  }
}
