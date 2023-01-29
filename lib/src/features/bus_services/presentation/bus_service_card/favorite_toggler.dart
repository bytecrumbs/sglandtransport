import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../application/bus_services_service.dart';
import '../favorites/bus_service_list_favorites.dart';

part 'favorite_toggler.freezed.dart';

@freezed
abstract class IsFavoriteTogglerParameter with _$IsFavoriteTogglerParameter {
  factory IsFavoriteTogglerParameter({
    required String serviceNo,
    required bool isFavorite,
  }) = _IsFavoriteTogglerParameter;
}

final isFavoriteStateProvider =
    StateProvider.autoDispose.family<bool, IsFavoriteTogglerParameter>(
  (ref, parameter) => parameter.isFavorite,
);

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
    final isFavoriteState = ref.watch(
      isFavoriteStateProvider(
        IsFavoriteTogglerParameter(
          serviceNo: serviceNo,
          isFavorite: isFavorite,
        ),
      ),
    );

    return IconButton(
      onPressed: () {
        final toggledValue =
            ref.watch(busServicesServiceProvider).toggleFavoriteBusService(
                  busStopCode: busStopCode,
                  serviceNo: serviceNo,
                );
        ref
            .read(
              isFavoriteStateProvider(
                IsFavoriteTogglerParameter(
                  serviceNo: serviceNo,
                  isFavorite: isFavorite,
                ),
              ).notifier,
            )
            .state = toggledValue;
        ref.invalidate(favoriteBusServicesStreamProvider);
      },
      icon: isFavoriteState
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline),
    );
  }
}
