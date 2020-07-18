import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lta_datamall_flutter/ui/views/shared/favourites_icon/favourites_icon_view.dart';
import 'package:lta_datamall_flutter/ui/views/shared/staggered_animation/staggered_animation.dart';
import 'package:stacked/stacked.dart';

import 'bus_arrival_service_card_view.dart';
import 'bus_arrival_viewmodel.dart';

class BusArrivalView extends StatelessWidget {
  BusArrivalView({
    @required this.busStopCode,
    @required this.description,
  });
  final String busStopCode;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusArrivalViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(description),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FavouritesIconView(busStopCode: busStopCode),
            ),
          ],
        ),
        body: Center(
          child: model.busArrivalList.isEmpty
              ? CircularProgressIndicator()
              : AnimationLimiter(
                  child: MediaQuery.removePadding(
                    context: context,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: model.busArrivalList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final currentBusService = model.busArrivalList[index];
                          return StaggeredAnimation(
                            index: index,
                            child: BusArrivalServiceCardView(
                              key: ValueKey<String>('busArrivalCard-$index'),
                              busArrivalServiceModel: currentBusService,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ),
      ),
      viewModelBuilder: () => BusArrivalViewModel(),
      onModelReady: (model) {
        model.initialise(busStopCode);
      },
    );
  }
}
