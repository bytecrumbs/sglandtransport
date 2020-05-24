import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/providers/bus/favorite_bus_stops_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    @required this.busStopCode,
  });

  final String busStopCode;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteBusStopsProvider>(
      builder: (
        BuildContext context,
        FavoriteBusStopsProvider provider,
        _,
      ) {
        final isFavoriteBusStop = provider.isFavoriteBusStop(busStopCode);
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
