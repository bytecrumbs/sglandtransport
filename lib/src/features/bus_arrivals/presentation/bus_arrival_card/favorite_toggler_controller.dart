import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/bus_arrivals_service.dart';
import '../favorites/bus_arrival_list_favorites.dart';

part 'favorite_toggler_controller.g.dart';

@riverpod
class FavoriteTogglerController extends _$FavoriteTogglerController {
  @override
  bool build({
    required String busStopCode,
    required String serviceNo,
    required bool isFavorite,
  }) {
    return isFavorite;
  }

  void toggle() {
    state = ref.watch(busArrivalsServiceProvider).toggleFavoriteBusService(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        );
    ref.invalidate(favoriteBusArrivalsStreamProvider);
  }
}
