import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/bus/models/bus_stop_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService(ref.read));

class DatabaseService {
  DatabaseService(this.read);

  final Reader read;

  static final _log = Logger('DatabaseService');

  static const busStopsTableName = 'busStops';

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
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database database, int version) async {
    _log.info('creating database');
    // _log.info('creating $busRoutesTableName table');
    // await _createBusRoutesTable(database);
    _log.info('creating $busStopsTableName table');
    await _createBusStopsTable(database);
    // _log.info('creating $tableCreationTableName table');
    // await _createTableCreationTable(database);
  }

  Future<void> _createBusStopsTable(Database database) async {
    await database.execute(
      'CREATE TABLE $busStopsTableName ('
      'BusStopCode TEXT PRIMARY KEY,'
      'RoadName TEXT,'
      'Description TEXT,'
      'Latitude REAL,'
      'Longitude REAL,'
      'distanceInMeters INT'
      ')',
    );
  }

  Future<List<BusStopModel>> getBusStops() async {
    _log.info('getting bus stops');
    var busStopList = <BusStopModel>[];
    final db = await database;
    var busStops = await db.rawQuery('SELECT * FROM $busStopsTableName');

    busStops.forEach((currentBusStop) {
      var busStopModel = BusStopModel.fromJson(currentBusStop);
      busStopList.add(busStopModel);
    });

    return busStopList;
  }

  Future<void> insertBusStops(List<BusStopModel> busStops) async {
    await _insertList(busStopsTableName, busStops);
  }

  Future<void> _insertList(String tableName, List<dynamic> listToInsert) async {
    final db = await database;
    await db.transaction((txn) async {
      var batch = txn.batch();
      listToInsert.forEach((listItem) {
        batch.insert(tableName, listItem.toJson());
      });
      await batch.commit(noResult: true, continueOnError: true);
      _log.info(
          'inserting ${listToInsert.length} records into table $tableName complete...');
    });
  }
}
