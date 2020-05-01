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
    return Consumer<FavoriteBusStopsServiceProvider>(
      builder: (
        BuildContext context,
        FavoriteBusStopsServiceProvider provider,
        _,
      ) {
        final bool isFavoriteBusStop = provider.isFavoriteBusStop(busStopCode);
        return IconButton(
          key: const ValueKey<String>('favoriteIconButton'),
          onPressed: () async {
            await provider.toggleFavoriteBusStop(
                busStopCode, isFavoriteBusStop);
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
      },
    );
  }
}
