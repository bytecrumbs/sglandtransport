import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/bus_arrival_config.dart';
import '../../../../shared/custom_exception.dart';
import '../../../../shared/presentation/error_display.dart';
import '../../application/bus_services_service.dart';
import '../../domain/bus_arrival_service_model.dart';
import 'bus_service_card.dart';

part 'bus_service_card_with_fetch.freezed.dart';

@freezed
class BusServiceStreamProviderParameter
    with _$BusServiceStreamProviderParameter {
  factory BusServiceStreamProviderParameter({
    required String busStopCode,
    required String serviceNo,
  }) = _BusServiceStreamProviderParameter;
}

final busServiceStreamProvider = StreamProvider.autoDispose
    .family<BusArrivalServiceModel, BusServiceStreamProviderParameter>(
  (ref, param) async* {
    final busServicesService = ref.watch(busServicesServiceProvider);
    // make sure it is executed immediately
    final checkResult = await busServicesService.getBusArrival(
      busStopCode: param.busStopCode,
      serviceNo: param.serviceNo,
    );
    yield checkResult;
    // then execute regularly
    yield* Stream.periodic(
      busArrivalRefreshDuration,
      (computationCount) {
        return busServicesService.getBusArrival(
          busStopCode: param.busStopCode,
          serviceNo: param.serviceNo,
        );
      },
    ).asyncMap((event) async => event);
  },
);

class BusServiceCardWithFetch extends ConsumerWidget {
  const BusServiceCardWithFetch({
    super.key,
    required this.busStopCode,
    required this.serviceNo,
  });

  final String busStopCode;
  final String serviceNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busService = ref.watch(
      busServiceStreamProvider(
        BusServiceStreamProviderParameter(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        ),
      ),
    );

    return busService.when(
      data: (busArrivalServiceModel) => BusServiceCard(
        busStopCode: busStopCode,
        originalCode: busArrivalServiceModel.nextBus.originCode ?? '1',
        destinationCode: busArrivalServiceModel.nextBus.destinationCode ?? '1',
        inService: busArrivalServiceModel.inService,
        serviceNo: busArrivalServiceModel.serviceNo,
        destinationName: busArrivalServiceModel.destinationName,
        nextBusEstimatedArrival:
            busArrivalServiceModel.nextBus.getEstimatedArrival(),
        nextBusLoadColor: busArrivalServiceModel.nextBus.getLoadColor(),
        nextBus2EstimatedArrival:
            busArrivalServiceModel.nextBus2.getEstimatedArrival(),
        nextBus2LoadColor: busArrivalServiceModel.nextBus2.getLoadColor(),
        nextBus3EstimatedArrival:
            busArrivalServiceModel.nextBus3.getEstimatedArrival(),
        nextBus3LoadColor: busArrivalServiceModel.nextBus3.getLoadColor(),
        isFavorite: busArrivalServiceModel.isFavorite,
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        if (error is CustomException) {
          return ErrorDisplay(
            message: error.message,
            onPressed: () {
              ref.invalidate(
                busServiceStreamProvider(
                  BusServiceStreamProviderParameter(
                    busStopCode: busStopCode,
                    serviceNo: serviceNo,
                  ),
                ),
              );
            },
          );
        }
        return ErrorDisplay(
          message: error.toString(),
        );
      },
    );
  }
}
