import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/src/database/database.dart';
import 'package:lta_datamall_flutter/src/features/bus_services/presentation/bus_service_details.dart';
import 'package:lta_datamall_flutter/src/keys.dart';
import 'package:lta_datamall_flutter/src/third_party_providers/third_party_providers.dart';

import '../../../fakes/fake_database.dart';

class BusServicesRobot {
  BusServicesRobot(this.tester);

  final WidgetTester tester;

  final String serviceNo = '354';
  final String destinationCode = '97009';

  Future<void> pumpMyWidget() async {
    await tester.pumpAndSettle();
  }

  Future<void> pumpBusServiceDetails({
    bool produceGenericException = false,
  }) async {
    final container = ProviderContainer(
      overrides: [
        loggerProvider.overrideWithValue(
          Logger(
            printer: PrettyPrinter(),
            level: Level.error,
          ),
        ),
        appDatabaseProvider.overrideWithValue(FakeAppDatabase()),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: BusServiceDetails(
              serviceNo:
                  produceGenericException ? testExceptionServiceNo : serviceNo,
              destinationCode: produceGenericException
                  ? testExceptionDestinationCode
                  : destinationCode,
            ),
          ),
        ),
      ),
    );
  }

  void expectFindBusServiceRouteLoadingIndicator() {
    _expectFindLoadingIndicator(loadingIndicatorKey);
  }

  void expectFindBusServiceDetailsLoadingIndicator() {
    _expectFindLoadingIndicator(loadingIndicatorKey);
  }

  void _expectFindLoadingIndicator(Key loadingIndicatorKey) {
    final finder = find.byKey(loadingIndicatorKey);
    expect(finder, findsOneWidget);
  }

  void expectFindNoBusServiceDetailsLoadingIndicator() {
    _expectFindNoLoadingIndicator(loadingIndicatorKey);
  }

  void _expectFindNoLoadingIndicator(Key loadingIndicatorKey) {
    final finder = find.byKey(loadingIndicatorKey);
    expect(finder, findsNothing);
  }

  void expectFindBusOperator() {
    final finder = find.text(fakeBusServiceValueModel.busOperator);
    expect(finder, findsOneWidget);
  }

  void expectFindBusCategory() {
    final finder = find.text(fakeBusServiceValueModel.category);
    expect(finder, findsOneWidget);
  }

  void expectFindAmPeakFreq() {
    final finder = find.text('${fakeBusServiceValueModel.amPeakFreq} mins');
    expect(finder, findsOneWidget);
  }

  void expectFindPmPeakFreq() {
    final finder = find.text('${fakeBusServiceValueModel.pmPeakFreq} mins');
    expect(finder, findsOneWidget);
  }

  void expectFindAmOffpeakFreq() {
    final finder = find.text('${fakeBusServiceValueModel.amOffpeakFreq} mins');
    expect(finder, findsOneWidget);
  }

  void expectFindPmOffpeakFreq() {
    final finder = find.text('${fakeBusServiceValueModel.pmOffpeakFreq} mins');
    expect(finder, findsOneWidget);
  }

  void expectFindExceptionMessage() {
    final finder = find.byKey(exceptionMessageKey);
    expect(finder, findsOneWidget);
  }
}
