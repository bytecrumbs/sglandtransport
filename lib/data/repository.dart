import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

abstract class Repository {
  Future<List<BusStopModel>> getBusStopListBySearchText(String searchText);
}

// abstract class IRepository<T> {
//   Future<List<TodoEntity>> get(dynamic id);
//   Future<void> add(T object);
// }

// Stream<List<TodoEntity>> todos();
