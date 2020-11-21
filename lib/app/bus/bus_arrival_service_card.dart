import 'package:flutter/material.dart';

import 'models/bus_arrival_service_model.dart';
import 'tag.dart';

/// Show a single card of with all information related to a bus arrival
class BusArrivalServiceCard extends StatelessWidget {
  /// The constructor for the bus arrival service card
  const BusArrivalServiceCard({
    Key key,
    @required this.busArrivalServiceModel,
  }) : super(key: key);

  /// The model that is passed in and holds all the information for the bus
  /// arrival
  final BusArrivalServiceModel busArrivalServiceModel;

  /// returns the arrival time in minutes
  String getTimeToBusArrival(String arrivalTime, [bool isSuffixShown = false]) {
    if (arrivalTime == '' || arrivalTime == null) {
      return 'n/a';
    }

    final suffix = isSuffixShown && isSuffixShown ? 'min' : '';

    final arrivalInMinutes =
        DateTime.parse(arrivalTime).difference(DateTime.now()).inMinutes;

    return arrivalInMinutes <= 0
        ? 'Arr'
        : '${arrivalInMinutes.toString()}$suffix';
  }

  Widget _displayBusFeature(feature, arrivalTime) {
    if (feature != 'WAB' && arrivalTime != '') {
      return Container(
        margin: EdgeInsets.only(left: 5),
        child: Icon(
          Icons.accessible,
          color: Color(0xFFEF3340),
          size: 18.0,
        ),
      );
    }

    return const Text('');
  }

  Widget _displayBusLoad(dynamic load, isSmallScreen) {
    var backgroundColor = Color(0xFFF4F7F8);
    final _busLoad = {
      'SEA': 'Seats avail.',
      'SDA': isSmallScreen ? 'Standing\navail.' : 'Standing avail.',
      'LSD': isSmallScreen ? 'Limited\nstanding' : 'Limited standing',
    };

    if (load == 'SEA') {
      backgroundColor = Color(0x26009B60);
    } else if (load == 'SDA') {
      backgroundColor = Color(0x26FA6B00);
    } else {
      backgroundColor = Color(0x26FF0000);
    }

    return load != ''
        ? Tag(
            text: _busLoad[load],
            color: backgroundColor,
          )
        : Text('');
  }

  Widget _displayBusInfo(model, isSmallScreen, {displayBorder}) {
    var hasBorder =
        !isSmallScreen && displayBorder == (true && displayBorder != null);

    return Container(
      padding: EdgeInsets.only(left: hasBorder ? 10 : 0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: hasBorder ? Colors.grey[300] : Colors.white,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Text(
                  getTimeToBusArrival(model.estimatedArrival, true),
                  style: const TextStyle(
                    color: Color(0xFF25304D),
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                  ),
                ),
                _displayBusFeature(model.feature, model.estimatedArrival)
              ],
            ),
          ),
          _displayBusLoad(model.load, isSmallScreen)
        ],
      ),
    );
  }

  Widget _displayNotInOperation() {
    return Container(
      child: Text(
        'Not in operation',
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 340;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  '${busArrivalServiceModel.serviceNo}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              _buildDisplayDestination()
            ],
          ),
          Container(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: busArrivalServiceModel.nextBus != null &&
                      busArrivalServiceModel.nextBus2 != null &&
                      busArrivalServiceModel.nextBus3 != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _displayBusInfo(
                            busArrivalServiceModel.nextBus,
                            isSmallScreen,
                          ),
                        ),
                        Expanded(
                          child: _displayBusInfo(
                            busArrivalServiceModel.nextBus2,
                            isSmallScreen,
                            displayBorder: true,
                          ),
                        ),
                        Expanded(
                          child: _displayBusInfo(
                            busArrivalServiceModel.nextBus3,
                            isSmallScreen,
                            displayBorder: true,
                          ),
                        ),
                      ],
                    )
                  : _displayNotInOperation(),
            ),
          )
        ],
      ),
    );
  }

  Container _buildDisplayDestination() {
    if (busArrivalServiceModel.destinationName != null) {
      return Container(
        margin: EdgeInsets.only(left: 1),
        padding: EdgeInsets.fromLTRB(7, 4, 10, 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Text(
          'to ${busArrivalServiceModel.destinationName}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      );
    }
    return Container(
      child: Text(''),
    );
  }
}
