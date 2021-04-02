import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../app/bus/models/bus_route_model.dart';
import '../app/bus/models/bus_stop_model.dart';

/// Provides the database service class
final databaseServiceProvider = Provider((ref) => DatabaseService(ref.read));

/// The main database class, which handles all the reading/writing to the local
/// databse
class DatabaseService {
  /// The default constructor for the class
  DatabaseService(this.read);

  /// A reader that enables reading other providers
  final Reader read;

  static final _log = Logger('DatabaseService');

  /// The name of the table that stores the bus stops
  static const busStopsTableName = 'busStops';

  /// The name of the table that stores the bus routes
  static const busRoutesTableName = 'busRoutes';

  /// The name of the table that stores dates when individual tables have been
  /// created
  static const tableCreationTableName = 'tableCreation';

  Database? _database;

  /// Gets the database instance. If it does not exist yet, it will initialize
  /// the database first
  Future<Database> get database async {
    _log.info('getting database');
    if (_database != null) {
      _log.info('returning existing database instance');
      return _database!;
    }
    _database = await _initDB();
    _log.info('returning new database instance');
    return _database!;
  }

  Future<Database> _initDB() async {
    // Get a location using path_provider
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sgLandTransportDB.db');

    _log.info('opening database');
    return openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database database, int version) async {
    _log.info('creating $busRoutesTableName table');
    await _createBusRoutesTable(database);
    _log.info('creating $busStopsTableName table');
    await _createBusStopsTable(database);
    _log.info('creating $tableCreationTableName table');
    await _createTableCreationTable(database);
  }

  Future<void> _createBusRoutesTable(Database database) async {
    await database.execute(
      'CREATE TABLE $busRoutesTableName ( '
      'ServiceNo TEXT, '
      'Operator TEXT, '
      'Direction INTEGER, '
      'StopSequence INTEGER, '
      'BusStopCode TEXT, '
      'Distance REAL, '
      'WD_FirstBus TEXT, '
      'WD_LastBus TEXT, '
      'SAT_FirstBus TEXT, '
      'SAT_LastBus TEXT, '
      'SUN_firstBus TEXT, '
      'SUN_LastBus TEXT '
      ')',
    );
  }

  Future<void> _createBusStopsTable(Database database) async {
    await database.execute(
      'CREATE TABLE $busStopsTableName ( '
      'BusStopCode TEXT PRIMARY KEY, '
      'RoadName TEXT, '
      'Description TEXT, '
      'Latitude REAL, '
      'Longitude REAL, '
      'distanceInMeters INT '
      ')',
    );
  }

  Future<void> _createTableCreationTable(Database database) async {
    await database.execute(
      'CREATE TABLE $tableCreationTableName ( '
      'tableName TEXT, '
      'creationTimeSinceEpoch INT '
      ')',
    );
  }

  /// Selects all bus stops stored in the bus stops table. A list of bus stop
  /// codes can be provided as a filter
  Future<List<BusStopModel>> getBusStops([List<String>? busStopCodes]) async {
    final busStopList = <BusStopModel>[];
    final db = await database;
    var busStopCodeInFilter = '';
    if (busStopCodes != null) {
      busStopCodeInFilter =
          "WHERE BusStopCode IN ('${busStopCodes.join("','")}')";
    }
    final queryString = 'SELECT * FROM $busStopsTableName $busStopCodeInFilter';
    _log.info('getting bus stops with query: $queryString');
    final busStops = await db.rawQuery(queryString);

    for (final currentBusStop in busStops) {
      final busStopModel = BusStopModel.fromJson(currentBusStop);
      busStopList.add(busStopModel);
    }

    return busStopList;
  }

  /// Selects all bus routes stored in the bus routes table for a given bus
  /// stop.
  Future<List<BusRouteModel>> getBusRoutes(String busStopCode) async {
    final busRouteList = <BusRouteModel>[];
    final db = await database;
    _log.info('getting bus routes');
    final busRoutes = await db.rawQuery(
      'SELECT * FROM $busRoutesTableName WHERE BusStopCode = ?',
      <String>[busStopCode],
    );

    for (final currentBusRoute in busRoutes) {
      final busRouteModel = BusRouteModel.fromJson(currentBusRoute);
      busRouteList.add(busRouteModel);
    }

    return busRouteList;
  }

