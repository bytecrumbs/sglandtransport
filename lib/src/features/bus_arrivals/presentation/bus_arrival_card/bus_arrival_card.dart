import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_router.dart';
import 'bus_arrival_card_header.dart';
import 'bus_arrival_sequence.dart';
import 'favorite_toggler.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    super.key,
    // required this.busArrivalModel,
    required this.serviceNo,
    required this.destinationCode,
    required this.inService,
    this.destinationName,
    required this.nextBusEstimatedArrival,
    required this.nextBusLoad,
    required this.nextBus2EstimatedArrival,
    required this.nextBus2Load,
    required this.nextBus3EstimatedArrival,
    required this.nextBus3Load,
    required this.busStopCode,
  });

  final String serviceNo;
  final String destinationCode;
  final bool inService;
  final String? destinationName;
  final String nextBusEstimatedArrival;
  final String nextBusLoad;
  final String nextBus2EstimatedArrival;
  final String nextBus2Load;
  final String nextBus3EstimatedArrival;
  final String nextBus3Load;
  final String busStopCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: inService
                ? () => context.pushNamed(
                      AppRoute.busDetails.name,
                      pathParameters: {
                        'serviceNo': serviceNo,
                        'busStopCode': busStopCode,
                        'destinationCode': destinationCode,
                      },
                    )
                : null,
            child: BusArrivalCardHeader(
              serviceNo: serviceNo,
              inService: inService,
              destinationName: destinationName,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: BusArrivalSequence(
                  inService: inService,
                  nextBusEstimatedArrival: nextBusEstimatedArrival,
                  nextBusLoad: nextBusLoad,
                  nextBus2EstimatedArrival: nextBus2EstimatedArrival,
                  nextBus2Load: nextBus2Load,
                  nextBus3EstimatedArrival: nextBus3EstimatedArrival,
                  nextBus3Load: nextBus3Load,
                ),
              ),
              FavoriteToggler(
                busStopCode: busStopCode,
                serviceNo: serviceNo,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
