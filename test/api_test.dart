import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';

class MockClient extends Mock implements http.Client {}

dynamic main() {
  group('fetchBusArrivalList', () {
    test('returns a BusArrivalList if the http call completes successfully',
        () async {
      final MockClient client = MockClient();
      // TODO(sascha): Store this header value somewhere more central and reusable
      final Map<String, String> requestHeaders = <String, String>{
        'AccountKey': 'xNTAqVxgQiOwp9MQa9y0tQ==',
      };

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=01012',
        headers: requestHeaders,
      )).thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

      expect(await fetchBusArrivalList(client, '01012'),
          isInstanceOf<BusArrivalModel>());
    });

    test('throws an exception if the http call completes with an error', () {
      final MockClient client = MockClient();
      final Map<String, String> requestHeaders = <String, String>{
        'AccountKey': 'xNTAqVxgQiOwp9MQa9y0tQ==',
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

  // TODO(sascha): Add tests for fetchBusStopList
}
