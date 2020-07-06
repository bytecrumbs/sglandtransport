import 'package:flutter/material.dart';
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
    return ViewModelBuilder<BusSearchViewModel>.nonReactive(
      viewModelBuilder: () => BusSearchViewModel(),
      builder: (context, model, _) => Container(
        child: Column(
          children: <Widget>[
            SearchBar(
              key: Key('SearchBar'),
              controller: useTextEditingController(),
              onSearchTextChanged: model.onSearchTextChanged,
            ),
            SerachResultView()
          ],
        ),
      ),
    );
  }
}

class SerachResultView extends ViewModelWidget<BusSearchViewModel> {
  @override
  Widget build(BuildContext context, BusSearchViewModel model) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: model.busStopSearchList.length,
        itemBuilder: (BuildContext context, int index) => BusStopView(
          busStopModel: model.busStopSearchList[index],
          key: ValueKey<String>('busStopCard-$index'),
        ),
      ),
    );
  }
}
