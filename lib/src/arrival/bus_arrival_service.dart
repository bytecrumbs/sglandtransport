class BusArrivalService {
  Future<List<String>> getBusArrivalInfo(String busStopNumber) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return ['1', '2', '3'];
    });
  }
}
