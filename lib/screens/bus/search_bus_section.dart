import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/data/bus_stop_list_repository.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'bus_stops/bus_stop_card.dart';
import 'bus_stops/search_bar.dart';

class SearchBusStops extends StatefulWidget {
  @override
  _SearchBusStopsState createState() => _SearchBusStopsState();
}

class _SearchBusStopsState extends State<SearchBusStops> {
  static final BusStopListRepository _repo = BusStopListRepository();
  final TextEditingController _controller = TextEditingController();
  List<BusStopModel> _searchResult = <BusStopModel>[];

  void onSearchTextChanged(String value) {
    _searchResult.clear();
    _repo
        .getBusStopListBySearchText(value)
        .then((List<BusStopModel> data) => setState(() {
              _searchResult = data;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          controller: _controller,
          onSearchTextChanged: onSearchTextChanged,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: _searchResult.length,
                itemBuilder: (BuildContext context, int index) => BusStopCard(
                      busStopModel: _searchResult[index],
                    ))),
      ],
    );
  }
}
