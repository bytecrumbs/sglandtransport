import '../domain/bus_service_value_model.dart';
import 'bus_service_repository.dart';

final fakeBusServiceValueModel = BusServiceValueModel(
  serviceNo: '354',
  busOperator: 'SBST',
  direction: 1,
  category: 'TRUNK',
  originCode: '65009',
  destinationCode: '97009',
  amPeakFreq: '5-08',
  amOffpeakFreq: '8-12',
  pmPeakFreq: '8-10',
  pmOffpeakFreq: '09-14',
);

const String testExceptionServiceNo = 'exception';
const String testExceptionDestinationCode = 'exception';

class FakeBusServiceRepository implements BusServiceRepository {
  @override
  Future<List<BusServiceValueModel>> getBusService({
    required String serviceNo,
    required String destinationCode,
  }) {
    if (serviceNo == testExceptionServiceNo &&
        destinationCode == testExceptionDestinationCode) {
      throw Exception('Throwing exception');
    }
    return Future.value([
      fakeBusServiceValueModel.copyWith(
        serviceNo: serviceNo,
        destinationCode: destinationCode,
      ),
    ]);
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
