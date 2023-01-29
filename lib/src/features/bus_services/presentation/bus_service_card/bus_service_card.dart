import 'package:flutter/material.dart';

import 'bus_arrival_sequence.dart';
import 'bus_service_card_header.dart';
import 'favorite_toggler.dart';

class BusServiceCard extends StatelessWidget {
  const BusServiceCard({
    super.key,
    // required this.busArrivalModel,
    required this.serviceNo,
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
          BusServiceCardHeader(
            serviceNo: serviceNo,
            inService: inService,
            destinationName: destinationName,
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
