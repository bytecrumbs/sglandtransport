import 'package:lta_datamall_flutter/src/features/bus_arrivals/application/bus_arrivals_service.dart';
import 'package:mocktail/mocktail.dart';

class MockBusArrivalsService extends Mock implements BusArrivalsService {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
