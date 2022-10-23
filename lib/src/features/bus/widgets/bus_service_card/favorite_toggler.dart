import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bus_service_list_favorites_view_model.dart';

class FavoriteToggler extends ConsumerWidget {
  const FavoriteToggler({
    super.key,
    required this.busStopCode,
    required this.serviceNo,
  });

  final String busStopCode;
  final String serviceNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm =
        ref.watch(busServiceListFavoritesViewModelStateProvider.notifier);
    final vmState = ref.watch(busServiceListFavoritesViewModelStateProvider);
    return IconButton(
      onPressed: () => vm.toggleFavoriteBusService(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
      ),
      icon: vmState.maybeWhen(
        data: (busArrivalModelList) {
          final elementFound = busArrivalModelList.indexWhere(
            (busArrivalModel) =>
                busArrivalModel.busStopCode == busStopCode &&
                busArrivalModel.services[0].serviceNo == serviceNo,
          );
          return elementFound >= 0
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_outline);
        },
        orElse: () => const Icon(Icons.favorite_outline),
      ),
    );
  }
}
