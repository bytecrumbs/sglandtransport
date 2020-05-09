import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';

class MockClient extends Mock implements http.Client {}

dynamic main() {
  setUpAll(() {
    DotEnv().env = {'LTA_DATAMALL_KEY': 'fakeKey'};
  });

  group('fetchBusArrivalList', () {
    test('returns a BusArrivalList if the http call completes successfully',
        () async {
      final client = MockClient();
      final requestHeaders = {
        'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
      };

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=01012',
        headers: requestHeaders,
      )).thenAnswer((_) async =>
          http.Response('{"Services": [{"ServiceNo": "15"}]}', 200));

      expect(await fetchBusArrivalList(client, '01012'),
          isInstanceOf<BusArrivalModel>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final requestHeaders = {
        'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
      };

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=01012',
        headers: requestHeaders,
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchBusArrivalList(client, '01012'), throwsException);
    });
  });

  group('fetchBusStopList', () {
    test(
        'returns a List of BusStopModels if the http calls complete successfully',
        () async {
      final client = MockClient();
      final requestHeaders = {
        'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
      };

      final skip = [
        0,
        500,
        1000,
        1500,
        2000,
        2500,
        3000,
        3500,
        4000,
        4500,
        5000,
      ];

      for (final currentSkip in skip) {
        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(client.get(
          'http://datamall2.mytransport.sg/ltaodataservice/BusStops?\$skip=$currentSkip',
          headers: requestHeaders,
        )).thenAnswer((_) async =>
            http.Response('{"value": [{"BusStopCode": "010201"}]}', 200));
      }

      final busStopModelList = await fetchBusStopList(client);

      expect(busStopModelList, isInstanceOf<List<BusStopModel>>());
      expect(busStopModelList.length, equals(skip.length));
    });

    test('throws an exception if any of the http calls complete with an error',
        () {
      final client = MockClient();
      final requestHeaders = {
        'AccountKey': DotEnv().env['LTA_DATAMALL_KEY'],
      };

      final skip = [
        0,
        500,
        1000,
        1500,
        2000,
        2500,
        3000,
        3500,
        4000,
        4500,
        5000,
      ];

      for (final currentSkip in skip) {
        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(client.get(
          'http://datamall2.mytransport.sg/ltaodataservice/BusStops?\$skip=$currentSkip',
          headers: requestHeaders,
        )).thenAnswer((_) async => http.Response(
            '{"value": [{"BusStopCode": "010201"}]}',
            currentSkip == skip[4] ? 404 : 200));
      }

      expect(fetchBusStopList(client), throwsException);
    });
  });
}
