import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';

import 'bus_service.dart';

class CustomSearchDelegate extends SearchDelegate {
  final _busService = locator<BusService>();
  final _analytics = locator<FirebaseAnalyticsService>().analytics;
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Color(0xB3FFFFFF)),
      ),
      primaryColor: theme.primaryColorDark,
      textTheme: theme.textTheme.copyWith(
        headline6: theme.textTheme.subtitle1.copyWith(color: Colors.white),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Search for bus stops';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          _analytics.logSearch(
            searchTerm: query,
          );
          print(query);
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        _analytics.logSearch(
          searchTerm: query,
        );
        print(query);
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResultView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResultView();
  }

  FutureBuilder<List<BusStopModel>> _buildSearchResultView() {
    return FutureBuilder<List<BusStopModel>>(
      future: _busService.findBusStops(query),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<BusStopModel>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final busStopList = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.only(top: 15.0),
            itemCount: busStopList.length,
            itemBuilder: (BuildContext context, int index) => BusStopView(
              busStopModel: busStopList[index],
              key: ValueKey<String>('busStopCard-$index'),
              searchTerm: query,
            ),
          );
        } else {
          return Column();
        }
      },
    );
  }
}
