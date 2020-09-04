import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/shared/tag/tag.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_arrival/bus_arrival_service_model.dart';

class BusArrivalServiceCardView extends StatelessWidget {
  const BusArrivalServiceCardView({
    Key key,
    @required this.busArrivalServiceModel,
  }) : super(key: key);

  final BusArrivalServiceModel busArrivalServiceModel;

  String getTimeToBusStop(String arrivalTime, [bool isSuffixShown = false]) {
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

  Widget _displayBusLoad(dynamic load, isSmallScreen) {
    var backgroundColor = Color.fromRGBO(244, 247, 248, 1);
    final _busLoad = {
      'SEA': 'Seats avail.',
      'SDA': isSmallScreen ? 'Standing\navail.' : 'Standing avail.',
      'LSD': isSmallScreen ? 'Limited\nstanding' : 'Limited standing',
    };

    if (load == 'SEA') {
      backgroundColor = Color.fromRGBO(0, 155, 96, 0.14);
    } else if (load == 'SDA') {
      backgroundColor = Color.fromRGBO(250, 107, 0, 0.14);
    } else {
      backgroundColor = Color.fromRGBO(255, 0, 0, 0.14);
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
                  getTimeToBusStop(model.estimatedArrival, true),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                )
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
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 11),
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
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: busArrivalServiceModel.nextBus != null &&
                      busArrivalServiceModel.nextBus2 != null &&
                      busArrivalServiceModel.nextBus3 != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _displayBusInfo(
                            busArrivalServiceModel.nextBus, isSmallScreen),
                        _displayBusInfo(
                            busArrivalServiceModel.nextBus2, isSmallScreen,
                            displayBorder: true),
                        _displayBusInfo(
                            busArrivalServiceModel.nextBus3, isSmallScreen,
                            displayBorder: true)
                      ],
                    )
                  : _displayNotInOperation(),
            ),
          )
        ],
      ),
    );
  }
}
