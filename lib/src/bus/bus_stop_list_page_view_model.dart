import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/constants.dart';
import '../shared/services/local_storage_service.dart';

final busStopListPageViewModelProvider =
    Provider((ref) => BusStopListPageViewModel(ref.read));

class BusStopListPageViewModel {
  BusStopListPageViewModel(this.read);

  final Reader read;

  int? bottomNavBarFilter() {
    final localStorage = read(localStorageServiceProvider);
    return localStorage.getInt(bottomBarIndexKey);
  }
}
