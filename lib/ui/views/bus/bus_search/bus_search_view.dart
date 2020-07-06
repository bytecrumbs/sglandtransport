import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:lta_datamall_flutter/ui/views/shared/search_bar/search_bar_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'bus_search_viewmodel.dart';

class BusSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusSearchViewModel>.nonReactive(
      viewModelBuilder: () => BusSearchViewModel(),
      builder: (context, model, _) => Container(child: SerachResultView()),
    );
  }
}

class SerachResultView extends HookViewModelWidget<BusSearchViewModel> {
  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusSearchViewModel model,
  ) {
    var textEditViewController = useTextEditingController();
    return Column(
      children: <Widget>[
        SearchBar(
          key: Key('SearchBar'),
          controller: textEditViewController,
          onSearchTextChanged: model.onSearchTextChanged,
        ),
        _buildSearchResultView(model)
      ],
    );
  }

  Container _buildSearchResultView(BusSearchViewModel model) {
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
