import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_init_notifier.g.dart';
part 'db_init_notifier.freezed.dart';

@Riverpod(keepAlive: true)
class DBInitNotifier extends _$DBInitNotifier {
  @override
  DBInitStateModel build() => DBInitStateModel();

  void initDBStart() {
    state = state.copyWith(isInitializing: true);
  }

  void initDBComplete() {
    state = state.copyWith(isInitializing: false);
  }

  void busStopsLoadingComplete() {
    state =
        state.copyWith(busStopsStatus: 'Refreshing Bus Stops details... Done!');
  }

  void busServicesLoadingComplete() {
    state = state.copyWith(
      busServicesStatus: 'Refreshing Bus Services details... Done!',
    );
  }

  void busRoutesLoadingComplete() {
    state =
        state.copyWith(busRoutesStatus: 'Refreshing Bus Routes details! Done!');
  }
}

@freezed
class DBInitStateModel with _$DBInitStateModel {
  factory DBInitStateModel({
    @Default(false) bool isInitializing,
    @Default('Refreshing Bus Stops details... Working on it!')
    String busStopsStatus,
    @Default('Refreshing Bus Services details... Working on it!')
    String busServicesStatus,
    @Default('Refreshing Bus Routes details... Working on it!')
    String busRoutesStatus,
  }) = _DBInitStateModel;
}
