import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../shared/palette.dart';
import '../bus_repository.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    Key? key,
    required this.busArrivalModel,
    required this.onPressedFavorite,
  }) : super(key: key);

  final BusArrivalServicesModel busArrivalModel;
  final VoidCallback onPressedFavorite;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.15,
        children: [
          SlidableAction(
            autoClose: false,
            onPressed: (_) {
              onPressedFavorite();
            },
            icon: busArrivalModel.isFavorite
                ? Icons.favorite
                : Icons.favorite_outline,
            backgroundColor: kMainBackgroundColor,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
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
                    busArrivalModel.serviceNo,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
                if (busArrivalModel.inService)
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
                      'to ${busArrivalModel.destinationName ?? ''}',
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
                          loadColor: busArrivalModel.nextBus.getLoadColor(),
                        ),
                        const Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                        ),
                        _NextBusDetails(
                          estimatedArrival:
                              busArrivalModel.nextBus2.getEstimatedArrival(),
                          loadDescription:
                              busArrivalModel.nextBus2.getLoadLongDescription(),
                          loadColor: busArrivalModel.nextBus2.getLoadColor(),
                        ),
                        const Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                        ),
                        _NextBusDetails(
                          estimatedArrival:
                              busArrivalModel.nextBus3.getEstimatedArrival(),
                          loadDescription:
                              busArrivalModel.nextBus3.getLoadLongDescription(),
                          loadColor: busArrivalModel.nextBus3.getLoadColor(),
                        ),
                      ],
                    )
                  : Row(
                      children: const [
                        Text('Not In Operation'),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextBusDetails extends StatelessWidget {
  const _NextBusDetails({
    Key? key,
    required this.estimatedArrival,
    required this.loadDescription,
    required this.loadColor,
  }) : super(key: key);

  final String estimatedArrival;
  final String loadDescription;
  final Color loadColor;

  @override
  Widget build(BuildContext context) {
    return estimatedArrival != 'n/a'
        ? Column(
            children: [
              Container(
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
              // Container(
              //   padding: const EdgeInsets.only(
              //     left: 3,
              //     right: 3,
              //     top: 3,
              //     bottom: 3,
              //   ),
              //   decoration: BoxDecoration(
              //     color: loadColor,
              //     borderRadius: BorderRadius.circular(6),
              //   ),
              //   child: Text(
              //     loadDescription,
              //     style: Theme.of(context).textTheme.caption,
              //   ),
              // ),
            ],
          )
        : Text(
            'n/a',
            style: Theme.of(context).textTheme.subtitle1,
          );
  }
}
