import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_nearby_viewmodel.dart';

class BusNearbyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusNearByViewModel>.reactive(
      builder: (context, model, child) => Center(
        child: model.isBusy || model.nearByBusStopList.isEmpty
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: model.nearByBusStopList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: BusStopView(
                              busStopModel: model.nearByBusStopList[index],
                              key: ValueKey<String>('busStopCard-$index'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
      viewModelBuilder: () => BusNearByViewModel(),
    );
  }
}
