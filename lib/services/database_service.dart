import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  /// The name of the table that stores dates when individual tables have been
  /// created
  static const tableCreationTableName = 'tableCreation';

  Database _database;

  /// Gets the database instance. If it does not exist yet, it will initialize
  /// the database first
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
    _log.info('creating $tableCreationTableName table');
    await _createTableCreationTable(database);
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

  Future<void> _createTableCreationTable(Database database) async {
    await database.execute(
      'CREATE TABLE $tableCreationTableName ('
      'tableName TEXT,'
      'creationTimeSinceEpoch INT'
      ')',
    );
  }

  /// Selects all bus stops stored in the bus stops table. A list of bus stop
  /// codes can be provided as a filter
  Future<List<BusStopModel>> getBusStops([List<String> busStopCodes]) async {
    var busStopList = <BusStopModel>[];
    final db = await database;
    var busStopCodeInFilter = '';
    if (busStopCodes != null) {
      busStopCodeInFilter =
          'WHERE BusStopCode IN (\'${busStopCodes.join("','")}\')';
    }
    var queryString = 'SELECT * FROM $busStopsTableName $busStopCodeInFilter';
    _log.info('getting bus stops with query: $queryString');
    var busStops = await db.rawQuery(queryString);

    for (var currentBusStop in busStops) {
      var busStopModel = BusStopModel.fromJson(currentBusStop);
      busStopList.add(busStopModel);
    }

    return busStopList;
  }

  /// Selects bus stops based on a given list of bus stop codes
  Future<List<BusStopModel>> getFavouriteBusStops(
      List<String> busStopCodes) async {
    var busStopList = <BusStopModel>[];
    final db = await database;
    final rawQuery = 'SELECT * FROM $busStopsTableName WHERE BusStopCode '
        'in (\'${busStopCodes.join("','")}\')';
    _log.info('getting favorite bus stops ($rawQuery)');
    var busStops = await db.rawQuery(rawQuery);

    for (var currentBusStop in busStops) {
      var busStopModel = BusStopModel.fromJson(currentBusStop);
      busStopList.add(busStopModel);
    }

    return busStopList;
  }

  /// Inserts bus stops into the bus stop table, based on a given list of bus
  /// stops
  Future<void> insertBusStops(List<BusStopModel> busStops) async {
    await _insertList(busStopsTableName, busStops);
  }

  /// Inserts the timestamp (as "milliseconds since epoch") of when the bus
  /// stops table has been created and populated
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
      'INSERT INTO $tableCreationTableName(tableName, creationTimeSinceEpoch) '
      'VALUES(?, ?)',
      [
        tableName,
        millisecondsSinceEpoch,
      ],
    );
  }

  Future<void> _insertList(String tableName, List<dynamic> listToInsert) async {
    final db = await database;
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var listItem in listToInsert) {
        batch.insert(tableName, listItem.toJson());
      }
      await batch.commit(noResult: true, continueOnError: true);
      _log.info('inserting ${listToInsert.length} records into table '
          '$tableName complete...');
    });
  }

  /// Gets back the details of when a table has been created and populated,
  /// based on a given table name
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

  /// Deletes all records from teh bus stop table
  Future<int> deleteBusStops() async {
    return await _deleteTable(busStopsTableName);
  }

  Future<int> _deleteTable(String tableName) async {
    final db = await database;
    _log.info('Deleting all records in table $tableName');
    return await db.delete(tableName);
  }
}
