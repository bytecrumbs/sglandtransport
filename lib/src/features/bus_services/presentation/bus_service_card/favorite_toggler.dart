import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../favorites/bus_service_list_favorites_controller.dart';

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
    ref.watch(busServiceListFavoritesControllerStateProvider);

    return IconButton(
      onPressed: () => ref
          .watch(busServiceListFavoritesControllerStateProvider.notifier)
          .toggleFavoriteBusService(
            busStopCode: busStopCode,
            serviceNo: serviceNo,
          ),
      icon: ref
              .watch(busServiceListFavoritesControllerStateProvider.notifier)
              .isFavorite(busStopCode: busStopCode, serviceNo: serviceNo)
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline),
    );
  }
}
