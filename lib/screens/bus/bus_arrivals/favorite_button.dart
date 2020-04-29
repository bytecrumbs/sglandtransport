import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus/bus_favorites_service_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    @required this.busStopModel,
  });

  final BusStopModel busStopModel;

  Future<bool> _isFavoriteBusStop(
      BuildContext context, BusStopModel busStopModel) async {
    return await Provider.of<BusFavoritesServiceProvider>(context,
            listen: false)
        .isFavoriteBusStop(busStopModel);
  }

  @override
  Widget build(BuildContext context) {
    print('FavoriteButton');
    return IconButton(
      key: const ValueKey<String>('favoriteIconButton'),
      onPressed: () async {
        await Provider.of<BusFavoritesServiceProvider>(context, listen: false)
            .toggleFavoriteBusStop(busStopModel);
      },
      icon: FutureBuilder<bool>(
        future: _isFavoriteBusStop(context, busStopModel),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data
                ? Icon(
                    Icons.favorite,
                    key: const ValueKey<String>('favoriteIconSelected'),
                  )
                : Icon(
                    Icons.favorite_border,
                    key: const ValueKey<String>('favoriteIconUnselected'),
                  );
          } else {
            return Icon(
              Icons.favorite_border,
              key: const ValueKey<String>('favoriteIconUnselected'),
            );
          }
        },
      ),
    );
  }
}
