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

  Future<List<BusStopModel>> _future;
  List<BusStopModel> _searchResult = <BusStopModel>[];

  void onSearchTextChanged(String value) {
    _searchResult.clear();
    if (value.isEmpty) {
      setState(() {});
      return;
    }
    _repo
        .getBusStopListBySearchText(value)
        .then((List<BusStopModel> data) => setState(() {
              _searchResult = data;
            }));
  }

  @override
  void initState() {
    super.initState();
    _future = _repo.getBusStopListBySearchText('');
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
                _searchResult = snapshot.data;
                return ListView.builder(
                  itemCount: _searchResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _searchResult.isNotEmpty
                        ? BusStopCard(
                            busStopModel: _searchResult[index],
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
