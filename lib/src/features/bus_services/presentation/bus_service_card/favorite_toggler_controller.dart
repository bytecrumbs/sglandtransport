import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/bus_services_service.dart';
import '../favorites/bus_service_list_favorites.dart';

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
    state = ref.watch(busServicesServiceProvider).toggleFavoriteBusService(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        );
    ref.invalidate(favoriteBusServicesStreamProvider);
  }
}
