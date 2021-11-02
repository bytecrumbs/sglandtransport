import 'package:flutter/material.dart';

class BusStopListFavorites extends StatelessWidget {
  const BusStopListFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Text('Favorites'),
    );
  }
}
