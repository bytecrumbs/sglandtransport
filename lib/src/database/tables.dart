import 'package:drift/drift.dart';

class TableBusRoutes extends Table {
  TextColumn get serviceNo => text()();
  TextColumn get operator => text()();
  IntColumn get direction => integer()();
  IntColumn get stopSequence => integer()();
  TextColumn get busStopCode => text()();
  RealColumn get distance => real()();
  TextColumn get wdFirstBus => text()();
  TextColumn get wdLastBus => text()();
  TextColumn get satFirstBus => text()();
  TextColumn get satLastBus => text()();
  TextColumn get sunFirstBus => text()();
  TextColumn get sunLastBus => text()();
}

class TableBusStops extends Table {
  TextColumn get busStopCode => text()();
  TextColumn get roadName => text()();
  TextColumn get description => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
}

class TableBusServices extends Table {
  TextColumn get serviceNo => text()();
  TextColumn get operator => text()();
  IntColumn get direction => integer()();
  TextColumn get category => text()();
  TextColumn get originCode => text()();
  TextColumn get destinationCode => text()();
  TextColumn get amPeakFreq => text()();
  TextColumn get amOffpeakFreq => text()();
  TextColumn get pmPeakFreq => text()();
  TextColumn get pmOffpeakFreq => text()();
  TextColumn get loopDesc => text().nullable()();
}
