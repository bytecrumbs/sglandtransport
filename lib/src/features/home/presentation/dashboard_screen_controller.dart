import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../local_storage/local_storage_keys.dart';
import '../../../local_storage/local_storage_service.dart';

part 'dashboard_screen_controller.g.dart';

@riverpod
class DashboardScreenController extends _$DashboardScreenController {
  @override
  FutureOr<int> build() async {
    final selectedIndex =
        await ref.read(localStorageServiceProvider).getInt(bottomBarIndexKey);
    return selectedIndex ?? 0;
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
