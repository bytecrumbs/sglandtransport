import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/bus_services_service.dart';
import '../favorites/bus_service_list_favorites.dart';

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
    // TODO: maybe there is a better way to do this?
    // watch the state, so the widget gets updated when the favorite is toggled
    ref.watch(favoriteBusServicesStreamProvider);

    return IconButton(
      onPressed: () {
        ref.watch(busServicesServiceProvider).toggleFavoriteBusService(
              busStopCode: busStopCode,
              serviceNo: serviceNo,
            );
        ref.invalidate(favoriteBusServicesStreamProvider);
      },
      icon: ref
              .watch(busServicesServiceProvider)
              .isFavorite(busStopCode: busStopCode, serviceNo: serviceNo)
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline),
    );
  }
}
