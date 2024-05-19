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
    state = state.copyWith(busStopsStatus: 'Downloading Bus Stops... Done!');
  }

  void busServicesLoadingComplete() {
    state = state.copyWith(
      busServicesStatus: 'Downloading Bus Services... Done!',
    );
  }

  void busRoutesLoadingComplete() {
    state = state.copyWith(busRoutesStatus: 'Downloading Bus Routes! Done!');
  }

  void busStopsLoadingUpdate(int percentageComplete) {
    state = state.copyWith(
      busStopsStatus: 'Downloading Bus Stops... $percentageComplete%',
    );
  }

  void busServicesLoadingUpdate(int percentageComplete) {
    state = state.copyWith(
      busServicesStatus: 'Downloading Bus Services... $percentageComplete%',
    );
  }

  void busRoutesLoadingUpdate(int percentageComplete) {
    state = state.copyWith(
      busRoutesStatus: 'Downloading Bus Routes... $percentageComplete%',
    );
  }
}

@freezed
class DBInitStateModel with _$DBInitStateModel {
  factory DBInitStateModel({
    @Default(false) bool isInitializing,
    @Default('Downloading Bus Stops... Pending!') String busStopsStatus,
    @Default('Downloading Bus Services... Pending!') String busServicesStatus,
    @Default('Downloading Bus Routes... Pending!') String busRoutesStatus,
  }) = _DBInitStateModel;
}
