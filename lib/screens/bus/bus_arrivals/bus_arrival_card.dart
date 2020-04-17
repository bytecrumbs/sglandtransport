import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/widgets/box_info.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    @required this.busArrivalServiceModel,
  });

  final BusArrivalServiceModel busArrivalServiceModel;

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
        '${getTimeToBusStop(busArrivalServiceModel.nextBus2.estimatedArrival)}, ${getTimeToBusStop(busArrivalServiceModel.nextBus3.estimatedArrival)}';

    final String nextBusTiming =
        getTimeToBusStop(busArrivalServiceModel.nextBus.estimatedArrival, true);

    Widget _getBusFeature(dynamic wab) {
      if (wab != 'WAB') {
        return null;
      }

      return Icon(
        Icons.accessible,
        size: 22.0,
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
        child: Text(_busType[type], style: const TextStyle(fontSize: 11.5)),
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
                          busArrivalServiceModel.serviceNo,
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
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 3,
                            bottom: 3,
                          ),
                          color: Theme.of(context).primaryColorLight,
                          child: Text(
                              _getBusLoad(busArrivalServiceModel.nextBus.load),
                              style: const TextStyle(fontSize: 11.5)),
                        ),
                        const SizedBox(height: 5),
                        _getBusType(busArrivalServiceModel.nextBus.type),
                        _getBusFeature(busArrivalServiceModel.nextBus.feature)
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
