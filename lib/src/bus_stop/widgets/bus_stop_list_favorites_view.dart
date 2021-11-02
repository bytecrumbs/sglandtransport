import 'package:flutter/material.dart';

class BusStopListFavoritesView extends StatelessWidget {
  const BusStopListFavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Text('Favorites'),
    );
  }
}
