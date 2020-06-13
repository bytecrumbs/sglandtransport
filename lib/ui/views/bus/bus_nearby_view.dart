import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bus_nearby_viewmodel.dart';

class BusNearbyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusNearbyViewModel>.reactive(
      builder: (context, model, child) => Center(
        child: Text(model.title),
      ),
      viewModelBuilder: () => BusNearbyViewModel(),
    );
  }
}
