import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'favorite_toggler_controller.dart';

class FavoriteToggler extends ConsumerWidget {
  const FavoriteToggler({
    super.key,
    required this.busStopCode,
    required this.serviceNo,
    required this.isFavorite,
  });

  final String busStopCode;
  final String serviceNo;
  final bool isFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteTogglerController = ref.watch(
      favoriteTogglerControllerProvider(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
        isFavorite: isFavorite,
      ).notifier,
    );
    final favoriteTogglerControllerState = ref.watch(
      favoriteTogglerControllerProvider(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
        isFavorite: isFavorite,
      ),
    );

    return IconButton(
      onPressed: favoriteTogglerController.toggle,
      icon: favoriteTogglerControllerState
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline),
    );
  }
}
