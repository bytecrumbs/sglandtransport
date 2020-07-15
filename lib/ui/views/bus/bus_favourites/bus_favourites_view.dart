import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:lta_datamall_flutter/ui/views/shared/staggered_animation/staggered_animation.dart';
import 'package:stacked/stacked.dart';
import 'bus_favourites_viewmodel.dart';

class BusFavouritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusFavouritesViewModel>.reactive(
      builder: (context, model, child) => Container(
        // model will indicate busy until the future is fetched
        child: model.favouriteBusStops.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    'No favorite bus stops found...',
                    key: ValueKey('noFavouriteBusStopsFound'),
                  ),
                ),
              )
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: model.favouriteBusStops.length,
                itemBuilder: (BuildContext context, int index) {
                  return StaggeredAnimation(
                    index: index,
                    child: BusStopView(
                      busStopModel: model.favouriteBusStops[index],
                      key: ValueKey<String>('busStopCard-$index'),
                    ),
                  );
                },
              ),
      ),
      viewModelBuilder: () => BusFavouritesViewModel(),
      onModelReady: (model) async {
        await model.initialise();
      },
    );
  }
}
