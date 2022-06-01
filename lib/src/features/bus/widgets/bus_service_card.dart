import 'package:flutter/material.dart';

import '../../../shared/palette.dart';
import 'bus_service_header.dart';

class BusServiceCard extends StatelessWidget {
  const BusServiceCard({
    super.key,
    // required this.busArrivalModel,
    required this.serviceNo,
    required this.isFavorite,
    required this.inService,
    this.destinationName,
    required this.nextBusEstimatedArrival,
    required this.nextBusLoadColor,
    required this.nextBus2EstimatedArrival,
    required this.nextBus2LoadColor,
    required this.nextBus3EstimatedArrival,
    required this.nextBus3LoadColor,
    this.busStopCode,
    this.previousBusStopCode,
    this.description,
    this.roadName,
    required this.onPressedFavorite,
  });

  final bool isFavorite;
  final String serviceNo;
  final bool inService;
  final String? destinationName;
  final String nextBusEstimatedArrival;
  final Color nextBusLoadColor;
  final String nextBus2EstimatedArrival;
  final Color nextBus2LoadColor;
  final String nextBus3EstimatedArrival;
  final Color nextBus3LoadColor;
  final String? previousBusStopCode;
  final String? busStopCode;
  final String? description;
  final String? roadName;
  final VoidCallback onPressedFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (busStopCode != null && busStopCode != previousBusStopCode)
            BusServiceHeader(
              busStopCode: busStopCode,
              description: description,
              roadName: roadName,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    serviceNo,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
                if (inService)
                  Container(
                    margin: const EdgeInsets.only(left: 1),
                    padding: const EdgeInsets.fromLTRB(7, 4, 10, 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.35),
                          blurRadius: 3,
                          offset: const Offset(0, -1),
                        ),
                      ],
                    ),
                    child: Text(
                      'to ${destinationName ?? ''}',
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  // width: double.infinity,
                  child: inService
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _NextBusDetails(
                              estimatedArrival: nextBusEstimatedArrival,
                              loadColor: nextBusLoadColor,
                            ),
                            const Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                            ),
                            _NextBusDetails(
                              estimatedArrival: nextBus2EstimatedArrival,
                              loadColor: nextBus2LoadColor,
                            ),
                            const Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                            ),
                            _NextBusDetails(
                              estimatedArrival: nextBus3EstimatedArrival,
                              loadColor: nextBus3LoadColor,
                            ),
                          ],
                        )
                      : const Text('Not In Operation'),
                ),
              ),
              IconButton(
                onPressed: onPressedFavorite,
                icon:
                    Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NextBusDetails extends StatelessWidget {
  const _NextBusDetails({
    required this.estimatedArrival,
    required this.loadColor,
  });

  final String estimatedArrival;
  final Color loadColor;

  @override
  Widget build(BuildContext context) {
    return estimatedArrival != 'n/a'
        ? Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: loadColor,
                      width: 6, // Underline thickness
                    ),
                  ),
                ),
                child: Text(
                  estimatedArrival,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          )
        : Text(
            'n/a',
            style: Theme.of(context).textTheme.headline6,
          );
  }
}
