import 'package:flutter/material.dart';

import '../bus_repository.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    Key? key,
    required this.busArrivalModel,
  }) : super(key: key);

  final BusArrivalServicesModel busArrivalModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Text(busArrivalModel.serviceNo),
              const SizedBox(width: 10),
              Text(busArrivalModel.nextBus.destinationCode ?? ''),
            ],
          ),
          if (busArrivalModel.inService)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NextBusDetails(
                  estimatedArrival:
                      busArrivalModel.nextBus.getEstimatedArrival(),
                  loadDescription:
                      busArrivalModel.nextBus.getLoadLongDescription(),
                ),
                _NextBusDetails(
                  estimatedArrival:
                      busArrivalModel.nextBus2.getEstimatedArrival(),
                  loadDescription:
                      busArrivalModel.nextBus2.getLoadLongDescription(),
                ),
                _NextBusDetails(
                  estimatedArrival:
                      busArrivalModel.nextBus3.getEstimatedArrival(),
                  loadDescription:
                      busArrivalModel.nextBus3.getLoadLongDescription(),
                ),
              ],
            )
          else
            const Text('Not in Operation')
        ],
      ),
    );
  }
}

class _NextBusDetails extends StatelessWidget {
  const _NextBusDetails({
    Key? key,
    required this.estimatedArrival,
    required this.loadDescription,
  }) : super(key: key);

  final String estimatedArrival;
  final String loadDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(estimatedArrival),
        Text(loadDescription),
      ],
    );
  }
}
