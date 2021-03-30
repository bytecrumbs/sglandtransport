import 'package:flutter/material.dart';

import 'models/bus_arrival_service_model.dart';
import 'models/next_bus_model.dart';
import 'tag.dart';

/// Show a single card of with all information related to a bus arrival
class BusArrivalServiceCard extends StatelessWidget {
  /// The constructor for the bus arrival service card
  const BusArrivalServiceCard({
    Key? key,
    required this.busArrivalServiceModel,
  }) : super(key: key);

  /// The model that is passed in and holds all the information for the bus
  /// arrival
  final BusArrivalServiceModel busArrivalServiceModel;

  /// returns the arrival time in minutes
  String getTimeToBusArrival({
    required String arrivalTime,
    bool isSuffixShown = false,
  }) {
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

  Widget _displayBusFeature(String feature, String arrivalTime) {
    if (feature != 'WAB' && arrivalTime != '') {
      return Container(
        margin: const EdgeInsets.only(left: 5),
        child: const Icon(
          Icons.accessible,
          color: Color(0xFFEF3340),
          size: 18,
        ),
      );
    }

    return const Text('');
  }

  Widget _displayBusLoad(String load, bool isSmallScreen) {
    var backgroundColor = const Color(0xFFF4F7F8);
    final _busLoad = {
      'SEA': 'Seats avail.',
      'SDA': isSmallScreen ? 'Standing\navail.' : 'Standing avail.',
      'LSD': isSmallScreen ? 'Limited\nstanding' : 'Limited standing',
    };

    if (load == 'SEA') {
      backgroundColor = const Color(0x26009B60);
    } else if (load == 'SDA') {
      backgroundColor = const Color(0x26FA6B00);
    } else {
      backgroundColor = const Color(0x26FF0000);
    }

    return load != ''
        ? Tag(
            text: _busLoad[load],
            color: backgroundColor,
          )
        : const Text('');
  }

  Widget _displayBusInfo(
    NextBusModel model,
    bool isSmallScreen, {
    bool displayBorder,
  }) {
    final hasBorder =
        !isSmallScreen && displayBorder == (true && displayBorder != null);

    return Container(
      padding: EdgeInsets.only(left: hasBorder ? 10 : 0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: hasBorder ? Colors.grey[300] : Colors.white,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Text(
                  getTimeToBusArrival(
                    arrivalTime: model.estimatedArrival,
                    isSuffixShown: true,
                  ),
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
    return const Text(
      'Not in operation',
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 340;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  busArrivalServiceModel.serviceNo,
                  style: const TextStyle(
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
            width: MediaQuery.of(context).size.width,
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
          )
        ],
      ),
    );
  }

  Container _buildDisplayDestination() {
    if (busArrivalServiceModel.destinationName != null) {
      return Container(
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
          'to ${busArrivalServiceModel.destinationName}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      );
    }
    return Container();
  }
}
