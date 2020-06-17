import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/io_client.dart' as http;

import 'api.dart';

@lazySingleton
class DatabaseService {
  static final _log = Logger('DatabaseService');

  static const busRoutesTableName = 'busRoutes';
  static const busStopsTableName = 'busStops';

  final _api = locator<Api>();

  Database _database;

  Future<Database> get database async {
    _log.info('getting database');
    if (_database != null) {
      _log.info('returning existing database instance');
      return _database;
    }
    _database = await _initDB();
    _log.info('returning new database instance');
    return _database;
  }

  Future<Database> _initDB() async {
    // Get a location using path_provider
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sgLandTransportDB.db');

    _log.info('opening database');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database database, int version) async {
    _log.info('creating database');
    _log.info('creating $busRoutesTableName table');
    await _createBusRoutesTable(database);
    _log.info('creating $busStopsTableName table');
    await _createBusStopsTable(database);
    await Future.wait([
      _fetchAndInsertBusRoutes(database),
      _fetchAndInsertBusStops(database),
    ]);
  }

  Future<void> _createBusRoutesTable(Database database) async {
    await database.execute(
      'CREATE TABLE $busRoutesTableName ('
      'ServiceNo TEXT,'
      'Operator TEXT,'
      'Direction INTEGER,'
      'StopSequence INTEGER,'
      'BusStopCode TEXT,'
      'Distance REAL,'
      'WD_FirstBus TEXT,'
      'WD_LastBus TEXT,'
      'SAT_FirstBus TEXT,'
      'SAT_LastBus TEXT,'
      'SUN_firstBus TEXT,'
      'SUN_LastBus TEXT'
      ')',
    );
  }

  Future<void> _createBusStopsTable(Database database) async {
    await database.execute(
      'CREATE TABLE $busStopsTableName ('
      'BusStopCode TEXT,'
      'RoadName TEXT,'
      'Description TEXT,'
      'Latitude REAL,'
      'Longitude REAL,'
      'distanceInMeters INT'
      ')',
    );
  }

  Future<void> _fetchAndInsertBusRoutes(Database database) async {
    _log.info('fetching bus routes');
    final busRoutes = await _api.fetchBusRoutes(http.IOClient());
    _log.info('inserting bus routes');
    await _insertList(busRoutesTableName, busRoutes, database);
  }

  Future<void> _fetchAndInsertBusStops(Database database) async {
    _log.info('fetching bus stops');
    final busStops = await _api.fetchBusStopList(http.IOClient());
    _log.info('inserting bus stops');
    await _insertList(busStopsTableName, busStops, database);
  }

  Future<void> _insertList(
      String tableName, List<dynamic> listToInsert, Database database) async {
    var batch = database.batch();
    listToInsert.forEach((listItem) {
      batch.insert(tableName, listItem.toJson());
    });
    await batch.commit(noResult: true);
    _log.info(
        'inserting ${listToInsert.length} records into table $tableName complete...');
  }
}
