import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:lta_datamall_flutter/ui/views/shared/search_bar/search_bar_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_search_viewmodel.dart';

class BusSearchView extends StatelessWidget {
  TextEditingController useTextEditingController() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusSearchViewModel>.reactive(
      builder: (context, model, child) => Container(
          child: Column(children: <Widget>[
        SearchBar(
          key: Key('SearchBar'),
          controller: useTextEditingController(),
          onSearchTextChanged: model.onSearchTextChanged,
        ),
        _buildSearchResultList(model.busStopSearchList)
      ])),
      viewModelBuilder: () => BusSearchViewModel(),
    );
  }

  Expanded _buildSearchResultList(List<BusStopModel> busStopList) {
    return Expanded(
      child: ListView.builder(
        itemCount: busStopList.length,
        itemBuilder: (BuildContext context, int index) => BusStopView(
          busStopModel: busStopList[index],
          key: ValueKey<String>('busStopCard-$index'),
        ),
      ),
    );
  }
}
