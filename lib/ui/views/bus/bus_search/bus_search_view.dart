import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bus_search_viewmodel.dart';

class BusSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusSearchViewModel>.reactive(
      builder: (context, model, child) => Center(
        child: Text(model.title),
      ),
      viewModelBuilder: () => BusSearchViewModel(),
    );
  }
}
