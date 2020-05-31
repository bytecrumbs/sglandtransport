import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/widgets/box_info.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    Key key,
    @required this.busArrivalServiceModel,
  }) : super(key: key);

  final BusArrivalServiceModel busArrivalServiceModel;

  String getTimeToBusStop(String arrivalTime, [bool isSuffixShown = false]) {
    if (arrivalTime == '') {
      return 'n/a';
    }

    final suffix = isSuffixShown && isSuffixShown ? 'min' : '';

    final arrivalInMinutes =
        DateTime.parse(arrivalTime).difference(DateTime.now()).inMinutes;

    return arrivalInMinutes <= 0
        ? 'Arr'
        : '${arrivalInMinutes.toString()}$suffix';
  }

  String _getBusLoad(dynamic load) {
    final _busLoad = {
      'SEA': 'Seats Available',
      'SDA': 'Standing Available',
      'LSD': 'Limited Standing',
    };

    return load == '' ? '' : _busLoad[load];
  }

  String _busTypes(dynamic type) {
    final _busType = {
      'SD': 'Single Deck',
      'DD': 'Double Deck',
      'BD': 'Bendy',
    };

    return _busType[type];
  }

  Widget _displayBusNumber() {
    return Column(
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
    );
  }

  Widget _displayBusLoad(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 3,
        bottom: 3,
      ),
      color: Theme.of(context).primaryColorLight,
      child: Text(_getBusLoad(busArrivalServiceModel.nextBus.load),
          style: const TextStyle(fontSize: 11.5)),
    );
  }

  Widget _displayBusType(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 3,
        bottom: 3,
      ),
      color: Theme.of(context).secondaryHeaderColor,
      child: Text(
        _busTypes(busArrivalServiceModel.nextBus.type),
        style: const TextStyle(fontSize: 11.5),
      ),
    );
  }

  Widget _displayBusFeature() {
    if (busArrivalServiceModel.nextBus.feature != 'WAB') {
      return const Text('');
    }

    return Icon(
      Icons.accessible,
      size: 22.0,
    );
  }

  Widget _displayNextBusTiming() {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: Text(
        getTimeToBusStop(busArrivalServiceModel.nextBus.estimatedArrival, true),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _displayNotInOperation() {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: Text(
        'Not In\nOperation',
        style: const TextStyle(
          fontSize: 11.5,
        ),
      ),
    );
  }

  Widget _displayNextTwoBusTiming() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${getTimeToBusStop(busArrivalServiceModel.nextBus2.estimatedArrival)}, ${getTimeToBusStop(busArrivalServiceModel.nextBus3.estimatedArrival)}',
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                    child: _displayBusNumber(),
                  ),
                  busArrivalServiceModel.inService ?? true
                      ? Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _displayBusLoad(context),
                              const SizedBox(height: 5),
                              _displayBusType(context),
                              _displayBusFeature()
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
              BoxInfo(
                color: Theme.of(context).highlightColor,
                child: busArrivalServiceModel.inService ?? true
                    ? Column(
                        children: <Widget>[
                          _displayNextBusTiming(),
                          _displayNextTwoBusTiming()
                        ],
                      )
                    : Center(
                        child: Container(
                          child: _displayNotInOperation(),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
