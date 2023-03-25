import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../local_storage/local_storage_keys.dart';
import '../../../local_storage/local_storage_service.dart';

part 'dashboard_screen_controller.g.dart';

@riverpod
class DashboardScreenController extends _$DashboardScreenController {
  @override
  FutureOr<int?> build() {
    return ref.read(localStorageServiceProvider).getInt(bottomBarIndexKey);
  }

  Future<void> onTap({
    required int clickedItem,
  }) async {
    state = AsyncValue.data(clickedItem);
    await ref
        .read(localStorageServiceProvider)
        .setInt(bottomBarIndexKey, clickedItem);
  }
}
