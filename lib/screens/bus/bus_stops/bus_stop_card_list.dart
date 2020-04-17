import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card.dart';

class BusStopCardList extends StatelessWidget {
  const BusStopCardList({@required this.busStopList});

  final Future<List<BusStopModel>> busStopList;

  // void dismissFocus() {
  //   final FocusScopeNode currentFocus = FocusScope.of(context);

  //   if (!currentFocus.hasPrimaryFocus) {
  //     currentFocus.unfocus();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<BusStopModel>>(
        future: busStopList,
        builder:
            (BuildContext context, AsyncSnapshot<List<BusStopModel>> snapshot) {
          if (snapshot.hasData) {
            final List<BusStopModel> busStops = snapshot.data;
            return ListView.builder(
              itemCount: busStops.length,
              itemBuilder: (BuildContext context, int index) {
                return OpenContainer(
                  transitionType: ContainerTransitionType.fade,
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    // dismissFocus();
                    return BusArrivalsScreen(busStopModel: busStops[index]);
                  },
                  tappable: false,
                  closedShape: const RoundedRectangleBorder(),
                  closedElevation: 0.0,
                  openColor: Theme.of(context).scaffoldBackgroundColor,
                  closedColor: Theme.of(context).scaffoldBackgroundColor,
                  closedBuilder:
                      (BuildContext context, VoidCallback openContainer) {
                    return BusStopCard(
                      openContainer: openContainer,
                      busStopModel: busStops[index],
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {}
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
