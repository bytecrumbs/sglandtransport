import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus/search_bus_stops_service_provider.dart';
import 'package:provider/provider.dart';
import 'bus_stops/bus_stop_card.dart';
import 'bus_stops/search_bar.dart';

class SearchBusStops extends StatefulWidget {
  @override
  _SearchBusStopsState createState() => _SearchBusStopsState();
}

class _SearchBusStopsState extends State<SearchBusStops> {
  final TextEditingController _controller = TextEditingController();

  void onSearchTextChanged(String value) {
    context.read<SearchBusStopsServiceProvider>().findBusStops(value);
  }

  @override
  Widget build(BuildContext context) {
    final List<BusStopModel> busStopList =
        context.watch<SearchBusStopsServiceProvider>().busStopSearchList;
    return Column(
      children: <Widget>[
        SearchBar(
          controller: _controller,
          onSearchTextChanged: onSearchTextChanged,
        ),
        _buildSearchResultList(busStopList),
      ],
    );
  }

  Expanded _buildSearchResultList(List<BusStopModel> busStopList) {
    return Expanded(
      child: ListView.builder(
        itemCount: busStopList.length,
        itemBuilder: (BuildContext context, int index) => BusStopCard(
          key: ValueKey<String>('busStopCard-$index'),
          busStopModel: busStopList[index],
        ),
      ),
    );
  }
}
