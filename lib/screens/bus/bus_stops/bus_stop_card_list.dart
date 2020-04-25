import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card.dart';

class BusStopCardList extends StatelessWidget {
  const BusStopCardList({@required this.busStopList});

  final List<BusStopModel> busStopList;

  @override
  Widget build(BuildContext context) {
    print('BusStopCardList');
    return ListView.builder(
      itemCount: busStopList.length,
      itemBuilder: (BuildContext context, int index) {
        // return OpenContainer(
        //   transitionType: ContainerTransitionType.fade,
        //   openBuilder: (BuildContext _, VoidCallback openContainer) {
        //     return BusArrivalsScreen(busStopModel: busStopList[index]);
        //   },
        //   tappable: false,
        //   closedShape: const RoundedRectangleBorder(),
        //   closedElevation: 0.0,
        //   openColor: Theme.of(context).scaffoldBackgroundColor,
        //   closedColor: Theme.of(context).scaffoldBackgroundColor,
        //   closedBuilder: (BuildContext context, VoidCallback openContainer) {
        //     return BusStopCard(
        //       openContainer: openContainer,
        //       busStopModel: busStopList[index],
        //     );
        //   },
        // );
        return BusStopCard(
          key: ValueKey<String>('busStopCard-$index'),
          busStopModel: busStopList[index],
        );
      },
    );
  }
}
