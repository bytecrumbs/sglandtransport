import 'package:flutter/material.dart';
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
        child: SearchBar(
          onSearchTextChanged: model.onSearchTextChanged,
          controller: useTextEditingController(),
        ),
      ),
      viewModelBuilder: () => BusSearchViewModel(),
    );
  }
}
