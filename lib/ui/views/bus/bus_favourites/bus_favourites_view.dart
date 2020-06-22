import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/shared/favourites_icon/favourites_icon_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_favourites_viewmodel.dart';

class BusFavouritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusFavouritesViewModel>.reactive(
      builder: (context, model, child) => Center(
        // model will indicate busy until the future is fetched
        child: model.isBusy
            ? CircularProgressIndicator()
            : !model.hasError
                ? Column(
                    children: <Widget>[
                      AddRemoveFavourites(
                        model: model,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              title: Text(model.data[index]),
                              onTap: () => model.navigateToBusArrival(
                                model.data[index],
                                'description',
                              ),
                            ),
                          ),
                          itemCount: model.data.length,
                        ),
                      ),
                    ],
                  )
                : Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text(
                      model.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
      ),
      viewModelBuilder: () => BusFavouritesViewModel(),
    );
  }
}

class AddRemoveFavourites extends StatelessWidget {
  AddRemoveFavourites({@required this.model});
  final BusFavouritesViewModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('78129'),
            FavouritesIconView(
              busStopCode: '78129',
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('78111'),
            FavouritesIconView(
              busStopCode: '78111',
            ),
          ],
        ),
      ],
    );
  }
}
