import 'package:lta_datamall_flutter/models/bus_routes/bus_route_model.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:http/io_client.dart' as http;

class DatabaseProvider {
  static const String tableBusRoutes = 'busRoutes';
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

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;
  Future<Database> get database async {
    print('database getter called...');

    if (_database != null) return _database;

    _database = await _createDatabase();

    await _initDatabase(_database);

    return _database;
  }

  Future<Database> _createDatabase() async {
    print('creating database...');
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'busRoutesDB.db');

    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database database, int version) async {
    print('creating busRoutes table...');
    await database.execute(
      'CREATE TABLE $tableBusRoutes ('
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
    print('getting bus routes...');
    final db = await database;

    var busRoutes = await db.query(
      tableBusRoutes,
      columns: [
        columnServiceNo,
        columnOperator,
        columnDirection,
        columnStopSequence,
        columnBusStopCode,
        columnDistance,
        columnWdFirstBus,
        columnWdLastBus,
        columnSatFirstBus,
        columnSatLastBus,
        columnSunfirstBus,
        columnSunLastBus,
      ],
      where: '$columnBusStopCode = ?',
      whereArgs: [busStopCode],
    );

    var busRouteList = <BusRouteModel>[];

    busRoutes.forEach((currentBusRoute) {
      var busRouteModel = BusRouteModel.fromJson(currentBusRoute);
      busRouteList.add(busRouteModel);
    });

    return busRouteList;
  }

  Future<void> _initDatabase(Database database) async {
    print('starting to insert data...');
    final busRoutes = await fetchBusRoutes(http.IOClient());
    var batch = database.batch();
    busRoutes.forEach((busRoute) async {
      batch.insert(tableBusRoutes, busRoute.toJson());
    });
    await batch.commit(noResult: true);
    print('inserting ${busRoutes.length} records complete...');
  }
}
