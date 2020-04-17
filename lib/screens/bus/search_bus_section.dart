import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:http/io_client.dart' as http;
import '../../api.dart';
import 'bus_stops/bus_stop_card.dart';
import 'bus_stops/search_bar.dart';

class SearchBusStops extends StatefulWidget {
  @override
  _SearchBusStopsState createState() => _SearchBusStopsState();
}

class _SearchBusStopsState extends State<SearchBusStops> {
  Future<List<BusStopModel>> _future;
  final TextEditingController _controller = TextEditingController();
  List<BusStopModel> _busStops = <BusStopModel>[];
  final List<BusStopModel> _searchResult = <BusStopModel>[];

  void onSearchTextChanged(String value) {
    _searchResult.clear();
    if (value.isEmpty) {
      setState(() {});
      return;
    }

    for (final BusStopModel busStop in _busStops) {
      if (busStop.busStopCode.contains(value) == true)
        _searchResult.add(busStop);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _future = fetchBusStopList(http.IOClient());
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
          child: FutureBuilder<List<BusStopModel>>(
            future: _future,
            builder: (BuildContext context,
                AsyncSnapshot<List<BusStopModel>> snapshot) {
              if (snapshot.hasData) {
                _busStops = snapshot.data;
                return ListView.builder(
                  itemCount: _searchResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _searchResult.isNotEmpty
                        ? BusStopCard(
                            openContainer: () {},
                            busStopCode: _busStops[index].busStopCode,
                            description: _busStops[index].description,
                            roadName: _busStops[index].roadName,
                          )
                        : Container();
                  },
                );
              } else if (snapshot.hasError) {}
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
