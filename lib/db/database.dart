import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/models/bus_routes/bus_route_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BusRoutesDatabase {
  static final _log = Logger('DatabaseProvider');

  static final BusRoutesDatabase _busRoutesDB = BusRoutesDatabase._internal();

  static const String tableName = 'busRoutes';
  static const String columnServiceNo = 'ServiceNo';
  static const String columnOperator = 'Operator';
  static const String columnDirection = 'Direction';
  static const String columnStopSequence = 'StopSequence';
  static const String columnBusStopCode = 'BusStopCode';
  static const String columnDistance = 'Distance';
  static const String columnWdFirstBus = 'WD_FirstBus';
  static const String columnWdLastBus = 'WD_LastBus';
  static const String columnSatFirstBus = 'SAT_FirstBus';
  static const String columnSatLastBus = 'SAT_LastBus';
  static const String columnSunfirstBus = 'SUN_FirstBus';
  static const String columnSunLastBus = 'SUN_LastBus';
  bool didInit = false;
  Database _database;

  static BusRoutesDatabase get() {
    return _busRoutesDB;
  }

  BusRoutesDatabase._internal();

  Future<Database> _getDb() async {
    _log.info('database getter called...');
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    // Get a location using path_provider
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'busRoutesDB.db');

    await deleteDatabase(path);

    _log.info('opening database...');
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    didInit = true;
  }

  Future<void> _onCreate(Database database, int version) async {
    _log.info('creating busRoutes table...');
    await database.execute(
      'CREATE TABLE $tableName ('
      '$columnServiceNo TEXT,'
      '$columnOperator TEXT,'
      '$columnDirection INTEGER,'
      '$columnStopSequence INTEGER,'
      '$columnBusStopCode TEXT,'
      '$columnDistance REAL,'
      '$columnWdFirstBus TEXT,'
      '$columnWdLastBus TEXT,'
      '$columnSatFirstBus TEXT,'
      '$columnSatLastBus TEXT,'
      '$columnSunfirstBus TEXT,'
      '$columnSunLastBus TEXT'
      ')',
    );
  }

  Future<List<BusRouteModel>> getBusRoutes(String busStopCode) async {
    _log.info('getting bus routes...');
    final db = await _getDb();

    var busRoutes = await db.rawQuery(
        'SELECT * FROM $tableName WHERE ${columnBusStopCode} = "$busStopCode"');

    var busRouteList = <BusRouteModel>[];

    busRoutes.forEach((currentBusRoute) {
      var busRouteModel = BusRouteModel.fromJson(currentBusRoute);
      busRouteList.add(busRouteModel);
    });

    return busRouteList;
  }

  Future<void> updateBusRoutes(List<BusRouteModel> busRoutes) async {
    final database = await _getDb();
    var batch = database.batch();
    busRoutes.forEach((busRoute) {
      batch.insert(tableName, busRoute.toJson());
    });
    await batch.commit(noResult: true);
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }
}