  /// Selects bus stops based on a given list of bus stop codes
  Future<List<BusStopModel>> getFavouriteBusStops(
      List<String> busStopCodes) async {
    final busStopList = <BusStopModel>[];
    final db = await database;
    final rawQuery = 'SELECT * FROM $busStopsTableName WHERE BusStopCode '
        "in ('${busStopCodes.join("','")}')";
    _log.info('getting favorite bus stops ($rawQuery)');
    final busStops = await db.rawQuery(rawQuery);

    for (final currentBusStop in busStops) {
      final busStopModel = BusStopModel.fromJson(currentBusStop);
      busStopList.add(busStopModel);
    }

    return busStopList;
  }

  /// Inserts bus stops into the bus stop table, based on a given list of bus
  /// stops
  Future<void> insertBusStops(List<BusStopModel> busStops) async {
    await _insertList(busStopsTableName, busStops);
  }

  /// Inserts bus stops into the bus stop table, based on a given list of bus
  /// stops
  Future<void> insertBusRoutes(List<BusRouteModel> busRoutes) async {
    await _insertList(busRoutesTableName, busRoutes);
  }

  /// Inserts the timestamp (as "milliseconds since epoch") of when the bus
  /// stops table has been created and populated
  Future<int> insertBusStopsTableCreationDate({
    required int millisecondsSinceEpoch,
  }) async {
    return _insertTableCreationDate(
      tableName: busStopsTableName,
      millisecondsSinceEpoch: millisecondsSinceEpoch,
    );
  }

  /// Inserts the timestamp (as "milliseconds since epoch") of when the bus
  /// routes table has been created and populated
  Future<int> insertBusRoutesTableCreationDate({
    required int millisecondsSinceEpoch,
  }) async {
    return _insertTableCreationDate(
      tableName: busRoutesTableName,
      millisecondsSinceEpoch: millisecondsSinceEpoch,
    );
  }

  Future<int> _insertTableCreationDate({
    required String tableName,
    required int millisecondsSinceEpoch,
  }) async {
    final db = await database;
    _log.info('Deleting $tableName row');
    await db.delete(tableCreationTableName,
        where: 'tableName = ?', whereArgs: <String>[tableName]);
    _log.info(
        'Inserting timestamp into $tableCreationTableName for $tableName');
    return db.rawInsert(
      'INSERT INTO $tableCreationTableName(tableName, creationTimeSinceEpoch) '
      'VALUES(?, ?)',
      <dynamic>[
        tableName,
        millisecondsSinceEpoch,
      ],
    );
  }

  Future<void> _insertList(String tableName, List<dynamic> listToInsert) async {
    final db = await database;
    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final listItem in listToInsert) {
        batch.insert(tableName, listItem.toJson() as Map<String, dynamic>);
      }
      await batch.commit(noResult: true, continueOnError: true);
      _log.info('inserting ${listToInsert.length} records into table '
          '$tableName complete...');
    });
  }

  /// Gets back the details of when the bus stop table has been created
  Future<List<Map<String, dynamic>>> getCreationDateOfBusStops() async {
    return _getCreationDate(tableName: busStopsTableName);
  }

  /// Gets back the details of when the bus routes table has been created
  Future<List<Map<String, dynamic>>> getCreationDateOfBusRoutes() async {
    return _getCreationDate(tableName: busRoutesTableName);
  }

  Future<List<Map<String, dynamic>>> _getCreationDate(
      {required String tableName}) async {
    final db = await database;
    return db.query(
      tableCreationTableName,
      columns: ['creationTimeSinceEpoch'],
      where: 'tableName = ?',
      whereArgs: <String>[tableName],
    );
  }

  /// Deletes all records from the bus routes table
  Future<int> deleteBusRoutes() async {
    return _deleteTable(busRoutesTableName);
  }

  /// Deletes all records from the bus stop table
  Future<int> deleteBusStops() async {
    return _deleteTable(busStopsTableName);
  }

  Future<int> _deleteTable(String tableName) async {
    final db = await database;
    _log.info('Deleting all records in table $tableName');
    return db.delete(tableName);
  }
}
