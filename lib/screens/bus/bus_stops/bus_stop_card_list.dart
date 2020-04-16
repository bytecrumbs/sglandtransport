import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart' as http;
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card.dart';

class BusStopCardList extends StatefulWidget {
  @override
  _BusStopCardListState createState() => _BusStopCardListState();
}

class _BusStopCardListState extends State<BusStopCardList> {
  Future<List<BusStopModel>> _future;
  List<BusStopModel> busStops = <BusStopModel>[];
  final List<BusStopModel> _searchResult = <BusStopModel>[];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = fetchBusStopList(http.IOClient());
  }

  void dismissFocus() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void onSearchTextChanged(String value) {
    _searchResult.clear();
    if (value.isEmpty) {
      setState(() {});
      return;
    }

    for (final BusStopModel busStop in busStops) {
      if (busStop.busStopCode.contains(value) == true)
        _searchResult.add(busStop);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<BusStopModel>>(
            future: _future,
            builder: (BuildContext context,
                AsyncSnapshot<List<BusStopModel>> snapshot) {
              if (snapshot.hasData) {
                busStops = snapshot.data;
                return ListView.builder(
                  itemCount: _searchResult.isNotEmpty
                      ? _searchResult.length
                      : busStops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _searchResult.isNotEmpty
                        ? OpenContainer(
                            transitionType: ContainerTransitionType.fade,
                            openBuilder:
                                (BuildContext _, VoidCallback openContainer) {
                              dismissFocus();
                              return BusArrivalsScreen(
                                busStopCode: _searchResult[index].busStopCode,
                                description: _searchResult[index].description,
                                roadName: _searchResult[index].roadName,
                              );
                            },
                            tappable: false,
                            closedShape: const RoundedRectangleBorder(),
                            closedElevation: 0.0,
                            openColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            closedColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            closedBuilder: (BuildContext context,
                                VoidCallback openContainer) {
                              return BusStopCard(
                                openContainer: openContainer,
                                busStopCode: _searchResult[index].busStopCode,
                                description: _searchResult[index].description,
                                roadName: _searchResult[index].roadName,
                              );
                            },
                          )
                        : OpenContainer(
                            transitionType: ContainerTransitionType.fade,
                            openBuilder:
                                (BuildContext _, VoidCallback openContainer) {
                              dismissFocus();
                              return BusArrivalsScreen(
                                busStopCode: busStops[index].busStopCode,
                                description: busStops[index].description,
                                roadName: busStops[index].roadName,
                              );
                            },
                            tappable: false,
                            closedShape: const RoundedRectangleBorder(),
                            closedElevation: 0.0,
                            openColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            closedColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            closedBuilder: (BuildContext context,
                                VoidCallback openContainer) {
                              return BusStopCard(
                                openContainer: openContainer,
                                busStopCode: busStops[index].busStopCode,
                                description: busStops[index].description,
                                roadName: busStops[index].roadName,
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
        )
      ],
    );
  }
}
