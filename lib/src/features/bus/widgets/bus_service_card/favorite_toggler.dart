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
    // watch the state, so the widget gets updated when the favorite is toggled
    ref.watch(busServiceListFavoritesViewModelStateProvider);

    return IconButton(
      onPressed: () => ref
          .watch(busServiceListFavoritesViewModelStateProvider.notifier)
          .toggleFavoriteBusService(
            busStopCode: busStopCode,
            serviceNo: serviceNo,
          ),
      icon: ref
              .watch(busServiceListFavoritesViewModelStateProvider.notifier)
              .isFavorite(busStopCode: busStopCode, serviceNo: serviceNo)
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline),
    );
  }
}
