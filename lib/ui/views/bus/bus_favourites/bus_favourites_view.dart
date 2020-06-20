import 'package:flutter/material.dart';
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
                            child: Text(model.data[index]),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('010101'),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                model.addBusStop('010101');
              },
            ),
            RaisedButton(
              child: Text('Remove'),
              onPressed: () {
                model.removeBusStop('010101');
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('020202'),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                model.addBusStop('020202');
              },
            ),
            RaisedButton(
              child: Text('Remove'),
              onPressed: () {
                model.removeBusStop('020202');
              },
            ),
          ],
        ),
      ],
    );
  }
}
