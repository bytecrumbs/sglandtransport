import 'package:flutter/material.dart';

import '../../shared/palette.dart';
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
                  busArrivalModel.serviceNo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
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
                // TODO: show the destination name, not just the code
                child: Text(
                  'to ${busArrivalModel.nextBus.destinationCode ?? ''}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: busArrivalModel.inService
                ? Row(
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
                : const Text('Not in Operation'),
          ),
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
