import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/widgets/box_info.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard(
      {@required this.serviceNo,
      @required this.nextBusEstimatedArrival,
      @required this.nextBus2EstimatedArrival,
      @required this.nextBus3EstimatedArrival,
      @required this.nextBusLoad,
      @required this.nextBusType,
      @required this.nextBusFeature});

  final String serviceNo;
  final String nextBusEstimatedArrival;
  final String nextBus2EstimatedArrival;
  final String nextBus3EstimatedArrival;
  final String nextBusLoad;
  final String nextBusType;
  final String nextBusFeature;

  @override
  Widget build(BuildContext context) {
    String getTimeToBusStop(String arrivalTime, [bool isSuffixShown]) {
      if (arrivalTime == '') {
        return 'n/a';
      }

      final String suffix = isSuffixShown != null && isSuffixShown ? 'min' : '';

      final int arrivalInMinutes =
          DateTime.parse(arrivalTime).difference(DateTime.now()).inMinutes;

      if (arrivalInMinutes <= 2) {
        return 'Arr';
      } else {
        return '${arrivalInMinutes.toString()}$suffix';
      }
    }

    final String estimatedArrivalNextTwoBus =
        '${getTimeToBusStop(nextBus2EstimatedArrival)}, ${getTimeToBusStop(nextBus3EstimatedArrival)}';

    final String nextBusTiming =
        getTimeToBusStop(nextBusEstimatedArrival, true);

    Widget _getBusFeature(dynamic wab) {
      if (wab != 'WAB') {
        return null;
      }

      return Icon(
        Icons.accessible,
        size: 25.0,
      );
    }

    String _getBusLoad(dynamic load) {
      final Map<String, String> _busLoad = <String, String>{
        'SEA': 'Seats Available',
        'SDA': 'Standing Available',
        'LSD': 'Limited Standing',
      };

      return load == '' ? '' : _busLoad[load];
    }

    Widget _getBusType(dynamic type) {
      final Map<String, String> _busType = <String, String>{
        'SD': 'Single Deck',
        'DD': 'Double Deck',
        'BD': 'Bendy',
      };

      return Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 3,
          bottom: 3,
        ),
        color: Theme.of(context).secondaryHeaderColor,
        child: Text(_busType[type]),
      );
    }

    Widget colorNextBusTiming(String nextBusTiming) {
      return Text(
        nextBusTiming,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BoxInfo(
                    color: Theme.of(context).primaryColorDark,
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Bus',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          serviceNo,
                          style: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                                top: 3,
                                bottom: 3,
                              ),
                              color: Theme.of(context).primaryColorLight,
                              child: Text(_getBusLoad(nextBusLoad)),
                            ),
                            _getBusFeature(nextBusFeature),
                          ],
                        ),
                        const SizedBox(height: 5),
                        _getBusType(nextBusType),
                      ],
                    ),
                  )
                ],
              ),
              BoxInfo(
                color: Theme.of(context).highlightColor,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: colorNextBusTiming(nextBusTiming),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          estimatedArrivalNextTwoBus,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
