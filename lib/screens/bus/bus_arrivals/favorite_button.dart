import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/services/bus/favorite_bus_stops_service_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    @required this.busStopCode,
  });

  final String busStopCode;

  @override
  Widget build(BuildContext context) {
    final bool isFavoriteBusStop =
        Provider.of<FavoriteBusStopsServiceProvider>(context)
            .isFavoriteBusStop(busStopCode);
    return IconButton(
      key: const ValueKey<String>('favoriteIconButton'),
      onPressed: () async {
        await Provider.of<FavoriteBusStopsServiceProvider>(context,
                listen: false)
            .toggleFavoriteBusStop(busStopCode, isFavoriteBusStop);
      },
      icon: isFavoriteBusStop
          ? Icon(
              Icons.favorite,
              key: const ValueKey<String>('favoriteIconSelected'),
            )
          : Icon(
              Icons.favorite_border,
              key: const ValueKey<String>('favoriteIconUnselected'),
            ),
    );
  }
}
