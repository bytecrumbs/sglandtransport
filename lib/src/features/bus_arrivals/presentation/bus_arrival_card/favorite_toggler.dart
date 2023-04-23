import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'favorite_toggler_controller.dart';

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
    final favoriteTogglerController = ref.watch(
      favoriteTogglerControllerProvider(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
      ).notifier,
    );
    final favoriteTogglerControllerState = ref.watch(
      favoriteTogglerControllerProvider(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
      ),
    );

    return favoriteTogglerControllerState.when(
      data: (data) => IconButton(
        onPressed: favoriteTogglerController.toggle,
        icon: data
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_outline),
      ),
      loading: () => const IconButton(
        onPressed: null,
        icon: Icon(Icons.favorite_outline),
      ),
      error: (_, __) => const IconButton(
        onPressed: null,
        icon: Icon(Icons.favorite_outline),
      ),
    );
  }
}
