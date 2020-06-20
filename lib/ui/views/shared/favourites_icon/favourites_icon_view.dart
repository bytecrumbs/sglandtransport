import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/shared/favourites_icon/favourites_icon_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FavouritesIconView extends StatelessWidget {
  FavouritesIconView({@required this.busStopCode});
  final String busStopCode;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouritesIconViewModel>.reactive(
      builder: (context, model, child) => IconButton(
        icon: Icon(model.isFavourited ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          model.toggleFavourite();
        },
      ),
      onModelReady: (model) async {
        await model.initialize(busStopCode);
      },
      viewModelBuilder: () => FavouritesIconViewModel(),
    );
  }
}
