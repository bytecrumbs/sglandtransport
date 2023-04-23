import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../keys.dart';
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
        key: favoriteButtonKey,
        onPressed: favoriteTogglerController.toggle,
        icon: data
            ? const Icon(
                Icons.favorite,
                key: isFavoriteIconKey,
              )
            : const Icon(
                Icons.favorite_outline,
                key: notFavoriteIconKey,
              ),
      ),
      loading: () => const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.favorite_outline,
          key: notFavoriteIconKey,
        ),
      ),
      error: (_, __) => const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.favorite_outline,
          key: notFavoriteIconKey,
        ),
      ),
    );
  }
}
