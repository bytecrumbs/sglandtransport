import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_route/bus_route_model.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class DatabaseService {
  static final _log = Logger('DatabaseService');

  static const busRoutesTableName = 'busRoutes';
  static const busStopsTableName = 'busStops';
  static const tableCreationTableName = 'tableCreation';

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
    _log.info('creating $tableCreationTableName table');
    await _createTableCreationTable(database);
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

  Future<void> _createTableCreationTable(Database database) async {
    await database.execute(
      'CREATE TABLE $tableCreationTableName ('
      'tableName TEXT,'
      'creationTimeSinceEpoch INT'
      ')',
    );
  }

  Future<void> _insertList(String tableName, List<dynamic> listToInsert) async {
    final db = await database;
    var batch = db.batch();
    listToInsert.forEach((listItem) {
      batch.insert(tableName, listItem.toJson());
    });
    await batch.commit(noResult: true);
    _log.info(
        'inserting ${listToInsert.length} records into table $tableName complete...');
  }

  Future<List<BusStopModel>> getBusStopsByLocation() async {
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

  Future<List<BusRouteModel>> getBusRoutes(String busStopCode) async {
    var busRouteList = <BusRouteModel>[];
    final db = await database;
    _log.info('getting bus routes');
    var busRoutes = await db.rawQuery(
      'SELECT * FROM $busRoutesTableName WHERE BusStopCode = ?',
      [busStopCode],
    );

    busRoutes.forEach((currentBusRoute) {
      var busRouteModel = BusRouteModel.fromJson(currentBusRoute);
      busRouteList.add(busRouteModel);
    });

    return busRouteList;
  }

  void insertBusStops(List<BusStopModel> busStops) {
    _insertList(busStopsTableName, busStops);
  }

  void insertBusRoutes(List<BusRouteModel> busRoutes) {
    _insertList(busRoutesTableName, busRoutes);
  }

  Future<int> insertBusRoutesTableCreationDate({
    int millisecondsSinceEpoch,
  }) async {
    return await _insertTableCreationDate(
      tableName: busRoutesTableName,
      millisecondsSinceEpoch: millisecondsSinceEpoch,
    );
  }

  Future<int> insertBusStopsTableCreationDate({
    int millisecondsSinceEpoch,
  }) async {
    return await _insertTableCreationDate(
      tableName: busStopsTableName,
      millisecondsSinceEpoch: millisecondsSinceEpoch,
    );
  }

  Future<int> _insertTableCreationDate({
    String tableName,
    int millisecondsSinceEpoch,
  }) async {
    final db = await database;
    _log.info('Deleting $tableName row');
    await db.delete(tableCreationTableName,
        where: 'tableName = ?', whereArgs: [tableName]);
    _log.info(
        'Inserting timestamp into $tableCreationTableName for $tableName');
    return await db.rawInsert(
      'INSERT INTO $tableCreationTableName(tableName, creationTimeSinceEpoch) VALUES(?, ?)',
      [
        tableName,
        millisecondsSinceEpoch,
      ],
    );
  }

  Future<List<Map<String, dynamic>>> getCreationDateOfBusRoutes() async {
    return await _getCreationDate(tableName: busRoutesTableName);
  }

  Future<List<Map<String, dynamic>>> getCreationDateOfBusStops() async {
    return await _getCreationDate(tableName: busStopsTableName);
  }

  Future<List<Map<String, dynamic>>> _getCreationDate(
      {String tableName}) async {
    final db = await database;
    return await db.query(
      tableCreationTableName,
      columns: ['creationTimeSinceEpoch'],
      where: 'tableName = ?',
      whereArgs: [tableName],
    );
  }

  Future<int> getBusRoutesCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $busRoutesTableName'),
    );
  }

  Future<List<BusStopModel>> getFavouriteBusStops(
      List<String> busStopCodes) async {
    var busStopList = <BusStopModel>[];
    final db = await database;
    final rawQuery =
        'SELECT * FROM $busStopsTableName WHERE BusStopCode in (\'${busStopCodes.join("','")}\')';
    _log.info('getting favourite bus stops ($rawQuery)');
    var busStops = await db.rawQuery(rawQuery);

    busStops.forEach((currentBusStop) {
      var busStopModel = BusStopModel.fromJson(currentBusStop);
      busStopList.add(busStopModel);
    });

    return busStopList;
  }

  Future<int> deleteBusRoutes() async {
    return await _deleteTable(busRoutesTableName);
  }

  Future<int> deleteBusStops() async {
    return await _deleteTable(busStopsTableName);
  }

  Future<int> _deleteTable(String tableName) async {
    final db = await database;
    _log.info('Deleting all records in table $tableName');
    return await db.delete(tableName);
  }
}
