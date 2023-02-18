import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_router.dart';
import 'bus_arrival_card_header.dart';
import 'bus_arrival_sequence.dart';
import 'favorite_toggler.dart';

class BusServiceCard extends StatelessWidget {
  const BusServiceCard({
    super.key,
    // required this.busArrivalModel,
    required this.serviceNo,
    required this.originalCode,
    required this.destinationCode,
    required this.inService,
    this.destinationName,
    required this.nextBusEstimatedArrival,
    required this.nextBusLoadColor,
    required this.nextBus2EstimatedArrival,
    required this.nextBus2LoadColor,
    required this.nextBus3EstimatedArrival,
    required this.nextBus3LoadColor,
    required this.busStopCode,
    required this.isFavorite,
  });

  final String serviceNo;
  final String originalCode;
  final String destinationCode;
  final bool inService;
  final String? destinationName;
  final String nextBusEstimatedArrival;
  final Color nextBusLoadColor;
  final String nextBus2EstimatedArrival;
  final Color nextBus2LoadColor;
  final String nextBus3EstimatedArrival;
  final Color nextBus3LoadColor;
  final String busStopCode;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.pushNamed(
              AppRoute.busRoutes.name,
              params: {
                'busStopCode': busStopCode,
                'serviceNo': serviceNo,
                'originalCode': originalCode,
                'destinationCode': destinationCode,
              },
            ),
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
                  nextBusLoadColor: nextBusLoadColor,
                  nextBus2EstimatedArrival: nextBus2EstimatedArrival,
                  nextBus2LoadColor: nextBus2LoadColor,
                  nextBus3EstimatedArrival: nextBus3EstimatedArrival,
                  nextBus3LoadColor: nextBus3LoadColor,
                ),
              ),
              FavoriteToggler(
                busStopCode: busStopCode,
                serviceNo: serviceNo,
                isFavorite: isFavorite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
