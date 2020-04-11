import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/search_bar.dart';

class BusStops extends StatelessWidget {
  static const String id = 'bus_stops_screen';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(),
        BusStopCardList(),
      ],
    );
  }
}
