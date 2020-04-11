import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/search_bar.dart';

class SearchBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
